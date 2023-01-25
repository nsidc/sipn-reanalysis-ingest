import datetime as dt

DEFAULT_PROCESSING_DAY = dt.datetime.today().date() - dt.timedelta(days=1)
DEFAULT_PROCESSING_MONTH = f'{DEFAULT_PROCESSING_DAY:%Y-%m}'

CFSR_DAILY_TAR_BEFORE = dt.datetime(2011,4,1)
