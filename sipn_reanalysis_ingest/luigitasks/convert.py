from pathlib import Path

import luigi

from sipn_reanalysis_ingest.constants.paths import DATA_FINISHED_DIR
from sipn_reanalysis_ingest.luigitasks.untar import UntarInput
from sipn_reanalysis_ingest.util.convert import convert_grib2s_to_nc
from sipn_reanalysis_ingest.util.date import cfsr_5day_window_containing_date
from sipn_reanalysis_ingest.util.log import logger 


class Grib2ToNc(luigi.Task):
    """Converts GRIB2 6-hourly input data to daily NetCDF.

    The source data will be filtered for only the variables we care about, subset to
    only the region we care about, and reprojected for our area of interest.
    """

    date = luigi.DateParameter()

    def requires(self):
        five_day_window = cfsr_5day_window_containing_date(date=self.date)
        return UntarInput(
            start_5day_window=five_day_window[0],
            end_5day_window=five_day_window[1],
        )

    def output(self):
        return luigi.LocalTarget(DATA_FINISHED_DIR / f'{self.date}.nc')

    def run(self):
        input_path = Path(self.input().path)
        input_files = list(input_path.glob(f'*.{self.date:%Y%m%d}*.grb2'))

        with self.output().temporary_path() as tempf:
            convert_grib2s_to_nc(input_files, output_path=Path(tempf))

            for ifile in input_files:
                ifile.unlink()
