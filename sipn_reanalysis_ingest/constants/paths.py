from pathlib import Path

PACKAGE_DIR = Path(__file__).resolve().parent.parent
PROJECT_DIR = PACKAGE_DIR.parent

DATA_DIR = Path('/data')
DATA_WIP_DIR = DATA_DIR / 'wip'
DATA_DOWNLOAD_DIR = DATA_WIP_DIR / '01-download'
DATA_UNTAR_DIR = DATA_WIP_DIR / '02-untar'
DATA_FINISHED_DIR = DATA_WIP_DIR / '99-finished'

DATA_DAILY_DIR = DATA_DIR / 'daily'
DATA_MONTHLY_DIR = DATA_DIR / 'monthly'

DATA_DAILY_FILENAME_TEMPLATE = 'cfsr.{date:%Y%m%d}.nc'  # noqa: FS003
DATA_DAILY_FILENAME_GLOBSTR = 'cfsr.????????.nc'
DATA_MONTHLY_FILENAME_TEMPLATE = 'cfsr.{yearmonth}.nc'  # noqa: FS003
DATA_MONTHLY_FILENAME_GLOBSTR = 'cfsr.??????.nc'
