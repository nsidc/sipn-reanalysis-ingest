import datetime as dt
import shutil

import luigi

from sipn_reanalysis_ingest.constants.date import (
    DEFAULT_PROCESSING_DAY,
    DEFAULT_PROCESSING_MONTH,
)
from sipn_reanalysis_ingest.constants.paths import DATA_UNTAR_DIR
from sipn_reanalysis_ingest.luigitasks.convert import Grib2ToNcDaily, Grib2ToNcMonthly
from sipn_reanalysis_ingest.util.date import date_range, month_range
from sipn_reanalysis_ingest.util.log import logger


# TODO: Move data from wip dir to final location. Change from WrapperTask to regular
# Task.
class ProcessDateRange(luigi.WrapperTask):
    """Create daily CFSR NetCDFs for each day in provided range."""

    start_date = luigi.DateParameter(default=DEFAULT_PROCESSING_DAY)
    end_date = luigi.DateParameter(default=DEFAULT_PROCESSING_DAY)

    def requires(self):
        return [
            Grib2ToNcDaily(date=date)
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
            Grib2ToNcMonthly(
                # TODO: Use `luigi.date_interval.Month`? Generate type stubs??
                month=dt.date(year_month.year, year_month.month, 1),
            )
            for year_month in month_range(self.start_month, self.end_month)
        ]

    def run(self):
        shutil.rmtree(DATA_UNTAR_DIR)
        logger.info(f'Cleaned up untar data in {DATA_UNTAR_DIR}')
