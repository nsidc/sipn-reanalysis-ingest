import datetime as dt

from sipn_reanalysis_ingest._types import (
    CfsrDatasetId,
    CfsrDatasetVersion,
    CfsrPeriodicity,
)

CFSR_VERSION_BY_DATE: dict[tuple[dt.date, dt.date], CfsrDatasetVersion] = {
    (dt.date(1979, 1, 1), dt.date(2010, 12, 31)): 1,
    (dt.date(2011, 1, 1), dt.date.today()): 2,
}
CFSR_DATASET_IDS: dict[tuple[CfsrPeriodicity, CfsrDatasetVersion], CfsrDatasetId] = {
    ('daily', 1): 'ds093.0',
    ('daily', 2): 'ds094.0',
    ('monthly', 1): 'ds093.2',
    ('monthly', 2): 'ds094.2',
}

CFSR_DAILY_TAR_AFTER = dt.date(2011, 4, 1) 
