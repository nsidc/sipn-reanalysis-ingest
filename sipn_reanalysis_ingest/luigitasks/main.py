# import shutil
# from pathlib import Path

import luigi

from sipn_reanalysis_ingest.constants.date import DEFAULT_PROCESSING_DAY
from sipn_reanalysis_ingest.luigitasks.convert import Grib2ToNc
from sipn_reanalysis_ingest.util.date import (  # cfsr_5day_window_containing_date,
    date_range,
    date_range_windows,
)

# from sipn_reanalysis_ingest.util.log import logger
# from sipn_reanalysis_ingest.util.untar import untar_dir


class ProcessDateWindow(luigi.WrapperTask):
    """Wraps processing needed to create outputs for a given date window.

    Date window must align to the 5-day CFSR "grid".
    """

    window_start = luigi.DateParameter(default=DEFAULT_PROCESSING_DAY)
    window_end = luigi.DateParameter(default=DEFAULT_PROCESSING_DAY)

    # @property
    # def untar_dir(self) -> Path:
    #     cfsr_5day_window = cfsr_5day_window_containing_date(self.window_start_date)
    #     return untar_dir(*cfsr_5day_window)

    def requires(self):
        return [
            Grib2ToNc(date=date)
            for date in date_range(self.window_start, self.window_end)
        ]

    def run(self):
        pass
        # if self.untar_dir.is_dir():
        #     shutil.rmtree(self.untar_dir)
        # else:
        #     logger.warning(
        #         f'Could not find untar directory {self.untar_dir} for cleanup.',
        #     )


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
        date_windows = date_range_windows(start=self.start_date, end=self.end_date)
        for window_start, window_end in date_windows:
            yield ProcessDateWindow(
                window_start=window_start,
                window_end=window_end,
            )
