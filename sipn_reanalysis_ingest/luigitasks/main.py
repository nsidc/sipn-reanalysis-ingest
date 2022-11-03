import luigi

from sipn_reanalysis_ingest.constants.date import DEFAULT_PROCESSING_DAY
from sipn_reanalysis_ingest.luigitasks.process import ProcessDate
from sipn_reanalysis_ingest.util.date import date_range


# TODO: Should this be a wrapper task?
class ProcessDateRange(luigi.Task):
    """Create daily CFSR NetCDFs for each day in provided range."""

    start_date = luigi.DateParameter(default=DEFAULT_PROCESSING_DAY)
    end_date = luigi.DateParameter(default=DEFAULT_PROCESSING_DAY)

    def requires(self):
        for date in date_range(start=self.start_date, end=self.end_date):
            yield ProcessDate(date=date)

    def output(self):
        ...

    def run(self):
        print('Processing TODO!')
        ...
