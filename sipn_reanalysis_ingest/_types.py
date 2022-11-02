import datetime as dt
from typing import Literal

from typing_extensions import TypedDict

TemplateUrlByDateRange = dict[tuple[dt.date, dt.date], str]
# WARNING: Must be kept in Sync with DownloadFileUrlTemplates TypedDict
CfsrPeriod = Literal['five_daily', 'monthly']


class DownloadFileUrlTemplates(TypedDict):
    five_daily: TemplateUrlByDateRange
    monthly: TemplateUrlByDateRange
