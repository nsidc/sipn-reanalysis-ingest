import datetime as dt

from sipn_reanalysis_ingest._types import DownloadFileUrlTemplates

DOWNLOAD_BASE_URL = 'https://rda.ucar.edu'

DOWNLOAD_AUTH_URL = f'{DOWNLOAD_BASE_URL}/cgi-bin/login'
DOWNLOAD_FILE_ROOT_URL = 'https://rda.ucar.edu/data'
DOWNLOAD_FILE_URL_TEMPLATES: DownloadFileUrlTemplates = {
    # the 5-day interval tars contain data for every 6 hours of the 5-day interval
    'five_daily': {
        # e.g.:
        # * analysis: 'https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820616-19820620.tar'
        # * forecast: 'https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800306-19800310.tar'
        (dt.date(1979, 1, 1), dt.date(2010, 12, 31)): (
            f'{DOWNLOAD_FILE_ROOT_URL}/ds093.0/{{year}}/{{filename}}'
        ),
        # e.g.:
        # * analysis: 'https://rda.ucar.edu/data/ds094.0/2011/pgbhnl.gdas.20110326-20110331.tar'
        # * forecast: 'https://rda.ucar.edu/data/ds094.0/2011/pgbh06.gdas.20110326-20110331.tar'
        (dt.date(2011, 1, 1), dt.date.today()): (
            f'{DOWNLOAD_FILE_ROOT_URL}/ds094.0/{{year}}/{{filename}}'
        ),
    },
    # TODO:
    'monthly': {},
    # 'monthly': {
    #     (dt.date(1979, 1, 1), dt.date(2010, 12, 31)): (
    #         f'{DOWNLOAD_FILE_ROOT_URL}/ds093.2/{{year}}/{{filename}}'
    #     ),
    #     (dt.date(2011, 1, 1), dt.date.today()): (
    #         f'{DOWNLOAD_FILE_ROOT_URL}/ds094.2/{{year}}/{{filename}}'
    #     ),
    # },
}
