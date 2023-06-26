import sys
from pathlib import Path

from invoke import task

from .util import print_and_run

PROJECT_DIR = Path(__file__).resolve().parent.parent
sys.path.append(PROJECT_DIR)

# WARNING: Do not import from sipn_reanalysis_ingest at this level to avoid failure of basic
# commands because unneeded envvars are not populated.


@task(aliases=['mypy'])
def typecheck(ctx):
    """Run mypy static type analysis."""
    from sipn_reanalysis_ingest.constants.paths import PACKAGE_DIR

    print_and_run(
        f'cd {PROJECT_DIR} &&'
        f' mypy --config-file={PROJECT_DIR}/.mypy.ini {PACKAGE_DIR}',
    )
    print('🎉🦆 Type checking passed.')


@task(aliases=('unit',))
def unittest(ctx):
    """Run unit tests."""
    from sipn_reanalysis_ingest.constants.paths import PACKAGE_DIR

    print_and_run(
        f'PYTHONPATH={PROJECT_DIR} pytest -vv {PACKAGE_DIR}/test/',
        pty=True,
    )
    print('🎉🛠️  Unit tests passed.')


@task(
    pre=[typecheck, unittest],
    default=True,
)
def all(ctx):
    """Run all tasks."""
    print('🎉❤️  All tests passed!')
