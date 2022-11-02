from typing import Any, TypeVar

from sipn_reanalysis_ingest.errors import RangeLookupError

T = TypeVar('T')


def range_lookup(
    d: dict[tuple[Any, Any], T],
    lookup_key: Any,
) -> T:
    values_matching_lookup_key = [
        value for key, value in d.items() if key[0] <= lookup_key <= key[1]
    ]
    if len(values_matching_lookup_key) > 1:
        raise RangeLookupError(f'>1 match for {lookup_key=}')

    return values_matching_lookup_key[0]
