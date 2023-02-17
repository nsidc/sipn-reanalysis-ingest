import datetime as dt
import itertools
from pathlib import Path

from sipn_reanalysis_ingest._types import CfsrGranuleProductType
from sipn_reanalysis_ingest.constants.cfsr import CFSR_DAILY_TAR_ON_OR_AFTER
from sipn_reanalysis_ingest.errors import CfsrInputDataError
from sipn_reanalysis_ingest.util.date import YearMonth
from sipn_reanalysis_ingest.util.product_type import cfsr_product_type_prefix


def cfsr_5day_input_identifier(
    *,
    window_start: dt.date,
    window_end: dt.date,
    product_type: CfsrGranuleProductType,
) -> str:
    return f'{window_start:%Y%m%d}-{window_end:%Y%m%d}_{product_type.value}'


def cfsr_1day_input_identifier(*, date: dt.date) -> str:
    return f'{date:%Y%m%d}'


def cfsr_monthly_input_identifier(*, month: YearMonth) -> str:
    return f'{month}'


def cfsr_yearly_input_identifier(
    *,
    year: int,
    product_type: CfsrGranuleProductType,
) -> str:
    return f'{year}_{product_type.value}'


# TODO: UNIT TEST!
# TODO: DRY out the check for 4 grib2s. Extract a function!
def select_5daily_6hourly_analysis_grib2s(
    grib2_dir: Path, *, date: dt.date
) -> list[Path]:
    """Filter analysis grib2s in `grib2_dir`, selecting those relevant to `date`.

    This is trivial with analysis files; simply select those files matching date.
    """
    analysis_grib2s = list(grib2_dir.glob(f'*.{date:%Y%m%d}*.grb2'))

    if len(analysis_grib2s) != 4:
        raise CfsrInputDataError(
            f'Expected four forecast files. Found: {analysis_grib2s}'
        )

    return sorted(analysis_grib2s)


def select_daily_6hourly_analysis_grib2s(grib2_dir: Path) -> list[Path]:
    """Filter for analysis grib2s in daily `grib2_dir`.

    Grab all files that match *pgrbhanl*.
    """
    analysis_grib2s = list(grib2_dir.glob('*.pgrbhanl*.grib2'))

    if len(analysis_grib2s) != 4:
        raise CfsrInputDataError(
            f'Expected four analysis files. Found: {analysis_grib2s}'
        )

    return sorted(analysis_grib2s)


def select_5daily_6hourly_forecast_grib2s(
    grib2_dirs: list[Path], *, date: dt.date
) -> list[Path]:
    """Filter forecast grib2s in `grib2_dirs`, selecting those relevant to `date`.

    `grib2_dirs` may contain up to 2 paths.

    This is non-trivial for forecast files; we need to offset the selection back by 6
    hours, because each file contains expected measurements 6 hours in the future from
    the date in the filename.
    """
    all_grib2s = list(
        itertools.chain.from_iterable(list(d.glob('*.grb2')) for d in grib2_dirs)
    )

    forecast_grib2s = _select_5daily_6hourly_forecast_gribs(all_grib2s, date=date)
    return forecast_grib2s


def select_daily_6hourly_forecast_grib2s(
    *,
    current_date_grib2_dir: Path,
    previous_date_grib2_dir: Path,
) -> list[Path]:
    """Filter forecast grib2s in provided dirs.

    Grab files that match *pgrbh06*: from previous day grab 18z, from current day, grab
    00z, 06z, 12z.
    """
    previous_date_grib2s = list(previous_date_grib2_dir.glob('*.t18z.pgrbh06.grib2'))
    current_date_grib2s = list(
        current_date_grib2_dir.glob(
            '*.t[01][026]z.pgrbh06.grib2',
        )
    )

    forecast_grib2s = previous_date_grib2s + current_date_grib2s
    if len(forecast_grib2s) != 4:
        raise CfsrInputDataError(
            f'Expected four forecast files. Found: {forecast_grib2s}'
        )

    return forecast_grib2s


def select_edgecase_6hourly_forecast_grib2s(
    *,
    previous_5day_window_forecast_grib2_dir: Path,
    current_date_grib2_dir: Path,
    previous_date: dt.date,
) -> list[Path]:
    previous_date_grib2s = list(previous_5day_window_forecast_grib2_dir.glob(
        f'*{previous_date:%Y%m%d}18.grb2',
    ))

    current_date_grib2s = list(current_date_grib2_dir.glob('*.t[01][026]z.pgrbh06.grib2'))

    forecast_grib2s = previous_date_grib2s + sorted(current_date_grib2s)
    if len(forecast_grib2s) != 4:
        raise CfsrInputDataError(
            f'Expected four forecast files. Found: {forecast_grib2s}'
        )

    return forecast_grib2s


def _select_5daily_6hourly_forecast_gribs(
    grib2_files: list[Path], *, date: dt.date
) -> list[Path]:
    valid_suffixes = _expected_5daily_6hourly_forecast_suffixes_for_date(date)
    valid_grib2s = [
        p for p in grib2_files if any(str(p).endswith(v) for v in valid_suffixes)
    ]

    if len(valid_grib2s) != 4:
        raise CfsrInputDataError(f'Expected four forecast files. Found: {valid_grib2s}')

    return sorted(valid_grib2s)


def _expected_5daily_6hourly_forecast_suffixes_for_date(date: dt.date) -> list[str]:
    if date >= CFSR_DAILY_TAR_ON_OR_AFTER:
        raise RuntimeError(f'Expected date before {date} for 5-daily data.')

    date_minus_1 = date - dt.timedelta(days=1)
    valid_datetimes = [
        f'{date_minus_1:%Y%m%d}18',
        *[f'{date:%Y%m%d}{hour}' for hour in ['00', '06', '12']],
    ]

    valid_suffixes = [f'{datetime}.grb2' for datetime in valid_datetimes]

    return valid_suffixes


def select_monthly_grib2(
    grib2_dir: Path,
    *,
    month: YearMonth,
    product_type: CfsrGranuleProductType,
) -> Path:
    """Select CFSR monthly granule matching `month` and `product_type`."""
    prefix = cfsr_product_type_prefix(product_type)
    grib2s: list[Path] = []
    for ext in ['grb2', 'grib2']:
        grib2s.extend(grib2_dir.glob(f'{prefix}.{month}.{ext}'))

    if len(grib2s) != 1:
        raise CfsrInputDataError(
            f'Expected exactly 1 {product_type.value} file. Found: {grib2s}'
        )

    return grib2s[0]
