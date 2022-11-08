import datetime as dt
from functools import cache
from pathlib import Path

import requests
from loguru import logger

from sipn_reanalysis_ingest.constants.creds import RDA_PASSWORD, RDA_USER
from sipn_reanalysis_ingest.constants.download import DOWNLOAD_AUTH_URL
from sipn_reanalysis_ingest.errors import CredentialsError, DownloadError
from sipn_reanalysis_ingest.util.url import cfsr_5day_tar_url


@cache
def rda_auth_session() -> requests.Session:
    """Return a pre-authenticated session with RDA.

    WARNING: This function MUST be cached to avoid being banned from RDA for authing too
    much.
    """
    session = requests.Session()

    if not RDA_USER:
        raise CredentialsError('$RDA_USER must be set.')
    if not RDA_PASSWORD:
        raise CredentialsError('$RDA_PASSWORD must be set.')

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
    output_fp: Path,
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

    if output_fp.exists():
        msg = f'Already exists: {output_fp}'
        logger.error(msg)
        raise DownloadError(msg)

    logger.info(f'Downloading {url}...')
    output_fp.parent.mkdir(parents=True, exist_ok=True)
    with open(output_fp, 'wb') as f:
        logger.debug(f'Downloading to {output_fp}')
        for chunk in response.iter_content(chunk_size=1024):
            if chunk:
                f.write(chunk)

    logger.info(f'Downloaded {url} to {output_fp}')
    return output_fp
