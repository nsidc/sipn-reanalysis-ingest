import datetime as dt

from sipn_reanalysis_ingest._types import CfsrPeriod
from sipn_reanalysis_ingest.constants.download import DOWNLOAD_FILE_URL_TEMPLATES
from sipn_reanalysis_ingest.errors import ProgrammerError
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
