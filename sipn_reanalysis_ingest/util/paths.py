import datetime as dt
from pathlib import Path

from sipn_reanalysis_ingest._types import CfsrProductType
from sipn_reanalysis_ingest.constants.paths import DATA_DOWNLOAD_DIR, DATA_UNTAR_DIR
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


def download_dir(
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
    return DATA_DOWNLOAD_DIR / subdir_name
