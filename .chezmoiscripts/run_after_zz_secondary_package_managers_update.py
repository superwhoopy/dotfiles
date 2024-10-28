#!/usr/bin/env python3
"""TODO"""

import asyncio
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

    'rustup': ('update',),

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


async def _run_command(progress: ProgressContext, cmd, args):
    progress.ctx.start_task(progress.task_id)

    fullcmd = await asyncio.to_thread(shutil.which, cmd)
    if fullcmd is None:
        progress.ctx.remove_task(progress.task_id)
        return

    if isinstance(args[0], str):
        args = (args,)

    output = []
    for a in args:
        proc = await asyncio.create_subprocess_exec(
            fullcmd, *a,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.STDOUT)
        stdout, _ = await proc.communicate()
        output.append(stdout.decode())

    # TODO: update progress bar with a notification when the command failed
    progress.ctx.advance(progress.task_id, 100)
    return output


async def main():
    _chezmoiprint('Secondary package managers update')

    with Progress(
        TextColumn("{task.description}", table_column=Column(ratio=1)),
        SpinnerColumn(spinner_name='bouncingBall', finished_text='✅'),
        TimeElapsedColumn(),
        transient=False
    ) as progress:

        async with asyncio.TaskGroup() as tg:
            _ = tuple(
                tg.create_task(_run_command(
                    ProgressContext(progress,
                                    progress.add_task(f'{cmd}...',
                                                      total=100,
                                                      start=False)),
                    cmd, args))
                for cmd, args in UPDATE_COMMANDS.items()
            )

        # for t in tasks:
        #     print(t.result())

        print('...completed')


if __name__ == "__main__":
    asyncio.run(main())
