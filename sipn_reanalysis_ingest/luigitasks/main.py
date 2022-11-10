import shutil

import luigi

from sipn_reanalysis_ingest.constants.date import DEFAULT_PROCESSING_DAY
from sipn_reanalysis_ingest.constants.paths import DATA_UNTAR_DIR
from sipn_reanalysis_ingest.luigitasks.convert import Grib2ToNc
from sipn_reanalysis_ingest.util.date import date_range
from sipn_reanalysis_ingest.util.log import logger


# TODO: Move data from wip dir to final location. Change from WrapperTask to regular
# Task.
class ProcessDateRange(luigi.WrapperTask):
    """Create daily CFSR NetCDFs for each day in provided range.

    This is done via ProcessDateWindow tasks in order to manage cleanup of input files
    which come as archives of 5 days of data.
    """

    start_date = luigi.DateParameter(default=DEFAULT_PROCESSING_DAY)
    end_date = luigi.DateParameter(default=DEFAULT_PROCESSING_DAY)

    def requires(self):
        return [
            Grib2ToNc(date=date) for date in date_range(self.start_date, self.end_date)
        ]

    def run(self):
        shutil.rmtree(DATA_UNTAR_DIR)
        logger.info(f'Cleaned up untar data in {untar_dir}')
