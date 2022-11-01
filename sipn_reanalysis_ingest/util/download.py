import datetime as dt
from functools import cache
from pathlib import Path

import requests
from loguru import logger

from sipn_reanalysis_ingest._types import CfsrPeriod
from sipn_reanalysis_ingest.constants.creds import RDA_PASSWORD, RDA_USER
from sipn_reanalysis_ingest.constants.download import (
    DOWNLOAD_AUTH_URL,
    DOWNLOAD_FILE_URL_TEMPLATES,
)
from sipn_reanalysis_ingest.errors import DownloadError, ProgrammerError


@cache
def cfsr_tar_url_template(
    *,
    start_date: dt.date,
    periodicity: CfsrPeriod,
) -> str:
    """Return the correct template for the given date and periodicity."""
    templates_by_date_range = DOWNLOAD_FILE_URL_TEMPLATES[periodicity]
    templates_matching_date = [
        value
        for key, value in templates_by_date_range.items()
        if key[0] <= start_date <= key[1]
    ]
    if len(templates_matching_date) > 1:
        raise ProgrammerError(
            f'Error in download URL templates. >1 match for date {start_date}'
        )

    return templates_matching_date[0]


def _5day_end_date_from_start_date(start_date: dt.date) -> dt.date:
    """Calculate end date based on start date.

    Because the CFSR files are named with inclusive intervals, the actual difference
    between the start and end dates is 4 days, although the files each contain 5 days of
    data.
    """
    if start_date.day % 5 != 1:
        raise ProgrammerError(
            f'Start date ({start_date:%Y-%m-%d}) day portion must be a multiple of 5'
            ' plus one, e.g.: 1, 6, 11, 16, ...'
        )
    plus_5 = start_date + dt.timedelta(days=4)
    if plus_5.month == start_date.month:
        return plus_5

    # Calculate the last day of the previous month, e.g.:
    #    Feb 3 - 3 = Jan 31
    return plus_5 - dt.timedelta(plus_5.day)


def cfsr_5day_tar_url(
    *,
    start_date: dt.date,
) -> str:
    template = cfsr_tar_url_template(start_date=start_date, periodicity='five_daily')
    end_date = _5day_end_date_from_start_date(start_date)
    fn = f'pgbhnl.gdas.{start_date:%Y%m%d}-{end_date:%Y%m%d}.tar'

    filled = template.format(year=start_date.year, filename=fn)

    return filled


@cache
def rda_auth_session() -> requests.Session:
    """Return a pre-authenticated session with RDA."""
    session = requests.Session()

    session.post(
        DOWNLOAD_AUTH_URL,
        data={
            'action': 'login',
            'email': RDA_USER,
            'passwd': RDA_PASSWORD,
        },
    )

    return session


def download_cfsr_5day_tar(
    *,
    start_date: dt.date,
    output_dir: Path,
) -> Path:
    """Download a 5-day .tar file from RDA.

    The end date is calculated from `start_date`; the last day of the month is used if
    `start_date + 5` is in the next month.
    """
    session = rda_auth_session()
    url = cfsr_5day_tar_url(start_date=start_date)

    response = session.get(url, stream=True)

    if not response.ok:
        msg = f'There was an error downloading {url}. Status: {response.status_code}.'
        logger.error(msg)
        raise DownloadError(msg)

    # NOTE: RDA doesn't provide a content-disposition header, so we have to calculate
    # filename from the URL
    filename = url.split('/')[-1]
    filepath = output_dir / filename
    if filepath.exists():
        msg = f'Already exists: {filepath}'
        logger.error(msg)
        raise DownloadError(msg)

    logger.info(f'Downloading {url}...')
    filepath.parent.mkdir(parents=True, exist_ok=True)
    with open(filepath, 'wb') as f:
        logger.debug(f'Downloading to {filepath}')
        for chunk in response.iter_content(chunk_size=1024):
            if chunk:
                f.write(chunk)

    logger.info(f'Downloaded {url} to {filepath}')
    return filepath
