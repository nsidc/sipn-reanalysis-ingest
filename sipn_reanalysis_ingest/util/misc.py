from typing import Any, TypeVar

from sipn_reanalysis_ingest.errors import RangeLookupError

T = TypeVar('T')


def range_lookup(
    d: dict[tuple[Any, Any], T],
    lookup_key: Any,
) -> T:
    """Lookup elements in a dict keyed by a tuple representing a range of values.

    When lookup_key is between the two values in the tuple, we've found a match.
    """
    values_matching_lookup_key = [
        value for key, value in d.items() if key[0] <= lookup_key <= key[1]
    ]
    if (count := len(values_matching_lookup_key)) != 1:
        raise RangeLookupError(f'{count} matches for {lookup_key=}; expected exactly 1')

    return values_matching_lookup_key[0]
