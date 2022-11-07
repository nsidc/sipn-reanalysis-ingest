import luigi

from sipn_reanalysis_ingest.constants.date import DEFAULT_PROCESSING_DAY
from sipn_reanalysis_ingest.luigitasks.convert import Grib2ToNc
from sipn_reanalysis_ingest.util.date import date_range


class ProcessDate(luigi.WrapperTask):
    """Wraps processing needed to create an output for a given date."""

    date = luigi.DateParameter(default=DEFAULT_PROCESSING_DAY)

    def requires(self):
        return Grib2ToNc(date=self.date)


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
        print(
            'Finalization processing TODO!'
            ' If none needed, convert this to WrapperTask!'
        )
        ...
