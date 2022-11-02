import datetime as dt

import pytest

from sipn_reanalysis_ingest.errors import ProgrammerError
from sipn_reanalysis_ingest.util.url import _5day_end_date_from_start_date


@pytest.mark.parametrize(
    'start_date,expected',
    [
        pytest.param(
            dt.date(2010, 1, 1),
            dt.date(2010, 1, 5),
        ),
        pytest.param(
            dt.date(2010, 1, 2),
            pytest.raises(ProgrammerError),
        ),
        pytest.param(
            dt.date(1989, 1, 1),
            dt.date(1989, 1, 5),
        ),
        pytest.param(
            dt.date(1989, 1, 2),
            pytest.raises(ProgrammerError),
        ),
        pytest.param(
            dt.date(2000, 2, 26),
            dt.date(2000, 2, 29),
        ),
        pytest.param(
            dt.date(2001, 2, 26),
            dt.date(2001, 2, 28),
        ),
    ],
)
def test__5day_end_date_from_start_date(start_date, expected):
    if isinstance(expected, dt.date):
        actual = _5day_end_date_from_start_date(start_date)
        assert actual == expected
        return

    # If the `expected` is not a date, assume it's a pytest.raises context
    with expected:
        _5day_end_date_from_start_date(start_date)
