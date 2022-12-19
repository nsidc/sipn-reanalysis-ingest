import datetime as dt
import functools

import pytest

from sipn_reanalysis_ingest._types import CfsrGranuleProductType
from sipn_reanalysis_ingest.util.date import YearMonth
from sipn_reanalysis_ingest.util.url import (
    cfsr_5day_tar_url,
    cfsr_monthly_tar_url,
    cfsr_yearly_tar_url,
)


@pytest.mark.parametrize(
    'window_start,product_type,expected',
    [
        pytest.param(
            dt.date(1990, 1, 1),
            CfsrGranuleProductType.ANALYSIS,
            'https://rda.ucar.edu/data/ds093.0/1990/pgbhnl.gdas.19900101-19900105.tar',
        ),
        pytest.param(
            dt.date(2010, 12, 26),
            CfsrGranuleProductType.ANALYSIS,
            'https://rda.ucar.edu/data/ds093.0/2010/pgbhnl.gdas.20101226-20101231.tar',
        ),
        pytest.param(
            dt.date(2011, 1, 1),
            CfsrGranuleProductType.FORECAST,
            'https://rda.ucar.edu/data/ds094.0/2011/pgbh06.gdas.20110101-20110105.tar',
        ),
        pytest.param(
            dt.date(2020, 1, 1),
            CfsrGranuleProductType.FORECAST,
            'https://rda.ucar.edu/data/ds094.0/2020/pgbh06.gdas.20200101-20200105.tar',
        ),
    ],
)
def test_cfsr_5day_tar_url(window_start, product_type, expected):
    actual = cfsr_5day_tar_url(window_start=window_start, product_type=product_type)
    assert actual == expected


@pytest.mark.parametrize(
    'month,expected',
    [
        pytest.param(
            YearMonth(year=1990, month=1),
            pytest.raises(RuntimeError),
        ),
        pytest.param(
            YearMonth(year=2011, month=1),
            'https://rda.ucar.edu/data/ds094.2/regular/pgbh.gdas.201101.tar',
        ),
        pytest.param(
            YearMonth(year=2011, month=12),
            'https://rda.ucar.edu/data/ds094.2/regular/pgbh.gdas.201112.tar',
        ),
        pytest.param(
            YearMonth(year=2020, month=1),
            'https://rda.ucar.edu/data/ds094.2/regular/pgbh.gdas.202001.tar',
        ),
    ],
)
def test_cfsr_monthly_tar_url(month, expected):
    test_func = functools.partial(
        cfsr_monthly_tar_url,
        month=month,
    )
    if isinstance(expected, str):
        actual = test_func()
        assert actual == expected
        return

    # If the `expected` is not a str, assume it's a pytest.raises context
    with expected:
        test_func()


@pytest.mark.parametrize(
    'year,product_type,expected',
    [
        pytest.param(
            1979,
            CfsrGranuleProductType.ANALYSIS,
            'https://rda.ucar.edu/data/ds093.2/regular/pgbhnl.gdas.1979.tar',
        ),
        pytest.param(
            1990,
            CfsrGranuleProductType.ANALYSIS,
            'https://rda.ucar.edu/data/ds093.2/regular/pgbhnl.gdas.1990.tar',
        ),
        pytest.param(
            2010,
            CfsrGranuleProductType.FORECAST,
            'https://rda.ucar.edu/data/ds093.2/regular/pgbh06.gdas.2010.tar',
        ),
        pytest.param(
            2011,
            CfsrGranuleProductType.FORECAST,
            pytest.raises(RuntimeError),
        ),
    ],
)
def test_cfsr_yearly_tar_url(year, product_type, expected):
    test_func = functools.partial(
        cfsr_yearly_tar_url,
        year=year,
        product_type=product_type,
    )
    if isinstance(expected, str):
        actual = test_func()
        assert actual == expected
        return

    # If the `expected` is not a str, assume it's a pytest.raises context
    with expected:
        test_func()
