import datetime as dt

import pytest

from sipn_reanalysis_ingest.util.url import cfsr_tar_url_template


# TODO: Monthly url tests
@pytest.mark.parametrize(
    'start_date,periodicity,expected',
    [
        pytest.param(
            dt.date(1990, 1, 1),
            'five_daily',
            'https://rda.ucar.edu/data/ds093.0/{year}/{filename}',  # noqa:FS003
        ),
        pytest.param(
            dt.date(2010, 12, 31),
            'five_daily',
            'https://rda.ucar.edu/data/ds093.0/{year}/{filename}',  # noqa:FS003
        ),
        pytest.param(
            dt.date(2011, 1, 1),
            'five_daily',
            'https://rda.ucar.edu/data/ds094.0/{year}/{filename}',  # noqa:FS003
        ),
        pytest.param(
            dt.date(2020, 1, 1),
            'five_daily',
            'https://rda.ucar.edu/data/ds094.0/{year}/{filename}',  # noqa:FS003
        ),
    ],
)
def test_cfsr_tar_url_template(start_date, periodicity, expected):
    actual = cfsr_tar_url_template(start_date=start_date, periodicity=periodicity)
    assert actual == expected
