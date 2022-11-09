import calendar
import datetime as dt
from typing import Iterator

from sipn_reanalysis_ingest.errors import ProgrammerError


# TODO: Unit test
def is_valid_cfsr_window_start_date(date: dt.date) -> bool:
    """Validate whether `date` is a valid start date of a ~5-day CFSR window.

    Windows start on 1st, 6th, 11th, ..., and 26th. Depending on the length of the
    month, the final window may have from 3 to 6 days.
    """
    if date.day > 26:
        return False

    if date.day % 5 == 1:
        return True

    return False


def date_range(start: dt.date, end: dt.date) -> Iterator[dt.date]:
    """Generate list of dates between start and end, inclusive."""
    delta = end - start

    for i in range(delta.days + 1):
        yield start + dt.timedelta(days=i)


def date_range_windows(
    start: dt.date,
    end: dt.date,
) -> Iterator[tuple[dt.date, dt.date]]:
    """Generate list of ~5-day windows between `start` and `end`, inclusive.

    The first and last windows will be smaller if the start or end date (respectively)
    do not land on the start or end of a CFSR 5-day interval.
    """
    cfsr_start_dates_in_range = [
        d for d in date_range(start, end) if is_valid_cfsr_window_start_date(d)
    ]

    if len(cfsr_start_dates_in_range) == 0:
        yield (start, end)
        return

    if start < cfsr_start_dates_in_range[0]:
        # The first interval starts late:
        yield (start, cfsr_start_dates_in_range[0] - dt.timedelta(days=1))

    for cfsr_start_date in cfsr_start_dates_in_range:
        cfsr_end_date = cfsr_5day_window_end_from_start_date(cfsr_start_date)
        if cfsr_end_date <= end:
            yield (cfsr_start_date, cfsr_end_date)
        else:
            # The last interval is truncated to `end`
            yield (cfsr_start_date, end)


def _nearest_5day_start_before_date(date: dt.date) -> dt.date:
    """Find the nearest valid 5-day window start less than or equal to `date`."""
    if date.day >= 26:
        return dt.date(date.year, date.month, 26)

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
    if not is_valid_cfsr_window_start_date(start_date):
        raise ProgrammerError(
            f'Start date ({start_date:%Y-%m-%d}) day portion must be a multiple of 5'
            ' plus one, e.g.: 1, 6, 11, 16, ..., 26'
        )
    if start_date.day == 26:
        # Return the last day of the month:
        last_day = calendar.monthrange(start_date.year, start_date.month)[1]
        return dt.date(start_date.year, start_date.month, last_day)

    plus_5 = start_date + dt.timedelta(days=4)
    if plus_5.month == start_date.month:
        return plus_5

    # Calculate the last day of the previous month, e.g.:
    #    Feb 3 - 3 = Jan 31
    return plus_5 - dt.timedelta(plus_5.day)
