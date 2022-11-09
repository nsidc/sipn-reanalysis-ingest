import datetime as dt
from pathlib import Path

import luigi

from sipn_reanalysis_ingest._types import CfsrProductType
from sipn_reanalysis_ingest.constants.paths import DATA_FINISHED_DIR
from sipn_reanalysis_ingest.luigitasks.untar import UntarCfsr5DayFile
from sipn_reanalysis_ingest.util.cfsr import (
    select_analysis_grib2s,
    select_forecast_grib2s,
)
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

        req = {
            CfsrProductType.ANALYSIS: UntarCfsr5DayFile(
                window_start=five_day_window[0],
                window_end=five_day_window[1],
                product_type=CfsrProductType.ANALYSIS,
            ),
            CfsrProductType.FORECAST: UntarCfsr5DayFile(
                window_start=five_day_window[0],
                window_end=five_day_window[1],
                product_type=CfsrProductType.FORECAST,
            ),
        }

        # If the first day of analysis window, we also need the forecast files for the
        # previous window!
        if self.date == five_day_window[0]:
            forecast_5day_window = cfsr_5day_window_containing_date(
                date=self.date - dt.timedelta(days=1)
            )
            req[CfsrProductType.FORECAST] = [
                req[CfsrProductType.FORECAST],
                UntarCfsr5DayFile(
                    window_start=forecast_5day_window[0],
                    window_end=forecast_5day_window[1],
                    product_type=CfsrProductType.FORECAST,
                ),
            ]

        return req

    def output(self):
        return luigi.LocalTarget(DATA_FINISHED_DIR / f'{self.date:%Y%m%d}.nc')

    def run(self):
        # FIXME: input() is a list of targets, not a single target
        analysis_dir = Path(self.input()[CfsrProductType.ANALYSIS].path)
        analysis_inputs = select_analysis_grib2s(analysis_dir, date=self.date)

        forecast_dirs = [
            Path(d.path) for d in
            luigi.task.flatten(self.input()[CfsrProductType.FORECAST])
        ]
        forecast_inputs = select_forecast_grib2s(forecast_dirs, date=self.date)

        logger.info(f'Producing output NetCDF for date {self.date}...')
        logger.debug(f'>> Analysis inputs: {analysis_inputs}')
        logger.debug(f'>> Forecast inputs: {forecast_inputs}')

        with self.output().temporary_path() as tempf:
            convert_grib2s_to_nc(
                analysis_inputs=analysis_inputs,
                forecast_inputs=forecast_inputs,
                output_path=Path(tempf),
            )

            for ifile in [*analysis_inputs, *forecast_inputs]:
                ifile.unlink()
