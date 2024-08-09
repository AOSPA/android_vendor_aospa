#!/usr/bin/env python3

# roomservice: Android device repository management utility.
# Copyright (C) 2013 Cybojenix <anthonydking@gmail.com>
# Copyright (C) 2013 The OmniROM Project
# Copyright (C) 2015-2019 ParanoidAndroid Project
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import json
import os
import sys
from xml.dom import minidom
from xml.etree import ElementTree as ET

extra_manifests_dir = '.repo/manifests/'
upstream_manifest_path = '.repo/manifest.xml'
local_manifests_dir = '.repo/local_manifests'
roomservice_manifest_path = local_manifests_dir + '/roomservice.xml'
dependencies_json_path = 'vendor/aospa/products/%s/aospa.dependencies'

def indent(elem):
    """Return a pretty-printed XML string for the Element."""
    rough_string = ET.tostring(elem, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    pretty_str = reparsed.toprettyxml(indent="  ", encoding='utf-8').decode()
    return '\n'.join(filter(str.strip, pretty_str.splitlines()))

def recurse_include(manifest):
    includes = manifest.findall('include')
    if includes is not None:
        for file in includes:
            extra_manifest = ET.parse(extra_manifests_dir + file.get('name')).getroot()
            for elem in extra_manifest:
                manifest.append(elem)
            for elem in recurse_include(extra_manifest):
                manifest.append(elem)
    return manifest

if __name__ == '__main__':
    if not os.path.isdir(local_manifests_dir):
        os.mkdir(local_manifests_dir)

    if len(sys.argv) <= 1:
        raise ValueError('The first argument must be the product.')
    product = sys.argv[1]

    try:
        device = product[product.index('_') + 1:]
    except ValueError:
        device = product

    dependencies_json_path %= device
    if not os.path.isfile(dependencies_json_path):
        raise ValueError('No dependencies file could be found for the device (%s).' % device)
    dependencies = json.loads(open(dependencies_json_path, 'r').read())

    try:
        upstream_manifest = ET.parse(upstream_manifest_path).getroot()
    except (IOError, ET.ParseError):
        upstream_manifest = ET.Element('manifest')

    recurse_include(upstream_manifest)

    try:
        roomservice_manifest = ET.parse(roomservice_manifest_path).getroot()
    except (IOError, ET.ParseError):
        roomservice_manifest = ET.Element('manifest')

    syncable_projects = []

    mentioned_projects = []

    # Clean up all the <remove-project> elements.
    for removable_project in roomservice_manifest.findall('remove-project'):
        name = removable_project.get('name')

        path = None
        for project in upstream_manifest.findall('project'):
            if project.get('name') == name:
                path = project.get('path')
                break

        if path is None:
            # The upstream manifest doesn't know this project, so drop it.
            roomservice_manifest.remove(removable_project)
            continue

        found_in_dependencies = False
        for dependency in dependencies:
            if dependency.get('target_path') == path:
                found_in_dependencies = True
                break

        if not found_in_dependencies:
            # We don't need special dependencies for this project, so drop it and sync it up.
            roomservice_manifest.remove(removable_project)
            syncable_projects.append(path)
            for project in roomservice_manifest.findall('project'):
                if project.get('path') == path:
                    roomservice_manifest.remove(project)
                    break

    # Make sure our <project> elements are set.
    for dependency in dependencies:
        path = dependency.get('target_path')
        name = dependency.get('repository')
        remote = dependency.get('remote')
        revision = dependency.get('revision')
        clone_depth = dependency.get('clone-depth')
        linkfiles = dependency.get('linkfiles', [])

        # Store path of every repositories mentioned in dependencies.
        mentioned_projects.append(path)

        # Make sure the required remote exists in the upstream manifest.
        found_remote = False
        for known_remote in upstream_manifest.findall('remote'):
            if known_remote.get('name') == remote:
                found_remote = True
                break
        if not found_remote:
            raise ValueError('No remote declaration could be found for the %s project. (%s)' % (name, remote))

        modified_project = False
        found_in_roomservice = False

        # In case the project was already added, update it.
        for project in roomservice_manifest.findall('project'):
            if project.get('name') == name or project.get('path') == path:
                if found_in_roomservice:
                    roomservice_manifest.remove(project)
                else:
                    found_in_roomservice = True
                    msg = ''
                    if project.get('path') != path:
                        modified_project = True
                        project.set('path', path)
                        msg += f'--> Path        : Updated {project.get("path")} to {path}\n'
                    if project.get('remote') != remote:
                        modified_project = True
                        project.set('remote', remote)
                        msg += f'--> Remote      : Updated {project.get("remote")} to {remote}\n'
                    if project.get('revision') != revision:
                        modified_project = True
                        project.set('revision', revision)
                        msg += f'--> Revision    : Updated {project.get("revision")} to {revision}\n'
                    if project.get('clone-depth') != clone_depth:
                        modified_project = True
                        project.set('clone-depth', clone_depth)
                        msg += f'--> Clone depth : Updated {project.get("clone-depth")} to {clone_depth}\n'
                    if project.get('name') != name:
                        modified_project = True
                        project.set('name', name)
                        msg += f'--> Repository  : Updated {project.get("name")} to {name}\n'

                    new_linkfiles = {(lf['src'], lf['dest']) for lf in linkfiles}
                    prev_linkfiles = {(lf.get('src'), lf.get('dest')) for lf in project.findall('linkfile')}
                    if new_linkfiles != prev_linkfiles:
                        modified_project = True
                        for lf in project.findall('linkfile'):
                            project.remove(lf)
                        for src, dest in new_linkfiles:
                            ET.SubElement(project, 'linkfile', {'src': src, 'dest': dest})
                        msg += f'--> Linkfiles   : Updated\n'

                    if modified_project:
                        print(f'\n{name} changed:\n{msg}')

        # In case the project was not already added, create it.
        if not found_in_roomservice:
            print('Adding dependency:')
            print(f'--> Repository  : {name}')
            print(f'--> Path        : {path}')
            print(f'--> Revision    : {revision}')
            print(f'--> Remote      : {remote}')
            found_in_roomservice = True
            modified_project = True
            attributes = {
                'path': path,
                'name': name,
                'remote': remote,
                'revision': revision,
            }

            if clone_depth is not None:
                attributes['clone-depth'] = clone_depth
                print(f'--> Clone depth : {clone_depth}')

            new_project = ET.Element('project', attrib=attributes)

            for linkfile in linkfiles:
                ET.SubElement(new_project, 'linkfile', {'src': linkfile['src'], 'dest': linkfile['dest']})
                print(f"--> Linkfile    : {linkfile['src']} -> {linkfile['dest']}")

            print('\n')

            roomservice_manifest.append(new_project)

        # In case the project also exists in the main manifest, instruct Repo to ignore that one.
        for project in upstream_manifest.findall('project'):
            if project.get('path') == path:
                upstream_name = project.get('name')
                found_remove_element = False
                for removable_project in roomservice_manifest.findall('remove-project'):
                    if removable_project.get('name') == upstream_name:
                        found_remove_element = True
                        break
                for removable_project in upstream_manifest.findall('remove-project'):
                    if removable_project.get('name') == upstream_name:
                        found_remove_element = True
                        break
                if not found_remove_element:
                    modified_project = True
                    roomservice_manifest.insert(0, ET.Element('remove-project', attrib = {
                        'name': upstream_name
                    }))

        # In case anything has changed, set the project as syncable.
        if modified_project:
            syncable_projects.append(path)

    # Output our manifest.
    with open(roomservice_manifest_path, 'w') as f:
        f.write(indent(roomservice_manifest))

    #  If roomservice manifest is perfectly fine, check if there are missing repos to be resynced.
    if len(syncable_projects) == 0:
        for path in mentioned_projects:
            if not os.path.exists(path):
                print('Dependency to be resynced:')
                print(f'--> Repository Path : {path}\n')
                syncable_projects.append(path)

    # Sync the project that have changed and should be synced.
    if len(syncable_projects) > 0:
        print('Syncing the dependencies.')
        if os.system('repo sync --force-sync --quiet --no-clone-bundle --no-tags %s' % ' '.join(syncable_projects)) != 0:
            raise ValueError('Got an unexpected exit status from the sync process.')
