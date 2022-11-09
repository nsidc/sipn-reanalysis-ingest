import datetime as dt

from sipn_reanalysis_ingest._types import CfsrProductType


def cfsr_5day_input_identifier(
    *,
    window_start: dt.date,
    window_end: dt.date,
    product_type: CfsrProductType,
) -> str:
    return f'{window_start:%Y%m%d}-{window_end:%Y%m%d}_{product_type.value}'
