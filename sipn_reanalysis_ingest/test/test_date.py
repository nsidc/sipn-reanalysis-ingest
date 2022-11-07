import datetime as dt

import pytest

from sipn_reanalysis_ingest.errors import ProgrammerError
from sipn_reanalysis_ingest.util.date import (
    cfsr_5day_window_containing_date,
    cfsr_5day_window_end_from_start_date,
    date_range,
)


@pytest.mark.parametrize(
    'date,expected',
    [
        pytest.param(
            dt.date(2020, 1, 1),
            (dt.date(2020, 1, 1), dt.date(2020, 1, 5)),
        ),
        pytest.param(
            dt.date(2020, 1, 2),
            (dt.date(2020, 1, 1), dt.date(2020, 1, 5)),
        ),
        pytest.param(
            dt.date(2020, 1, 3),
            (dt.date(2020, 1, 1), dt.date(2020, 1, 5)),
        ),
        pytest.param(
            dt.date(2020, 1, 4),
            (dt.date(2020, 1, 1), dt.date(2020, 1, 5)),
        ),
        pytest.param(
            dt.date(2020, 1, 5),
            (dt.date(2020, 1, 1), dt.date(2020, 1, 5)),
        ),
        pytest.param(
            dt.date(2020, 2, 29),
            (dt.date(2020, 2, 26), dt.date(2020, 2, 29)),
        ),
        pytest.param(
            dt.date(2020, 12, 31),
            (dt.date(2020, 12, 31), dt.date(2020, 12, 31)),
        ),
    ],
)
def test_cfsr_5day_window_containing_date(date, expected):
    actual = cfsr_5day_window_containing_date(date)
    assert actual == expected


@pytest.mark.parametrize(
    'range_endpoints,expected_len',
    [
        pytest.param(
            (dt.date(2000, 1, 1), dt.date(2000, 1, 5)),
            5,
        ),
        pytest.param(
            (dt.date(1979, 1, 1), dt.date(2020, 1, 1)),
            14_976,
        ),
    ],
)
def test_date_range(range_endpoints, expected_len):
    actual = date_range(*range_endpoints)
    assert len(list(actual)) == expected_len
    assert all(isinstance(d, dt.date) for d in actual)


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
def test_cfsr_5day_window_end_from_start_date(start_date, expected):
    if isinstance(expected, dt.date):
        actual = cfsr_5day_window_end_from_start_date(start_date)
        assert actual == expected
        return

    # If the `expected` is not a date, assume it's a pytest.raises context
    with expected:
        cfsr_5day_window_end_from_start_date(start_date)
