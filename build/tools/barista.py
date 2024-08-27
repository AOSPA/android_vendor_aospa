#!/usr/bin/env python3

"""
barista: Android device repository management utility.

Brews the perfect blend of repositories for your Android device.

SPDX-FileCopyrightText: 2024 Paranoid Android
SPDX-License-Identifier: Apache-2.0
"""

import subprocess
import sys
from pathlib import Path
from shutil import rmtree
from xml.etree.ElementTree import (
    Comment,
    Element,
    ElementTree,
    ParseError,
    indent,
    parse,
)

# Constants
EXTRA_MANIFESTS_DIR = Path(".repo/manifests")
UPSTREAM_MANIFEST_PATH = Path(".repo/manifest.xml")
LOCAL_MANIFESTS_DIR = Path(".repo/local_manifests")
BARISTA_BLEND_PATH = LOCAL_MANIFESTS_DIR / "baristablend.xml"
BARISTA_BEANS_PATH = "vendor/aospa/products/{}/beans.xml"


def sort_manifest(manifest: Element) -> None:
    """Sort remove-project and project elements in the manifest."""
    remove_projects = sorted(
        manifest.findall("remove-project"), key=lambda x: x.get("name", "")
    )
    projects = sorted(manifest.findall("project"), key=lambda x: x.get("path", ""))
    manifest.clear()
    manifest.extend(remove_projects + projects)


def blend_includes(manifest: Element) -> Element:
    """Recursively process include elements in the manifest."""

    def process_include(include_elem):
        extra_manifest_path = EXTRA_MANIFESTS_DIR / include_elem.get("name", "")
        try:
            extra_manifest = parse(extra_manifest_path).getroot()
            manifest.extend(extra_manifest)
            manifest.extend(blend_includes(extra_manifest))
        except (IOError, ParseError) as e:
            print(f"Error blending include {extra_manifest_path}: {e}")

    for include in manifest.findall("include"):
        process_include(include)

    return manifest


def grind_beans(device: str) -> list[Element]:
    """Parse the AOSPA XML file (beans) for the given device."""
    beans_path = Path(BARISTA_BEANS_PATH.format(device))
    if not beans_path.is_file():
        raise FileNotFoundError(f"No beans found for the device ({device}).")

    projects = {}
    remove_projects = set()

    def process_manifest(manifest_path: Path) -> None:
        try:
            manifest = parse(manifest_path).getroot()

            # Process remove-project tags
            for remove_elem in manifest.findall("remove-project"):
                remove_projects.add(remove_elem.get("name", ""))

            # Process project tags
            for project in manifest.findall("project"):
                path = project.get("path", "")
                name = project.get("name", "")
                if name not in remove_projects:
                    projects[path] = project

            # Process all include files recursively
            for include_elem in manifest.findall("include"):
                include_path = manifest_path.parent / include_elem.get("name", "")
                process_manifest(include_path)
        except FileNotFoundError:
            print(f"Warning: Include beans not found at {manifest_path}. Skipping.")
        except ParseError:
            print(
                f"Warning: Unable to grind include beans at {manifest_path}. Skipping."
            )

    # Process main file and all its includes
    process_manifest(beans_path)

    # Final filtering of removed projects
    projects = {
        path: project
        for path, project in projects.items()
        if project.get("name") not in remove_projects
    }

    return list(projects.values())


