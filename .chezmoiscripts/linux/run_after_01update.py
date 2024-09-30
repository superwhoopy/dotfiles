"""TODO"""

import itertools
import subprocess
import threading
import shutil

UPDATE_COMMANDS = {
    "flatpak": (
        ("update", "--assumeyes", '--noninteractive'),
        ('uninstall', "--assumeyes", '--unused'),
    ),

    "brew": ("upgrade",),

    "nvim": ('--headless', '"+Lazy! sync"', '+qa'),

    "npm": ('update', '-g'),

    'pipx': ('upgrade-all',),

    'gem': ('update',),
}


def _run_command(lock, cmd, args):
    if shutil.which(cmd) is None:
        return

    if isinstance(args[0], str):
        args = (args,)

    for a in args:
        command = [cmd, *a]
        out = subprocess.run(command, check=False, stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT)
        with lock:
            print(' '.join(command))
            print(out.stdout.decode())


def main():
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
