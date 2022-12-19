import datetime as dt
from pathlib import Path

from sipn_reanalysis_ingest._types import CfsrGranuleProductType
from sipn_reanalysis_ingest.constants.paths import DATA_DOWNLOAD_DIR, DATA_UNTAR_DIR
from sipn_reanalysis_ingest.util.cfsr import (
    cfsr_5day_input_identifier,
    cfsr_monthly_input_identifier,
)
from sipn_reanalysis_ingest.util.date import YearMonth


# TODO: The code in this module is awful repetetive
def untar_5day_tar_dir(
    *,
    window_start: dt.date,
    window_end: dt.date,
    product_type: CfsrGranuleProductType,
) -> Path:
    subdir_name = cfsr_5day_input_identifier(
        window_start=window_start,
        window_end=window_end,
        product_type=product_type,
    )
    return DATA_UNTAR_DIR / subdir_name


def untar_monthly_tar_dir(
    *,
    month: YearMonth,
) -> Path:
    subdir_name = cfsr_monthly_input_identifier(month=month)
    return DATA_UNTAR_DIR / subdir_name


def download_5day_tar_path(
    *,
    window_start: dt.date,
    window_end: dt.date,
    product_type: CfsrGranuleProductType,
) -> Path:
    ident = cfsr_5day_input_identifier(
        window_start=window_start,
        window_end=window_end,
        product_type=product_type,
    )
    return DATA_DOWNLOAD_DIR / f'{ident}.tar'


def download_monthly_tar_path(*, month: YearMonth) -> Path:
    ident = cfsr_monthly_input_identifier(month=month)
    return DATA_DOWNLOAD_DIR / f'{ident}.tar'
