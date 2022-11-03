import datetime as dt

from sipn_reanalysis_ingest._types import CfsrPeriod
from sipn_reanalysis_ingest.constants.download import DOWNLOAD_FILE_URL_TEMPLATES
from sipn_reanalysis_ingest.util.date import cfsr_5day_window_end_from_start_date
from sipn_reanalysis_ingest.util.misc import range_lookup


def cfsr_tar_url_template(
    *,
    start_date: dt.date,
    periodicity: CfsrPeriod,
) -> str:
    """Return the correct template for the given date and periodicity."""
    templates_by_date_range = DOWNLOAD_FILE_URL_TEMPLATES[periodicity]
    template = range_lookup(templates_by_date_range, start_date)
    return template


def cfsr_5day_tar_url(
    *,
    start_date: dt.date,
) -> str:
    template = cfsr_tar_url_template(start_date=start_date, periodicity='five_daily')
    end_date = cfsr_5day_window_end_from_start_date(start_date)
    fn = f'pgbhnl.gdas.{start_date:%Y%m%d}-{end_date:%Y%m%d}.tar'

    filled = template.format(year=start_date.year, filename=fn)

    return filled
