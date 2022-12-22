import pytest

from sipn_reanalysis_ingest.util.variables import get_all_grib_variables


@pytest.mark.parametrize(
    'periodicity',
    [
        pytest.param(
            'daily',
        ),
        pytest.param(
            'monthly',
        ),
    ],
)
def test_get_all_grib_variables(periodicity):
    actual = get_all_grib_variables(periodicity)
    assert len(actual) == 25
    assert all(a.endswith('GLL0') for a in actual)
