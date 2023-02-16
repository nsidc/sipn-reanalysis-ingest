import datetime as dt

from sipn_reanalysis_ingest._types import CfsrGranuleProductType
from sipn_reanalysis_ingest.constants.cfsr import CFSR_DATASET_IDS, CFSR_VERSION_BY_DATE
from sipn_reanalysis_ingest.constants.download import DOWNLOAD_FILE_ROOT_URL
from sipn_reanalysis_ingest.util.date import Cfsr5ishDayWindow, YearMonth
from sipn_reanalysis_ingest.util.misc import range_lookup
from sipn_reanalysis_ingest.util.product_type import cfsr_product_type_prefix


def _cfsr_day_tar_baseurl(*, window_start: dt.date) -> str:
    """Calculate a 5-day tar base URL (i.e. URL excluding filename).

    E.g.:
    * analysis v1: 'https://rda.ucar.edu/data/ds093.0/1982'
    * forecast v1: 'https://rda.ucar.edu/data/ds093.0/1980'
    * analysis v2: 'https://rda.ucar.edu/data/ds094.0/2011'
    * forecast v2: 'https://rda.ucar.edu/data/ds094.0/2011'

    ENC - This base url is the same for daily v1/v2 so I changed the name so it 
          can be used for both

    """
    cfsr_version = range_lookup(CFSR_VERSION_BY_DATE, date)
    dataset_id = CFSR_DATASET_IDS[('daily', cfsr_version)]
    baseurl = f'{DOWNLOAD_FILE_ROOT_URL}/{dataset_id}/{date.year}'

    return baseurl

def _cfsr_1day_tar_filename(*, date: dt.date) -> str:
    """Calculate a CFSR 1-day tar filename.
       
    Both analysis and forecast files are in a single tar e.g.
     'cdas1.20110401.pgrbh.tar'
    """
    filename = f'cdas1.{date:%Y%m%d}.pgrbh.tar'
    return filename

def _cfsr_5day_tar_filename(
    *,
    window_start: dt.date,
    window_end: dt.date,
    product_type: CfsrGranuleProductType,
) -> str:
    """Calculate a CFSR 5-day tar filename.

    E.g.:
    * analysis: 'pgbhnl.gdas.19820616-19820620.tar'
    * forecast: 'pgbh06.gdas.19800306-19800310.tar'
    """
    prefix = cfsr_product_type_prefix(product_type)
    filename = f'{prefix}.{window_start:%Y%m%d}-{window_end:%Y%m%d}.tar'
    return filename


def cfsr_1day_tar_url(*, date: dt.date) -> str:
    """Generate a 1-day tar URL for daily v2

    E.g.:
        'https://rda.ucar.edu/data/ds094.0/2011/cdas1.20110402.pgrbh.tar'
    """
    fn = _cfsr_1day_tar_filename(date=date)

    baseurl = _cfsr_day_tar_baseurl(window_start=window_start)
    return f'{baseurl}/{fn}'

def cfsr_5day_tar_url(
    *,
    window_start: dt.date,
    product_type: CfsrGranuleProductType,
) -> str:
    """Generate a 5-day tar URL.

    E.g.:
    * analysis v1:
        'https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820616-19820620.tar'
    * forecast v1:
        'https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800306-19800310.tar'
    * analysis v2:
        'https://rda.ucar.edu/data/ds094.0/2011/pgbhnl.gdas.20110326-20110331.tar'
    * forecast v2:
        'https://rda.ucar.edu/data/ds094.0/2011/pgbh06.gdas.20110326-20110331.tar'
    """
    window_end = Cfsr5ishDayWindow.calculate_window_end_from_start(window_start)
    fn = _cfsr_5day_tar_filename(
        window_start=window_start,
        window_end=window_end,
        product_type=product_type,
    )

    baseurl = _cfsr_daily_tar_baseurl(window_start=window_start)
    return f'{baseurl}/{fn}'


def _cfsr_monthly_tar_baseurl(
    *,
    month: YearMonth,
) -> str:
    """Calculate a CFSR monthly tar baseurl.

    e.g.: 'https://rda.ucar.edu/data/ds094.2/regular'
    """
    dataset_id = CFSR_DATASET_IDS[('monthly', 2)]
    baseurl = f'{DOWNLOAD_FILE_ROOT_URL}/{dataset_id}/regular'
    return baseurl


def _cfsr_monthly_tar_filename(
    *,
    month: YearMonth,
) -> str:
    """Calculate a CFSR monthly tar filename.

    e.g.: 'pgbh.gdas.201101.tar'
    """
    fn = f'pgbh.gdas.{month}.tar'
    return fn


def cfsr_monthly_tar_url(*, month: YearMonth) -> str:
    """Calculate a monthly tar URL.

    NOTE: only v2 product provides monthly data in monthly tars.

    e.g. forecast and analysis data combined:
        'https://rda.ucar.edu/data/ds094.2/regular/pgbh.gdas.201101.tar'
    """
    cfsr_version = range_lookup(
        CFSR_VERSION_BY_DATE,
        dt.date(month.year, month.month, 1),
    )
    if cfsr_version != 2:
        raise RuntimeError(f'{month=} is not valid for CFSRv2')

    baseurl = _cfsr_monthly_tar_baseurl(month=month)
    fn = _cfsr_monthly_tar_filename(month=month)
    return f'{baseurl}/{fn}'


def _cfsr_yearly_tar_baseurl() -> str:
    dataset_id = CFSR_DATASET_IDS[('monthly', 1)]
    baseurl = f'{DOWNLOAD_FILE_ROOT_URL}/{dataset_id}/regular'
    return baseurl


def _cfsr_yearly_tar_filename(
    *,
    year: int,
    product_type: CfsrGranuleProductType,
) -> str:
    prefix = cfsr_product_type_prefix(product_type)
    fn = f'{prefix}.{year}.tar'
    return fn


def cfsr_yearly_tar_url(
    *,
    year: int,
    product_type: CfsrGranuleProductType,
) -> str:
    """Calculate a yearly tar URL.

    NOTE: only v1 product provides monthly data in yearly tars.

    E.g.
    * analysis: 'https://rda.ucar.edu/data/ds093.2/regular/pgbhnl.gdas.1979.tar'
    * forecast: 'https://rda.ucar.edu/data/ds093.2/regular/pgbh06.gdas.1979.tar'
    """
    cfsr_version = range_lookup(
        CFSR_VERSION_BY_DATE,
        dt.date(year, 1, 1),
    )
    if cfsr_version != 1:
        raise RuntimeError(f'{year=} is not valid for CFSRv1')

    baseurl = _cfsr_yearly_tar_baseurl()
    fn = _cfsr_yearly_tar_filename(year=year, product_type=product_type)
    return f'{baseurl}/{fn}'
