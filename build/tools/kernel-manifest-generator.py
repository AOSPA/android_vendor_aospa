#!/usr/bin/env python3

import logging
import sys
import xml.etree.ElementTree as ET
from pathlib import Path
from typing import List, Optional, Tuple
from urllib.error import URLError
from urllib.request import urlopen

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
)


class ManifestProcessor:
    BASE_URL: str = "https://git.codelinaro.org/clo/la"
    MAIN_MANIFEST_PATH: str = "la/vendor/manifest/-/raw/release/{tag}.xml"
    BLACKLIST: List[str] = ["wfd", "test", "SnapdragonCamera"]

    def __init__(self, tag: str, output_file: str):
        self.tag: str = tag
        self.output_file: str = output_file
        self.logger = logging.getLogger(self.__class__.__name__)

    @staticmethod
    def fetch_manifest(url: str) -> Optional[str]:
        try:
            with urlopen(url) as response:
                return response.read().decode("utf-8")
        except URLError as e:
            logging.error(f"Failed to fetch manifest from {url}. Error: {e}")
            return None

    @classmethod
    def generate_url(cls, project: str, tag: str) -> str:
        return f"{cls.BASE_URL}/{project}/-/raw/{tag}/{tag}.xml"

    def process_main_manifest(self, xml_content: str) -> List[Tuple[str, str, str]]:
        root = ET.fromstring(xml_content)
        refs = root.find("refs")

        if refs is None:
            self.logger.warning("No 'refs' element found in the main manifest.")
            return []

        result = []

        for image in refs.findall("image"):
            name = image.get("name", "")

            if "QSSI" in name:
                self.logger.info(f"Ignoring QSSI image: {name}")
                continue

            result.append(
                (
                    name,
                    image.get("tag", ""),
                    self.generate_url(
                        image.get("project", ""),
                        image.get("tag", ""),
                    ),
                )
            )

        return result

    @staticmethod
    def combine_manifests(sub_manifests: List[Tuple[str, str, str]]) -> ET.Element:
        root = ET.Element("manifest")
        removed_elements = set()

        for name, tag, content in sub_manifests:
            if content:
                comment = ET.Comment(f" {tag} ")
                root.append(comment)
                sub_root = ET.fromstring(content)

                for element in sub_root:
                    if element.tag in {"remote", "default"}:
                        if element.tag not in removed_elements:
                            logging.info(f"Removing all '{element.tag}' elements")
                            removed_elements.add(element.tag)
                        continue

                    if element.tag == "project":
                        project_name = element.get("name", "")
                        project_path = element.get("path", "")

                        if any(
                            word in project_name or word in project_path
                            for word in ManifestProcessor.BLACKLIST
                        ):
                            logging.info(
                                f"Removing blacklisted project: {project_name} (path: {project_path})"
                            )
                            continue

                        if project_name.startswith("clo/la/"):
                            modified_name = project_name[7:]
                            element.set("name", modified_name)

                        if (
                            "remote" not in element.attrib
                            or element.get("remote") != "clo-la"
                        ):
                            element.set("remote", "clo-la")
                            logging.info(
                                f"Set 'clo-la' remote for project: {element.get('name')}"
                            )

                    root.append(element)

        return root

    def process(self) -> bool:
        main_url = f"{self.BASE_URL}/{self.MAIN_MANIFEST_PATH.format(tag=self.tag)}"
        main_manifest = self.fetch_manifest(main_url)

        if not main_manifest:
            self.logger.error("Failed to fetch the main manifest. Exiting.")
            return False

        manifests_to_fetch = self.process_main_manifest(main_manifest)
        sub_manifests = []

        for name, tag, url in manifests_to_fetch:
            content = self.fetch_manifest(url)
            if content:
                sub_manifests.append((name, tag, content))
            else:
                self.logger.warning(
                    f"Skipping manifest for {name} due to fetch failure."
                )

        combined_root = self.combine_manifests(sub_manifests)
        ET.indent(combined_root)
        tree = ET.ElementTree(combined_root)
        tree.write(self.output_file, encoding="utf-8", xml_declaration=True)

        self.logger.info(f"Combined manifest has been written to '{self.output_file}'")
        return True


def main() -> None:
    script_name = Path(__file__).name

    if len(sys.argv) not in [2, 3]:
        logging.error(f"Usage: python {script_name} TAG [OUTPUT_FILE]")
        sys.exit(1)

    tag = sys.argv[1]
    output_file = f"{sys.argv[2]}.xml" if len(sys.argv) == 3 else f"{tag}.xml"

    processor = ManifestProcessor(tag, output_file)
    success = processor.process()

    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
