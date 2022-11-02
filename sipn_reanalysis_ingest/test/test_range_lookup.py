import pytest

from sipn_reanalysis_ingest.util.misc import range_lookup

EXAMPLE_RANGE_DICT = {
    (1, 5): 'a',
    (6, 10): 'b',
}


@pytest.mark.parametrize(
    'lookup_key,expected',
    [
        pytest.param(
            1,
            'a',
        ),
        pytest.param(
            5,
            'a',
        ),
        pytest.param(
            6,
            'b',
        ),
        pytest.param(
            10,
            'b',
        ),
    ],
)
def test_range_lookup(lookup_key, expected):
    actual = range_lookup(EXAMPLE_RANGE_DICT, lookup_key)
    assert actual == expected
