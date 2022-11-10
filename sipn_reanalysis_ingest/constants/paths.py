from pathlib import Path

PACKAGE_DIR = Path(__file__).resolve().parent.parent
PROJECT_DIR = PACKAGE_DIR.parent

DATA_DIR = Path('/data')
DATA_WIP_DIR = DATA_DIR / 'wip'
DATA_DOWNLOAD_DIR = DATA_WIP_DIR / '01-download'
DATA_UNTAR_DIR = DATA_WIP_DIR / '02-untar'
DATA_FINISHED_DIR = DATA_WIP_DIR / '99-finished'