def main():
    LOCAL_MANIFESTS_DIR.mkdir(parents=True, exist_ok=True)

    if len(sys.argv) <= 1:
        print("Error: The first argument must be the product.")
        sys.exit(1)

    product = sys.argv[1]
    device = product.split("_", 1)[-1]

    skip_sync = False
    if len(sys.argv) > 2:
        skip_sync = sys.argv[2].lower() == "true"

    try:
        projects = grind_beans(device)
    except FileNotFoundError as e:
        print(f"Error: {e}")
        sys.exit(1)

    try:
        upstream_manifest = parse(UPSTREAM_MANIFEST_PATH).getroot()
    except (FileNotFoundError, ParseError):
        upstream_manifest = Element("manifest")

    blend_includes(upstream_manifest)

    try:
        barista_manifest = parse(BARISTA_BLEND_PATH).getroot()
    except (FileNotFoundError, ParseError):
        barista_manifest = Element("manifest")

    brewable_projects = []
    mentioned_projects = [project.get("path", "") for project in projects]
    changes = []

    # Process project elements
    for project in projects:
        path = project.get("path", "")
        name = project.get("name", "")

        # Check if the project exists in upstream manifest
        for upstream_project in upstream_manifest.findall("project"):
            if upstream_project.get("path") == path:
                upstream_name = upstream_project.get("name", "")
                if not any(
                    rp.get("name") == upstream_name
                    for rp in barista_manifest.findall("remove-project")
                    + upstream_manifest.findall("remove-project")
                ):
                    barista_manifest.insert(
                        0, Element("remove-project", attrib={"name": upstream_name})
                    )

        existing = barista_manifest.find(f".//project[@path='{path}']")

        if existing is None:
            barista_manifest.append(project)
            brewable_projects.append(path)
            changes.append(f"Added ingredient: {name} at {path}")
        else:
            updated_attrs = [
                attr
                for attr, value in project.attrib.items()
                if existing.get(attr) != value
            ]
            removed_attrs = [
                attr for attr in existing.attrib if attr not in project.attrib
            ]

            for attr in updated_attrs:
                existing.set(attr, project.get(attr, ""))

            for attr in removed_attrs:
                del existing.attrib[attr]

            if updated_attrs or removed_attrs:
                changes.extend(
                    f"Updated {attr} for ingredient: {name}" for attr in updated_attrs
                )
                changes.extend(
                    f"Removed {attr} from ingredient: {name}" for attr in removed_attrs
                )
                brewable_projects.append(path)

    # Remove projects that are no longer in the ingredient list
    for existing in barista_manifest.findall("project"):
        if existing.get("path") not in mentioned_projects:
            path_to_remove = Path(existing.get("path", ""))
            barista_manifest.remove(existing)
            changes.append(
                f"Removed ingredient: {existing.get('name')} from {path_to_remove}"
            )

            upstream_project = upstream_manifest.find(
                f".//project[@path='{path_to_remove}']"
            )
            if upstream_project is not None:
                brewable_projects.append(str(path_to_remove))

                upstream_name = upstream_project.get("name", "")
                remove_project = barista_manifest.find(
                    f".//remove-project[@name='{upstream_name}']"
                )
                if remove_project is not None:
                    barista_manifest.remove(remove_project)

            if path_to_remove.exists():
                try:
                    rmtree(path_to_remove)
                except Exception as e:
                    print(f"Error disposing old ingredient {path_to_remove}: {e}")

    # Remove remove-project(s) that are no longer needed
    for remove_project in barista_manifest.findall("remove-project"):
        upstream_project = upstream_manifest.find(
            f".//project[@name='{remove_project.get('name')}']"
        )
        if upstream_project is not None:
            if not any(
                project.get("path") == upstream_project.get("path")
                for project in projects
            ):
                barista_manifest.remove(remove_project)

    # Finalize recipe
    sort_manifest(barista_manifest)
    barista_manifest.insert(0, Comment(" DO NOT EDIT - Generated by barista "))
    indent(barista_manifest)
    ElementTree(barista_manifest).write(
        BARISTA_BLEND_PATH, encoding="utf-8", xml_declaration=True
    )

    # Report changes and brew projects
    if changes:
        print("Changes made to barista recipe:")
        for change in changes:
            print(f"- {change}")
    else:
        print("No changes were necessary to the barista recipe.")

    if not brewable_projects:
        brewable_projects = [
            path for path in mentioned_projects if not Path(path).exists()
        ]

    if brewable_projects and not skip_sync:
        print("Brewing the fresh ingredients.")
        brew_command = [
            "repo",
            "sync",
            "--force-sync",
            "--quiet",
            "--no-clone-bundle",
            "--no-tags",
        ] + brewable_projects
        try:
            subprocess.run(brew_command, check=True)
        except subprocess.CalledProcessError:
            print("Error: Unexpected exit status from the brewing process.")
            sys.exit(1)
    elif skip_sync:
        print("Skipping repository synchronization as requested.")
    else:
        print("No ingredients need to be brewed.")


if __name__ == "__main__":
    main()
