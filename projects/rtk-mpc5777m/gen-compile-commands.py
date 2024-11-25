"""Generate a compile_commands.json (Compilation Database file) from the
"Compilation Summary" JSON files in the repository.

Usage: python gen-compile-commands.py > compile_commands.json
"""

import json

from pathlib import Path

CFLAGS = ["--std=c89", "-Wall", "-Wextra", "-DAST_K2_", "-D_DIAB_TOOL"]

COMP_SUMMARY_JSON = Path(
        'bundle/compilation_summary_power-mpc5777m-module-p.json')

SOURCE_COMP_SUMMARY_JSON = Path(
        'sources_bundle/sources_compilation_summary.json')

HERE = Path(__file__).parent


def main():
    with COMP_SUMMARY_JSON.open('r') as csf:
        compilation_summary = json.loads(csf.read())
    iflags = [f"-Ibundle/{incdir}"
              for incdir in compilation_summary['include_dirs']]
    db = [
        {
            "directory": str(HERE),
            "arguments": ['clang'] + CFLAGS + iflags + [f"bundle/{srcfile}"],
            "file": f"bundle/{srcfile}",
        }
        for srcfile in compilation_summary['c_sources']
    ]

    with SOURCE_COMP_SUMMARY_JSON.open('r') as scsf:
        compilation_summary = json.loads(scsf.read())
    iflags = [f"-Isource_bundle/{incdir}"
              for incdir in compilation_summary['sources'][0]['include_dirs']]
    db.extend([
        {
            "directory": str(HERE),
            "arguments": (['clang'] + CFLAGS + iflags
                          + [f"source_bundle/{srcfile}"]),
            "file": f"source_bundle/{srcfile}",
        }
        for srcfile in compilation_summary['sources'][0]['c_sources']
    ])

    print(json.dumps(db, indent=2))


if __name__ == "__main__":
    main()
