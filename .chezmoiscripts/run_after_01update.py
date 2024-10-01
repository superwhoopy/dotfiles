#!/usr/bin/env python3
"""TODO"""

import subprocess
import threading
import shutil

UPDATE_COMMANDS = {
    "flatpak": (
        ("update", "--assumeyes", '--noninteractive'),
        ('uninstall', "--assumeyes", '--unused'),
    ),

    "brew": ("upgrade",),

    "nvim": ('--headless', '+Lazy! sync', '+qa'),

    "npm": ('update', '-g'),

    'pipx': ('upgrade-all',),

    'gem': ('update',),
}


def _run_command(lock, cmd, args):
    if (fullcmd := shutil.which(cmd)) is None:
        with lock:
            print(f'Ignoring `{cmd}` commands…')
        return

    if isinstance(args[0], str):
        args = (args,)

    for a in args:
        command = [fullcmd, *a]
        with lock:
            print(' '.join(command))
        out = subprocess.run(command, check=False, stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT)
        with lock:
            print(out.stdout.decode())


def main():
    print("Running update subcommands...")
    stdout_lock = threading.Lock()

    threads = tuple(
        threading.Thread(target=_run_command, args=(stdout_lock, cmd, args))
        for cmd, args in UPDATE_COMMANDS.items()
    )
    for t in threads:
        t.start()
    for t in threads:
        t.join()


if __name__ == "__main__":
    main()
