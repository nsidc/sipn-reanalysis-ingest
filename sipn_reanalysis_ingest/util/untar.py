import datetime as dt
import tarfile
from pathlib import Path

from sipn_reanalysis_ingest.constants.paths import DATA_UNTAR_DIR


def untar_dir(start_date: dt.date, end_date: dt.date) -> Path:
    return DATA_UNTAR_DIR / f'{start_date:%Y%m%d}-{end_date:%Y%m%d}'


def untar_cfsr_5day_tar(tar_path: Path, *, output_dir: Path) -> None:
    with tarfile.open(tar_path) as tar:
        tar.extractall(output_dir)
