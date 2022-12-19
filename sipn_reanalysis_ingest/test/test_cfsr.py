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
                '2019123118.grb2',
                '2020010100.grb2',
                '2020010106.grb2',
                '2020010112.grb2',
            ],
        ),
        pytest.param(
            dt.date(2020, 12, 31),
            [
                '2020123018.grb2',
                '2020123100.grb2',
                '2020123106.grb2',
                '2020123112.grb2',
            ],
        ),
    ],
)
def test__expected_6hourly_forecast_suffixes_for_date(date, expected):
    actual = _expected_6hourly_forecast_suffixes_for_date(date)
    assert actual == expected
