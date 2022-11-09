import datetime as dt
from pathlib import Path

import luigi

from sipn_reanalysis_ingest._types import CfsrProductType
from sipn_reanalysis_ingest.constants.paths import DATA_FINISHED_DIR
from sipn_reanalysis_ingest.luigitasks.untar import UntarCfsr5DayFile
from sipn_reanalysis_ingest.util.convert import convert_grib2s_to_nc
from sipn_reanalysis_ingest.util.date import cfsr_5day_window_containing_date
from sipn_reanalysis_ingest.util.log import logger


class Grib2ToNc(luigi.Task):
    """Converts GRIB2 6-hourly input data to daily NetCDF.

    The source data will be filtered for only the variables of interest, subset and
    reprojected for our area of interest.
    """

    date = luigi.DateParameter()

    def requires(self):
        five_day_window = cfsr_5day_window_containing_date(date=self.date)
        # If the first day of analysis window, we also need the forecast files for the
        # previous window!
        if self.date == five_day_window[0]:
            forecast_5day_window = cfsr_5day_window_containing_date(
                date=self.date - dt.timedelta(days=1)
            )
        else:
            forecast_5day_window = five_day_window

        yield UntarCfsr5DayFile(
            start_5day_window=five_day_window[0],
            end_5day_window=five_day_window[1],
            product_type=CfsrProductType.ANALYSIS,
        )
        yield UntarCfsr5DayFile(
            start_5day_window=forecast_5day_window[0],
            end_5day_window=forecast_5day_window[1],
            product_type=CfsrProductType.FORECAST,
        )

    def output(self):
        return luigi.LocalTarget(DATA_FINISHED_DIR / f'{self.date:%Y%m%d}.nc')

    def run(self):
        input_path = Path(self.input().path)
        input_files = list(input_path.glob(f'*.{self.date:%Y%m%d}*.grb2'))

        logger.info(f'Converting input files: {input_files}...')

        with self.output().temporary_path() as tempf:
            convert_grib2s_to_nc(input_files, output_path=Path(tempf))

            for ifile in input_files:
                ifile.unlink()
