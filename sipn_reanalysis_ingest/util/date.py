import calendar
import datetime as dt
from collections.abc import Iterator
from dataclasses import dataclass
from typing import ClassVar

from sipn_reanalysis_ingest.errors import CfsrDateError, ProgrammerError


@dataclass
class YearMonth:
    year: int
    month: int

    def __str__(self):
        return f'{self.year}{self.month:02}'


@dataclass
class Cfsr5ishDayWindow:
    """Represents a ~5-day window for downloading 6-hourly CFSR products.

    Windows are 5 days long (inclusive, e.g. 2010-01-01 to 2010-01-05) in all cases
    except the end of the month. The last window of a month _always_ starts on the 26th
    and can be 3-6 days long (e.g. 2010-12-26 to 2010-12-31; or 2000-02-26 to
    2000-02-28).
    """

    VALID_WINDOW_START_DAYS: ClassVar[list[int]] = [1, 6, 11, 16, 21, 26]

    start: dt.date
    end: dt.date

    def __init__(self, *, start: dt.date, end: dt.date):
        self.start = self.validate_window_start(start)
        self.end = self.validate_window_end(start, end)

    def __repr__(self):
        return f'{self.__class__.__name__}(start={self.start}, end={self.end})'

    def __eq__(self, other) -> bool:
        if isinstance(other, self.__class__):
            return self.start == other.start and self.end == other.end
        if isinstance(other, tuple) and len(other) == 2:
            return self.start == other[0] and self.end == other[1]
        return False

    @classmethod
    def from_window_start(cls, start: dt.date):
        return cls(
            start=start,
            end=cls.calculate_window_end_from_start(start),
        )

    @classmethod
    def from_date_in_window(cls, date: dt.date):
        window = cls.calculate_window_containing_date(date)
        return cls(
            start=window[0],
            end=window[1],
        )

    @classmethod
    def validate_window_start(cls, date: dt.date) -> dt.date:
        if not cls.is_valid_start(date):
            raise CfsrDateError(
                f'CFSR 5-ish-day window start {date} is invalid. Day must be in'
                f' {cls.VALID_WINDOW_START_DAYS}'
            )
        return date

    @classmethod
    def is_valid_start(cls, date: dt.date) -> bool:
        """Validate whether `date` is a valid start date of a ~5-day CFSR window."""
        if date.day in cls.VALID_WINDOW_START_DAYS:
            return True
        return False

    @classmethod
    def validate_window_end(cls, start: dt.date, end: dt.date) -> dt.date:
        if not cls.is_valid_end(start, end):
            raise CfsrDateError(
                f'CFSR 5-ish-day window end {end} is not valid'
                f' for window start {start}'
            )
        return end

    @classmethod
    def is_valid_end(cls, start: dt.date, end: dt.date) -> bool:
        """Validate whether `end` is valid in relation to `start`.

        E.g. 2010-01-05 may look like a valid end date, but not if the start date is
        2001-01-01 because the difference is years.
        """
        expected_end = cls.calculate_window_end_from_start(start)
        if end == expected_end:
            return True
        return False

    @classmethod
    def calculate_window_end_from_start(cls, date: dt.date) -> dt.date:
        """Calculate end date of CFSR 5-day window based on start date.

        Because the CFSR files are named with inclusive intervals, the actual difference
        between the start and end dates is 4 days, although the files each contain 5
        days of data.
        """
        cls.validate_window_start(date)
        if date.day == 26:
            # Return the last day of the month:
            last_day = calendar.monthrange(date.year, date.month)[1]
            return dt.date(date.year, date.month, last_day)

        plus_5 = date + dt.timedelta(days=4)
        if plus_5.month != date.month:
            raise ProgrammerError(
                f'CFSR 5-ish-day window end {plus_5} is invalid. Must be in same month'
                f' as window start {date}'
            )

        return plus_5

    @classmethod
    def calculate_window_containing_date(cls, date: dt.date) -> tuple[dt.date, dt.date]:
        """Calculate a CFSR 5-day window containing `date`."""
        start_date = cls.calculate_window_start_for_date(date)
        end_date = cls.calculate_window_end_from_start(start_date)
        return (start_date, end_date)

    @classmethod
    def calculate_window_start_for_date(cls, date: dt.date) -> dt.date:
        """Calculate the nearest valid start date less than or equal to `date`."""
        start_day = [day for day in cls.VALID_WINDOW_START_DAYS if day <= date.day][-1]
        start_date = dt.date(date.year, date.month, start_day)
        return start_date


def date_range(start: dt.date, end: dt.date) -> Iterator[dt.date]:
    """Generate list of dates between start and end, inclusive."""
    delta = end - start

    for i in range(delta.days + 1):
        yield start + dt.timedelta(days=i)


def _months_since_0ad(date: dt.date) -> int:
    """Calculate the number of months between 0 AD and `month`.

    Ignore day portion of `date`.

    NOTE: Python's built-in datetime module doesn't support 0AD. This is only a hack for
    calculating month ranges, since Python's built-in datetime module also doesn't
    support adding or subtracting months (ignoring month length).
    """
    num_months = (12 * date.year) + date.month
    return num_months


def _yearmonth_from_months_since_0ad(months_since_0ad: int) -> YearMonth:
    divisor = 12
    quotient, remainder = divmod(months_since_0ad, divisor)

    # Handle the December case: remainder is 0, and quotient is 1 higher than it should
    # be. e.g. Dec of 0 A.D. would be 12 months since 0 A.D., and after division have
    # quotient 1 and remainder 0, but we want to return (year=0, month=12).
    if remainder == 0:
        return YearMonth(year=quotient - 1, month=divisor)

    # The simple case (all other months). e.g. November of 0 A.D. would be 11 months
    # since 0 A.D. The division operation yields quotient 0 and remainder 11.
    return YearMonth(year=quotient, month=remainder)


def month_range(
    start: dt.date,
    end: dt.date,
) -> list[YearMonth]:
    """List months that lie within `start` and `end` ("day" portion of dates ignored).

    The result is inclusive, e.g. if `end` is `2022-01-01`, then `(2022, 1)` will be in
    the result.
    """
    start_months_since_0ad = _months_since_0ad(start)
    end_months_since_0ad = _months_since_0ad(end)

    # Add 1 to generate inclusive closed interval result
    month_indexes_since_0ad = range(start_months_since_0ad, end_months_since_0ad + 1)

    months = [_yearmonth_from_months_since_0ad(m) for m in month_indexes_since_0ad]
    return months
