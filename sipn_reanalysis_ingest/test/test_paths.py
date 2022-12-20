import datetime as dt

import pytest

from sipn_reanalysis_ingest._types import CfsrGranuleProductType
from sipn_reanalysis_ingest.constants.paths import DATA_DOWNLOAD_DIR
from sipn_reanalysis_ingest.util.paths import download_5day_tar_path


@pytest.mark.parametrize(
    'window_start,window_end,product_type,expected',
    [
        pytest.param(
            dt.date(2010, 1, 1),
            dt.date(2010, 1, 5),
            CfsrGranuleProductType.ANALYSIS,
            DATA_DOWNLOAD_DIR / '20100101-20100105_analysis.tar',
        ),
        pytest.param(
            dt.date(2010, 1, 1),
            dt.date(2010, 1, 5),
            CfsrGranuleProductType.FORECAST,
            DATA_DOWNLOAD_DIR / '20100101-20100105_forecast.tar',
        ),
    ],
)
def test_download_5day_tar_path(window_start, window_end, product_type, expected):
    actual = download_5day_tar_path(
        window_start=window_start,
        window_end=window_end,
        product_type=product_type,
    )
    assert actual == expected
