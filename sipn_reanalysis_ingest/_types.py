import datetime as dt
import enum
from typing import Literal

TemplateUrlByDateRange = dict[tuple[dt.date, dt.date], str]
CfsrDatasetVersion = Literal[1, 2]
CfsrDatasetId = Literal['ds093.0', 'ds094.0', 'ds093.2', 'ds094.2']
CfsrPeriodicity = Literal['daily', 'monthly']


class CfsrGranuleProductType(enum.Enum):
    """Define product types of CFSR 5-day files we can download.

    Analysis data are measured or calculated values for a given point in time.

    Forecast data are expected values for the future, so we need to look
    back by one time unit at this data to see expected values for a given time. E.g., to
    get the values for 2022-01-01 at a 6-hour resolution, we need to look at 2021-12-31
    18:00 to 2022-01-01 18:00.
    """

    ANALYSIS = 'analysis'
    FORECAST = 'forecast'
