import datetime as dt
from typing import Iterator

from sipn_reanalysis_ingest.errors import ProgrammerError


def date_range(start: dt.date, end: dt.date) -> Iterator[dt.date]:
    """Generate list of dates between start and end, inclusive."""
    delta = end - start

    for i in range(delta.days + 1):
        yield start + dt.timedelta(days=i)


def _nearest_5day_start_before_date(date: dt.date) -> dt.date:
    """Find the nearest valid 5-day window start before `date`."""
    window_size = 5
    offset = 1
    if date.day % window_size == offset:
        # This is already a valid start date!
        return date

    # Find nearest (smaller) multiple of 5, then add 1 (since the month starts on 1st).
    day = (((date.day - 1) // window_size) * window_size) + offset
    return dt.date(date.year, date.month, day)


def cfsr_5day_window_containing_date(date: dt.date) -> tuple[dt.date, dt.date]:
    """Calculate a CFSR 5-day window containing `date`."""
    start_date = _nearest_5day_start_before_date(date)
    end_date = cfsr_5day_window_end_from_start_date(start_date)
    return (start_date, end_date)


def cfsr_5day_window_end_from_start_date(start_date: dt.date) -> dt.date:
    """Calculate end date of CFSR 5-day window based on start date.

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
