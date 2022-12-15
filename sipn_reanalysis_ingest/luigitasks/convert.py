import datetime as dt
from pathlib import Path

import luigi

from sipn_reanalysis_ingest._types import CfsrGranuleProductType
from sipn_reanalysis_ingest.constants.cfsr import CFSR_VERSION_BY_DATE
from sipn_reanalysis_ingest.constants.paths import DATA_FINISHED_DIR
from sipn_reanalysis_ingest.luigitasks.untar import (
    UntarCfsr5DayFile,
    UntarCfsrV2MonthlyFile,
)
from sipn_reanalysis_ingest.util.cfsr import (
    select_6hourly_analysis_grib2s,
    select_6hourly_forecast_grib2s,
    select_monthly_grib2,
)
from sipn_reanalysis_ingest.util.convert import (
    convert_6hourly_grib2s_to_nc,
    convert_monthly_grib2s_to_nc,
)
from sipn_reanalysis_ingest.util.date import Cfsr5ishDayWindow, YearMonth
from sipn_reanalysis_ingest.util.log import logger
from sipn_reanalysis_ingest.util.misc import range_lookup


class Grib2ToNcDaily(luigi.Task):
    """Converts GRIB2 6-hourly input data to daily NetCDF.

    The source data will be filtered for only the variables of interest, subset and
    reprojected for our area of interest.
    """

    date = luigi.DateParameter()

    def requires(self):
        five_day_window = Cfsr5ishDayWindow.from_date_in_window(self.date)

        req = {
            CfsrGranuleProductType.ANALYSIS: UntarCfsr5DayFile(
                window_start=five_day_window.start,
                window_end=five_day_window.end,
                product_type=CfsrGranuleProductType.ANALYSIS,
            ),
            CfsrGranuleProductType.FORECAST: UntarCfsr5DayFile(
                window_start=five_day_window.start,
                window_end=five_day_window.end,
                product_type=CfsrGranuleProductType.FORECAST,
            ),
        }

        # If the first day of analysis window, we also need the forecast files for the
        # previous window!
        if self.date == five_day_window.start:
            forecast_5day_window = Cfsr5ishDayWindow.from_date_in_window(
                self.date - dt.timedelta(days=1)
            )
            req[CfsrGranuleProductType.FORECAST] = [
                req[CfsrGranuleProductType.FORECAST],
                UntarCfsr5DayFile(
                    window_start=forecast_5day_window.start,
                    window_end=forecast_5day_window.end,
                    product_type=CfsrGranuleProductType.FORECAST,
                ),
            ]

        return req

    def output(self):
        return luigi.LocalTarget(DATA_FINISHED_DIR / f'{self.date:%Y%m%d}.nc')

    def run(self):
        analysis_dir = Path(self.input()[CfsrGranuleProductType.ANALYSIS].path)
        analysis_inputs = select_6hourly_analysis_grib2s(analysis_dir, date=self.date)

        forecast_dirs = [
            Path(d.path)
            for d in luigi.task.flatten(self.input()[CfsrGranuleProductType.FORECAST])
        ]
        forecast_inputs = select_6hourly_forecast_grib2s(forecast_dirs, date=self.date)

        logger.info(f'Producing daily NetCDF for date {self.date}...')
        logger.debug(f'>> Analysis inputs: {analysis_inputs}')
        logger.debug(f'>> Forecast inputs: {forecast_inputs}')

        with self.output().temporary_path() as tempf:
            convert_6hourly_grib2s_to_nc(
                analysis_inputs=analysis_inputs,
                forecast_inputs=forecast_inputs,
                output_path=Path(tempf),
            )

            for ifile in [*analysis_inputs, *forecast_inputs]:
                ifile.unlink()


class Grib2ToNcMonthly(luigi.Task):
    """Converts GRIB2 monthly input data to NetCDF.

    The source data will be filtered for only the variables of interest, subset and
    reprojected for our area of interest.
    """

    month = luigi.MonthParameter()

    @property
    def yearmonth(self):
        return YearMonth(year=self.month.year, month=self.month.month)

    @property
    def cfsr_version(self):
        return range_lookup(CFSR_VERSION_BY_DATE, self.month)

    def requires(self):
        # TODO: Make return values more consistent
        if self.cfsr_version == 1:
            # TODO: v1 data is in yearly tar files.
            raise NotImplementedError('v1 monthly data not implemented')
            # return {
            #     CfsrGranuleProductType.ANALYSIS: UntarCfsrV1MonthlyFile(
            #         month=self.month,
            #         product_type=CfsrGranuleProductType.ANALYSIS,
            #     ),
            #     CfsrGranuleProductType.FORECAST: UntarCfsrV1MonthlyFile(
            #         month=self.month,
            #         product_type=CfsrGranuleProductType.FORECAST,
            #     ),
            # }
        elif self.cfsr_version == 2:
            # v2 files are monthly and contain both analysis and forecast data in one.
            return UntarCfsrV2MonthlyFile(month=self.month)

    def output(self):
        fn = f'{self.yearmonth}.nc'
        return luigi.LocalTarget(DATA_FINISHED_DIR / fn)

    def run(self):
        if self.cfsr_version == 1:
            raise NotImplementedError('v1 no yet')
        elif self.cfsr_version == 2:
            input_files_dir = Path(self.input().path)
            analysis_input = select_monthly_grib2(
                input_files_dir,
                month=self.yearmonth,
                product_type=CfsrGranuleProductType.ANALYSIS,
            )
            forecast_input = select_monthly_grib2(
                input_files_dir,
                month=self.yearmonth,
                product_type=CfsrGranuleProductType.FORECAST,
            )

        logger.info(f'Producing monthly NetCDF for month {self.yearmonth}...')
        logger.debug(f'>> Analysis input: {analysis_input}')
        logger.debug(f'>> Forecast input: {forecast_input}')

        with self.output().temporary_path() as tempf:
            convert_monthly_grib2s_to_nc(
                analysis_input=analysis_input,
                forecast_input=forecast_input,
                output_path=Path(tempf),
            )

            for ifile in [analysis_input, forecast_input]:
                ifile.unlink()
