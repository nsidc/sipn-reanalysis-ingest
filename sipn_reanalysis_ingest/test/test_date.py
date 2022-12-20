import datetime as dt
import functools

import pytest

from sipn_reanalysis_ingest.errors import CfsrDateError
from sipn_reanalysis_ingest.util.date import Cfsr5ishDayWindow, date_range, month_range


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
        test_func = functools.partial(
            Cfsr5ishDayWindow.calculate_window_end_from_start,
            start_date,
        )

        if isinstance(expected, dt.date):
            actual = test_func()
            assert actual == expected
            return

        # If the `expected` is not a date, assume it's a pytest.raises context
        with expected:
            test_func()

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
            (dt.date(2021, 1, 1), dt.date(2021, 1, 1)),
            [
                {'year': 2021, 'month': 1},
            ],
        ),
        pytest.param(
            (dt.date(2021, 1, 31), dt.date(2021, 2, 1)),
            [
                {'year': 2021, 'month': 1},
                {'year': 2021, 'month': 2},
            ],
        ),
        pytest.param(
            (dt.date(2021, 1, 15), dt.date(2021, 5, 3)),
            [{'year': 2021, 'month': n} for n in range(1, 5 + 1)],
        ),
        pytest.param(
            (dt.date(1981, 1, 1), dt.date(1982, 3, 1)),
            [
                *[{'year': 1981, 'month': n} for n in range(1, 12 + 1)],
                {'year': 1982, 'month': 1},
                {'year': 1982, 'month': 2},
                {'year': 1982, 'month': 3},
            ],
        ),
    ],
)
def test_month_range(range_endpoints, expected):
    actual = month_range(*range_endpoints)
    assert [a.__dict__ for a in actual] == expected


@pytest.mark.parametrize(
    'range_endpoints,expected_len',
    [
        pytest.param((dt.date(2021, 1, 1), dt.date(2021, 1, 1)), 1),
        pytest.param((dt.date(2021, 1, 1), dt.date(2022, 1, 1)), 13),
        pytest.param((dt.date(2021, 1, 31), dt.date(2021, 2, 1)), 2),
        pytest.param((dt.date(2017, 1, 31), dt.date(2021, 2, 1)), 50),
    ],
)
def test_month_range_by_len(range_endpoints, expected_len):
    actual = len(month_range(*range_endpoints))
    assert actual == expected_len
