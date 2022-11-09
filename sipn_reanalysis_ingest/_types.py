import datetime as dt
import enum
from typing import Literal

from typing_extensions import TypedDict

TemplateUrlByDateRange = dict[tuple[dt.date, dt.date], str]
# WARNING: Must be kept in Sync with DownloadFileUrlTemplates TypedDict
CfsrPeriod = Literal['five_daily', 'monthly']


class DownloadFileUrlTemplates(TypedDict):
    five_daily: TemplateUrlByDateRange
    monthly: TemplateUrlByDateRange


class CfsrProductType(enum.Enum):
    """Define product types of CFSR 5-day files we can download.

    Analysis data are measured or calculated values for a given point in time.

    Forecast data are expected values for the future, so we need to look
    back by one time unit at this data to see expected values for a given time. E.g., to
    get the values for 2022-01-01 at a 6-hour resolution, we need to look at 2021-12-31
    18:00 to 2022-01-01 18:00.
    """

    ANALYSIS = 'analysis'
    FORECAST = 'forecast'


class Cfsr5DayDownload(TypedDict):
    tar_filename_template: str
    grib2_filename_template: str


Cfsr5DayProductDownloadTypes = dict[CfsrProductType, Cfsr5DayDownload]
