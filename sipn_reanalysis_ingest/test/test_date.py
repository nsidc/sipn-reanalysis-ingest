import datetime as dt

import pytest

from sipn_reanalysis_ingest.errors import CfsrDateError
from sipn_reanalysis_ingest.util.date import (
    Cfsr5ishDayWindow,
    date_range,
    date_range_windows,
)


class TestCfsr5ishDayWindow:
    @pytest.mark.parametrize(
        'date,expected',
        [
            pytest.param(dt.date(2020, 1, 1), True),
            pytest.param(dt.date(2020, 1, 2), False),
            pytest.param(dt.date(2020, 1, 5), False),
            pytest.param(dt.date(2020, 1, 26), True),
            pytest.param(dt.date(2020, 1, 31), False),
            pytest.param(dt.date(2020, 2, 26), True),
            pytest.param(dt.date(2020, 2, 29), False),
            pytest.param(dt.date(2021, 2, 26), True),
            pytest.param(dt.date(2021, 2, 28), False),
            pytest.param(dt.date(2021, 12, 31), False),
        ],
    )
    def test_is_valid_start(self, date, expected):
        actual = Cfsr5ishDayWindow.is_valid_start(date)
        assert actual == expected

    @pytest.mark.parametrize(
        'start_date,expected',
        [
            pytest.param(
                dt.date(2010, 1, 1),
                dt.date(2010, 1, 5),
            ),
            pytest.param(
                dt.date(2010, 1, 2),
                pytest.raises(CfsrDateError),
            ),
            pytest.param(
                dt.date(1989, 1, 1),
                dt.date(1989, 1, 5),
            ),
            pytest.param(
                dt.date(1989, 1, 2),
                pytest.raises(CfsrDateError),
            ),
            pytest.param(
                dt.date(2000, 1, 26),
                dt.date(2000, 1, 31),
            ),
            pytest.param(
                dt.date(2000, 2, 26),
                dt.date(2000, 2, 29),
            ),
            pytest.param(
                dt.date(2001, 2, 26),
                dt.date(2001, 2, 28),
            ),
            pytest.param(
                dt.date(2000, 4, 26),
                dt.date(2000, 4, 30),
            ),
        ],
    )
    def test_calculate_window_end_from_start(self, start_date, expected):
        if isinstance(expected, dt.date):
            actual = Cfsr5ishDayWindow.calculate_window_end_from_start(start_date)
            assert actual == expected
            return

        # If the `expected` is not a date, assume it's a pytest.raises context
        with expected:
            Cfsr5ishDayWindow.calculate_window_end_from_start(start_date)

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
                dt.date(2020, 11, 29),
                (dt.date(2020, 11, 26), dt.date(2020, 11, 30)),
            ),
            pytest.param(
                dt.date(2020, 12, 31),
                (dt.date(2020, 12, 26), dt.date(2020, 12, 31)),
            ),
        ],
    )
    def test_from_date_in_window(self, date, expected):
        actual = Cfsr5ishDayWindow.from_date_in_window(date)
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
    'range_endpoints,expected',
    [
        pytest.param(
            (dt.date(2001, 1, 1), dt.date(2001, 1, 5)),
            [
                (dt.date(2001, 1, 1), dt.date(2001, 1, 5)),
            ],
        ),
        pytest.param(
            (dt.date(2001, 1, 1), dt.date(2001, 1, 6)),
            [
                (dt.date(2001, 1, 1), dt.date(2001, 1, 5)),
                (dt.date(2001, 1, 6), dt.date(2001, 1, 6)),
            ],
        ),
        pytest.param(
            (dt.date(2001, 1, 4), dt.date(2001, 1, 5)),
            [
                (dt.date(2001, 1, 4), dt.date(2001, 1, 5)),
            ],
        ),
        pytest.param(
            (dt.date(2001, 1, 10), dt.date(2001, 1, 17)),
            [
                (dt.date(2001, 1, 10), dt.date(2001, 1, 10)),
                (dt.date(2001, 1, 11), dt.date(2001, 1, 15)),
                (dt.date(2001, 1, 16), dt.date(2001, 1, 17)),
            ],
        ),
        pytest.param(
            (dt.date(2001, 1, 1), dt.date(2001, 2, 28)),
            [
                (dt.date(2001, 1, 1), dt.date(2001, 1, 5)),
                (dt.date(2001, 1, 6), dt.date(2001, 1, 10)),
                (dt.date(2001, 1, 11), dt.date(2001, 1, 15)),
                (dt.date(2001, 1, 16), dt.date(2001, 1, 20)),
                (dt.date(2001, 1, 21), dt.date(2001, 1, 25)),
                (dt.date(2001, 1, 26), dt.date(2001, 1, 31)),
                (dt.date(2001, 2, 1), dt.date(2001, 2, 5)),
                (dt.date(2001, 2, 6), dt.date(2001, 2, 10)),
                (dt.date(2001, 2, 11), dt.date(2001, 2, 15)),
                (dt.date(2001, 2, 16), dt.date(2001, 2, 20)),
                (dt.date(2001, 2, 21), dt.date(2001, 2, 25)),
                (dt.date(2001, 2, 26), dt.date(2001, 2, 28)),
            ],
        ),
    ],
)
def test_date_range_windows(range_endpoints, expected):
    actual = list(date_range_windows(*range_endpoints))
    assert actual == expected
