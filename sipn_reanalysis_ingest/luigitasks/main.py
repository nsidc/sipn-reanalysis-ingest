import datetime as dt
import shutil

import luigi

from sipn_reanalysis_ingest.constants.cfsr import CFSR_DAILY_TAR_ON_OR_AFTER
from sipn_reanalysis_ingest.constants.date import (
    DEFAULT_PROCESSING_DAY,
    DEFAULT_PROCESSING_MONTH,
)
from sipn_reanalysis_ingest.constants.paths import DATA_UNTAR_DIR
from sipn_reanalysis_ingest.luigitasks.convert import (
    Grib2In5DailyTarToDailyNc,
    Grib2InDailyAnd5DailyTarsToDailyNc,
    Grib2InDailyTarToDailyNc,
    Grib2ToMonthlyNc,
)
from sipn_reanalysis_ingest.util.date import date_range, month_range
from sipn_reanalysis_ingest.util.log import logger


def make_daily_processing_requirement(
    *,
    date: dt.date,
) -> (
    Grib2InDailyAnd5DailyTarsToDailyNc
    | Grib2In5DailyTarToDailyNc
    | Grib2InDailyTarToDailyNc
):
    if date == CFSR_DAILY_TAR_ON_OR_AFTER:
        return Grib2InDailyAnd5DailyTarsToDailyNc(date=date)
    elif date < CFSR_DAILY_TAR_ON_OR_AFTER:
        return Grib2In5DailyTarToDailyNc(date=date)
    elif date > CFSR_DAILY_TAR_ON_OR_AFTER:
        return Grib2InDailyTarToDailyNc(date=date)

    # TODO: How to convince Mypy that the code will never reach this line?
    raise RuntimeError('This should not be reachable')


# TODO: Move data from wip dir to final location. Change from WrapperTask to regular
# Task.
class ProcessDateRange(luigi.WrapperTask):
    """Create daily CFSR NetCDFs for each day in provided range."""

    start_date = luigi.DateParameter(default=DEFAULT_PROCESSING_DAY)
    end_date = luigi.DateParameter(default=DEFAULT_PROCESSING_DAY)

    def requires(self):
        return [
            make_daily_processing_requirement(date=date)
            for date in date_range(self.start_date, self.end_date)
        ]

    def run(self):
        shutil.rmtree(DATA_UNTAR_DIR)
        logger.info(f'Cleaned up untar data in {DATA_UNTAR_DIR}')


class ProcessMonthRange(luigi.WrapperTask):
    """Create monthly CFSR NetCDFs for each month in provided range."""

    start_month = luigi.MonthParameter(default=DEFAULT_PROCESSING_MONTH)
    end_month = luigi.MonthParameter(default=DEFAULT_PROCESSING_MONTH)

    def requires(self):
        return [
            Grib2ToMonthlyNc(
                # TODO: Use `luigi.date_interval.Month`? Generate type stubs??
                month=dt.date(year_month.year, year_month.month, 1),
            )
            for year_month in month_range(self.start_month, self.end_month)
        ]

    def run(self):
        shutil.rmtree(DATA_UNTAR_DIR)
        logger.info(f'Cleaned up untar data in {DATA_UNTAR_DIR}')
