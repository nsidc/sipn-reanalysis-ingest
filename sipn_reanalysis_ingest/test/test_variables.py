import pytest

from sipn_reanalysis_ingest.util.variables import (
    get_all_grib_variables,
    var_rename_mapping,
)


@pytest.mark.parametrize(
    'periodicity',
    [
        pytest.param('daily'),
        pytest.param('monthly'),
    ],
)
def test_get_all_grib_variables(periodicity):
    actual = get_all_grib_variables(periodicity)
    assert len(actual) == 13
    assert all(a.endswith('GLL0') for a in actual)


def test_var_rename_mapping():
    actual = var_rename_mapping('monthly')
    assert actual == {
        'HGT_P8_L100_GLL0': 'HGT',
        'PRMSL_P8_L101_GLL0': 'MSLP',
        'PWAT_P8_L200_GLL0': 'PWAT',
    }
