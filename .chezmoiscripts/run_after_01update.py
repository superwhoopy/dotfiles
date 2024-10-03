#!/usr/bin/env python3
"""TODO"""

import subprocess
import threading
import shutil

from rich.progress import (Progress, SpinnerColumn, TextColumn,
                           TimeElapsedColumn, Column)

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


def _run_command(lock: threading.Lock, progress: Progress, tid, cmd, args):
    with lock:
        progress.start_task(tid)
    if (fullcmd := shutil.which(cmd)) is None:
        with lock:
            progress.remove_task(tid)
        return


    if isinstance(args[0], str):
        args = (args,)

    for a in args:
        command = [fullcmd, *a]
        out = subprocess.run(command, check=False, stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT)
        # TODO: log output somewhere to make the main thread print it out at the
        # end
        # TODO: update progress bar with a notification when the command failed

    with lock:
        progress.advance(tid, 100)


def main():
    print("Running update subcommands...")
    stdout_lock = threading.Lock()

    with Progress(
        TextColumn("{task.description}", table_column=Column(ratio=1)),
        SpinnerColumn(spinner_name='bouncingBall', finished_text='✅'),
        TimeElapsedColumn(),
        transient=True
    ) as progress:


        threads = tuple(
             threading.Thread(target=_run_command,
                              args=(stdout_lock, progress,
                                    progress.add_task(f'{cmd}...', total=100,
                                                      start=False),
                                    cmd, args))
            for cmd, args in UPDATE_COMMANDS.items()
        )

        for t in threads:
            t.start()

        for t in threads:
            t.join()

        print('...completed')




if __name__ == "__main__":
    main()
