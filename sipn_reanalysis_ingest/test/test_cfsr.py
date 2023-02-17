import datetime as dt

import pytest

from sipn_reanalysis_ingest.util.cfsr import (
    _expected_5daily_6hourly_forecast_suffixes_for_date,
)


@pytest.mark.parametrize(
    'date,expected',
    [
        pytest.param(
            dt.date(2000, 1, 1),
            [
                '1999123118.grb2',
                '2000010100.grb2',
                '2000010106.grb2',
                '2000010112.grb2',
            ],
        ),
        pytest.param(
            dt.date(2000, 12, 31),
            [
                '2000123018.grb2',
                '2000123100.grb2',
                '2000123106.grb2',
                '2000123112.grb2',
            ],
        ),
    ],
)
def test__expected_5daily_6hourly_forecast_suffixes_for_date(date, expected):
    actual = _expected_5daily_6hourly_forecast_suffixes_for_date(date)
    assert actual == expected
