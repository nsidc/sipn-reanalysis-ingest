import datetime as dt
from pathlib import Path

import requests
from loguru import logger

from sipn_reanalysis_ingest._types import CfsrGranuleProductType
from sipn_reanalysis_ingest.errors import DownloadError
from sipn_reanalysis_ingest.util.date import YearMonth
from sipn_reanalysis_ingest.util.url import (
    cfsr_1day_tar_url,
    cfsr_5day_tar_url,
    cfsr_monthly_tar_url,
    cfsr_yearly_tar_url,
)


def download_tar(url: str, output_fp: Path) -> Path:
    response = requests.get(url, stream=True)

    if not response.ok:
        msg = f'There was an error downloading {url}. Status: {response.status_code}.'
        logger.error(msg)
        raise DownloadError(msg)

    if output_fp.exists():
        msg = f'Already exists: {output_fp}'
        logger.error(msg)
        raise DownloadError(msg)

    logger.info(f'Downloading {url}...')
    with open(output_fp, 'wb') as f:
        logger.debug(f'Downloading to {output_fp}')
        for chunk in response.iter_content(chunk_size=1024):
            if chunk:
                f.write(chunk)

    logger.info(f'Downloaded {url} to {output_fp}')
    return output_fp


def download_cfsr_1day_tar(
    *,
    date: dt.date,
    output_fp: Path,
) -> Path:
    """Download a 1-day .tar file from RDA.

    The end date is calculated from `window_start`; the last day of the month is used if
    `window_start + 5` is in the next month.
    """
    url = cfsr_1day_tar_url(date=date)
    output_fp = download_tar(url, output_fp)

    return output_fp


# TODO: The functions below this line are awfully repetetive. DRY
def download_cfsr_5day_tar(
    *,
    window_start: dt.date,
    product_type: CfsrGranuleProductType,
    output_fp: Path,
) -> Path:
    """Download a 5-day .tar file from RDA.

    The end date is calculated from `window_start`; the last day of the month is used if
    `window_start + 5` is in the next month.
    """
    url = cfsr_5day_tar_url(
        window_start=window_start,
        product_type=product_type,
    )
    output_fp = download_tar(url, output_fp)

    return output_fp


def download_cfsr_monthly_tar(
    *,
    month: YearMonth,
    output_fp: Path,
) -> Path:
    """Download a monthly .tar file from RDA (containing v2 monthly data)."""
    url = cfsr_monthly_tar_url(month=month)
    output_fp = download_tar(url, output_fp)

    return output_fp


def download_cfsr_yearly_tar(
    *,
    year: int,
    product_type: CfsrGranuleProductType,
    output_fp: Path,
) -> Path:
    """Download a yearly .tar file from RDA (containing v1 monthly data)."""
    url = cfsr_yearly_tar_url(year=year, product_type=product_type)
    output_fp = download_tar(url, output_fp)

    return output_fp
