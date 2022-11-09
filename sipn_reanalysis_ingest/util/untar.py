import datetime as dt
import tarfile
from pathlib import Path

from sipn_reanalysis_ingest._types import CfsrProductType
from sipn_reanalysis_ingest.constants.paths import DATA_UNTAR_DIR
from sipn_reanalysis_ingest.util.cfsr import cfsr_5day_input_identifier


def untar_dir(
    *,
    window_start: dt.date,
    window_end: dt.date,
    product_type: CfsrProductType,
) -> Path:
    subdir_name = cfsr_5day_input_identifier(
        window_start=window_start,
        window_end=window_end,
        product_type=product_type,
    )
    return DATA_UNTAR_DIR / subdir_name


def untar_cfsr_5day_tar(tar_path: Path, *, output_dir: Path) -> None:
    with tarfile.open(tar_path) as tar:
        tar.extractall(output_dir)
