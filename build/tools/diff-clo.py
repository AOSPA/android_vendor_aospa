#!/usr/bin/env python3
#
#
# Copyright (C) 2023 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""
Diff script for AOSPA

 The source directory; this is automatically two folder up because the script
 is located in vendor/aospa/build/tools. Other ROMs will need to change this. The logic is
 as follows:

 1. Get the absolute path of the script with os.path.realpath in case there is a symlink
    This script may be symlinked by a manifest so we need to account for that
 2. Get the folder containing the script with dirname
 3. Move into the folder that is three folders above that one and print it

"""

import argparse
import os
import shutil
import subprocess
import xml.etree.ElementTree as Et

import git

BASE_URL = "https://git.codelinaro.org/clo/la/"
WORKING_DIR = "{0}/../../../..".format(os.path.dirname(os.path.realpath(__file__)))
MANIFEST_NAME = "aospa.xml"
REPOS_TO_DIFF = {}
REPOS_RESULTS = {}


# useful helpers
def nice_error():
    """ Errors out in a non-ugly way. """
    print("Invalid repo, are you sure this repo is on the tag you're merging?")


def get_manual_repos(args, is_system):
    """ Get all manually (optional) specified repos from arguments """
    ret_lst = {}
    default_repos = list_default_repos(is_system)
    if args.repos_to_diff:
        for repo in args.repos_to_diff:
            if repo not in default_repos:
                nice_error()
                return None, None
            ret_lst[repo] = default_repos[repo]
    return ret_lst, default_repos


def list_default_repos(is_system):
    """ Gathers all repos from split system.xml and vendor.xml """
    default_repos = {}
    if is_system:
        with open(
                "{0}/.repo/manifests/system.xml".format(WORKING_DIR)
        ) as system_manifest:
            system_root = Et.parse(system_manifest).getroot()
            for child in system_root:
                path = child.get("path")
                if path:
                    default_repos[path] = child.get("name")
    else:
        with open(
                "{0}/.repo/manifests/vendor.xml".format(WORKING_DIR)
        ) as vendor_manifest:
            vendor_root = Et.parse(vendor_manifest).getroot()
            for child in vendor_root:
                path = child.get("path")
                if path:
                    default_repos[path] = child.get("name")
    return default_repos


def read_custom_manifest(default_repos):
    """ Finds all repos that need to be diffed """
    print("Finding repos to diff...")
    with open("{0}/.repo/manifests/{1}".format(WORKING_DIR, MANIFEST_NAME)) as manifest:
        root = Et.parse(manifest).getroot()
        removed_repos = []
        project_repos = []
        reversed_default = {value: key for key, value in default_repos.items()}
        for repo in root:
            if repo.tag == "remove-project":
                removed_repos.append(repo.get("name"))
            else:
                if repo.get("remote") == "aospa":
                    project_repos.append(repo.get("path"))

        for repo in removed_repos:
            if repo in reversed_default:
                if reversed_default[repo] in project_repos:
                    REPOS_TO_DIFF[reversed_default[repo]] = repo


def force_sync(repo_lst):
    """ Force syncs all the repos that need to be diffed """
    print("Syncing repos")
    for repo in repo_lst:
        if os.path.isdir("{}{}".format(WORKING_DIR, repo)):
            shutil.rmtree("{}{}".format(WORKING_DIR, repo))

    cpu_count = str(os.cpu_count())
    args = [
        "repo",
        "sync",
        "-c",
        "--force-sync",
        "-f",
        "--no-tags",
        "-j",
        cpu_count,
        "-q",
    ] + list(repo_lst.values())
    subprocess.run(
        args,
        check=False,
    )


def diff(repo_lst, branch):
    """ Diffs the necessary repos"""
    for repo in repo_lst:
        print("project " + repo)
        os.chdir("{0}/{1}".format(WORKING_DIR, repo))
        git.cmd.Git().fetch("{}{}".format(BASE_URL, repo_lst[repo]), branch)
        log = git.cmd.Git().log('--no-merges --format="%h   %s   %ae   %ce   %cs" FETCH_HEAD..HEAD')
        print(log)


def main():
    """Gathers and diffs all repos from CLO and
    reports all repos that need to be fixed manually"""

    parser = argparse.ArgumentParser(description="Diff a CLO revision.")
    parser.add_argument(
        "branch_to_diff",
        metavar="branch",
        type=str,
        help="a tag to diff from git.codelinaro.org",
    )
    parser.add_argument(
        "--repos",
        dest="repos_to_diff",
        nargs="*",
        type=str,
        help="path of repos to diff",
    )
    args = parser.parse_args()

    branch = "refs/tags/{}".format(args.branch_to_diff)

    is_system = "LA.QSSI" in branch
    repo_lst, default_repos = get_manual_repos(args, is_system)
    if repo_lst is None and default_repos is None:
        return
    if len(repo_lst) == 0:
        read_custom_manifest(default_repos)
        if REPOS_TO_DIFF:
            force_sync(REPOS_TO_DIFF)
            diff(REPOS_TO_DIFF, branch)
            os.chdir(WORKING_DIR)
        else:
            print("No repos to sync")
    else:
        force_sync(repo_lst)
        diff(repo_lst, branch)
        os.chdir(WORKING_DIR)


if __name__ == "__main__":
    # execute only if run as a script
    main()
