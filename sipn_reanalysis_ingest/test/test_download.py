import datetime as dt

import pytest

from sipn_reanalysis_ingest._types import CfsrProductType
from sipn_reanalysis_ingest.constants.paths import DATA_DOWNLOAD_DIR
from sipn_reanalysis_ingest.util.download import download_dir


@pytest.mark.parametrize(
    'window_start,window_end,product_type,expected',
    [
        pytest.param(
            dt.date(2010, 1, 1),
            dt.date(2010, 1, 5),
            CfsrProductType.ANALYSIS,
            DATA_DOWNLOAD_DIR / '20100101-20100105_analysis',
        ),
        pytest.param(
            dt.date(2010, 1, 1),
            dt.date(2010, 1, 5),
            CfsrProductType.FORECAST,
            DATA_DOWNLOAD_DIR / '20100101-20100105_forecast',
        ),
    ],
)
def test_download_dir(window_start, window_end, product_type, expected):
    actual = download_dir(
        window_start=window_start,
        window_end=window_end,
        product_type=product_type,
    )
    assert actual == expected
