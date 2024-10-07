#!/usr/bin/env python3
"""TODO"""

import subprocess
import threading
import shutil
import typing

from rich.progress import (Progress, SpinnerColumn, TextColumn,
                           TimeElapsedColumn, Column)

UPDATE_COMMANDS = {
    "flatpak": (
        ("update", "--assumeyes", '--noninteractive'),
        ('uninstall', "--assumeyes", '--unused'),
    ),

    "brew": ("upgrade",),

    "nvim": ('--headless', "+Lazy! sync", '+qa'),

    "npm": ('update', '-g'),

    'pipx': ('upgrade-all',),

    # 'gem': ('update',),
}

def _blueprint(s: str):
    print(f"\033[94m{s}\033[0m")

def _chezmoiprint(s: str):
    _blueprint(80 * '#')
    _blueprint(f" CHEZMOI - {s}")
    _blueprint(80 * '#')


class ProgressContext(typing.NamedTuple):
    ctx: Progress
    task_id: int


def _run_command(lock: threading.Lock, progress: ProgressContext, cmd, args,
                 output: list):
    with lock:
        progress.ctx.start_task(progress.task_id)
    if (fullcmd := shutil.which(cmd)) is None:
        with lock:
            progress.ctx.remove_task(progress.task_id)
        return

    if isinstance(args[0], str):
        args = (args,)

    for a in args:
        command = [fullcmd, *a]
        out = subprocess.run(command, check=False, stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT)

    with lock:
        output.append(out.stdout.decode())
        # TODO: update progress bar with a notification when the command failed
        progress.ctx.advance(progress.task_id, 100)


def main():
    _chezmoiprint('Secondary package managers update')
    global_lock = threading.Lock()

    with Progress(
        TextColumn("{task.description}", table_column=Column(ratio=1)),
        SpinnerColumn(spinner_name='bouncingBall', finished_text='✅'),
        TimeElapsedColumn(),
        transient=True
    ) as progress:

        threads_output = []

        threads = tuple(
            threading.Thread(
              target=_run_command,
              args=(global_lock,
                    ProgressContext(progress,
                                    progress.add_task(f'{cmd}...',
                                                      total=100,
                                                      start=False)),
                    cmd, args, threads_output)
            )
            for cmd, args in UPDATE_COMMANDS.items()
        )

        for t in threads:
            t.start()

        for t in threads:
            t.join()

        # for o in threads_output:
        #     print(o)

        print('...completed')


if __name__ == "__main__":
    main()
