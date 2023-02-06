import datetime as dt

import pytest

from sipn_reanalysis_ingest.util.cfsr import (
    _expected_6hourly_forecast_suffixes_for_date,
)


@pytest.mark.parametrize(
    'date,expected',
    [
        pytest.param(
            dt.date(2020, 1, 1),
            [
                '2019123118.gr*b2',
                '2020010100.gr*b2',
                '2020010106.gr*b2',
                '2020010112.gr*b2',
            ],
        ),
        pytest.param(
            dt.date(2020, 12, 31),
            [
                '2020123018.gr*b2',
                '2020123100.gr*b2',
                '2020123106.gr*b2',
                '2020123112.gr*b2',
            ],
        ),
    ],
)
def test__expected_6hourly_forecast_suffixes_for_date(date, expected):
    actual = _expected_6hourly_forecast_suffixes_for_date(date)
    assert actual == expected
