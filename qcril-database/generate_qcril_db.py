#!/usr/bin/env python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#


import os
import re
import sqlite3
import sys


def version_prefix(file_path):
    basename = os.path.basename(file_path)
    match = re.match(r'(\d+(\.\d+)?)', basename)
    # Split the version to properly sort subversions
    return [int(part) for part in match.group(0).split('.')] if match else []


def main():
    if len(sys.argv) <= 2:
        print('syntax: generate_qcril_db.py qcril.db 0_initial_qcrilnr.sql 1_...')
        sys.exit(1)

    target_db = sys.argv[1]
    sql_files = sys.argv[2:]

    if os.path.exists(target_db):
        os.remove(target_db)

    config_sql_files = [
        file for file in sql_files if file.endswith('_config.sql')
    ]
    ecc_sql_files = [
        file for file in sql_files if not file.endswith('_config.sql')
    ]

    config_sql_files.sort(key=version_prefix)
    ecc_sql_files.sort(key=version_prefix)

    with sqlite3.connect(target_db) as conn:
        cursor = conn.cursor()
        for file in ecc_sql_files + config_sql_files:
            try:
                with open(file, 'r') as sql_file:
                    sql_script = sql_file.read()
                    cursor.executescript(sql_script)
            except Exception as e:
                print(f'Failed to apply {file}: {e}')
                sys.exit(1)


if __name__ == '__main__':
    main()
