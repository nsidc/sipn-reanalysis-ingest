import datetime as dt

from sipn_reanalysis_ingest._types import CfsrPeriod, CfsrProductType
from sipn_reanalysis_ingest.constants.download import (
    DOWNLOAD_FILE_NAME_TEMPLATES,
    DOWNLOAD_FILE_URL_TEMPLATES,
)
from sipn_reanalysis_ingest.util.date import cfsr_5day_window_end_from_start_date
from sipn_reanalysis_ingest.util.misc import range_lookup


def cfsr_tar_url_template(
    *,
    window_start: dt.date,
    periodicity: CfsrPeriod,
) -> str:
    templates_by_date_range = DOWNLOAD_FILE_URL_TEMPLATES[periodicity]
    template = range_lookup(templates_by_date_range, window_start)

    return template


def cfsr_tar_url(
    *,
    window_start: dt.date,
    periodicity: CfsrPeriod,
    filename: str,
) -> str:
    """Return the correct template for the given date and periodicity."""
    template = cfsr_tar_url_template(
        window_start=window_start,
        periodicity=periodicity,
    )

    url = template.format(year=window_start.year, filename=filename)
    return url


def cfsr_tar_filename(
    *,
    window_start: dt.date,
    window_end: dt.date,
    product_type: CfsrProductType,
) -> str:
    template = DOWNLOAD_FILE_NAME_TEMPLATES[product_type]['tar_filename_template']

    filename = template.format(window_start=window_start, window_end=window_end)
    return filename


def cfsr_5day_tar_url(
    *,
    window_start: dt.date,
    product_type: CfsrProductType,
) -> str:
    window_end = cfsr_5day_window_end_from_start_date(window_start)
    fn = cfsr_tar_filename(
        window_start=window_start,
        window_end=window_end,
        product_type=product_type,
    )

    url = cfsr_tar_url(
        window_start=window_start,
        filename=fn,
        periodicity='five_daily',
    )
    return url
