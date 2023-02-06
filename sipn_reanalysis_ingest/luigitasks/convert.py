import datetime as dt
from pathlib import Path

import luigi

from sipn_reanalysis_ingest._types import CfsrGranuleProductType
from sipn_reanalysis_ingest.constants.cfsr import CFSR_VERSION_BY_DATE
from sipn_reanalysis_ingest.constants.paths import (
    DATA_DAILY_FILENAME_TEMPLATE,
    DATA_FINISHED_DIR,
    DATA_MONTHLY_FILENAME_TEMPLATE,
)
from sipn_reanalysis_ingest.luigitasks.untar import (
    UntarCfsr1DayFile,
    UntarCfsr5DayFile,
    UntarCfsrV1MonthlyFile,
    UntarCfsrV2MonthlyFile,
)
from sipn_reanalysis_ingest.util.cfsr import (
    select_v1_6hourly_analysis_grib2s,
    select_v1_6hourly_forecast_grib2s,
    select_v2_6hourly_analysis_grib2s,
    select_v2_6hourly_forecast_grib2s,
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

    @property
    def uses_5day_tars(self):
        if self.date < CFSR_DAILY_TAR_BEFORE:
            return True
        return False

    def requires(self):
        if self.uses_5day_tars:
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
        else:
            # FIXME: Handle the case of the 1st day of daily data. We need to grab a
            # 5-day and 1-day file.
            # Don't need to worry about the 5-day window after arbritrary cutoff date
            req = {
                CfsrGranuleProductType.ANALYSIS: UntarCfsr1DayFile(
                    window_start=self.date,
                    window_end=self.date,
                    product_type=CfsrGranuleProductType.ANALYSIS,
                ),
                CfsrGranuleProductType.FORECAST: UntarCfsr1DayFile(
                    window_start=self.date - dt.timedelta(days=1),
                    window_end=self.date,
                    product_type=CfsrGranuleProductType.FORECAST,
                )
            }

            return {
                'today': UntarCfsr1DayFile(date=today_date),
                # We need the 18h forecast files, so grab yesterday's file too
                'yesterday': UntarCfsr1DayFile(date=yesterday_date),
            }

    def output(self):
        fn = DATA_DAILY_FILENAME_TEMPLATE.format(date=self.date)
        return luigi.LocalTarget(DATA_FINISHED_DIR / fn)

    def run(self):
        if self.uses_5day_tars:
           analysis_dir = Path(self.input()[CfsrGranuleProductType.ANALYSIS].path)
           analysis_inputs = select_v1_6hourly_analysis_grib2s(analysis_dir, date=self.date)

           forecast_dirs = [
            Path(d.path)
            for d in luigi.task.flatten(self.input()[CfsrGranuleProductType.FORECAST])
           ]
           forecast_inputs = select_v1_6hourly_forecast_grib2s(forecast_dirs, date=self.date)

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
        else:
           analysis_dir = Path(self.input()[CfsrGranuleProductType.ANALYSIS].path)
           analysis_inputs = select_v2_6hourly_analysis_grib2s(analysis_dir, date=self.date)

           forecast_dirs = [
            Path(d.path)
            for d in luigi.task.flatten(self.input()[CfsrGranuleProductType.FORECAST])
           ]
           forecast_inputs = select_v2_6hourly_forecast_grib2s(forecast_dirs, date=self.date)

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
            # v1 data is in yearly tar files that contain _either_ forecast _or_
            # analysis data.
            return {
                CfsrGranuleProductType.ANALYSIS: UntarCfsrV1MonthlyFile(
                    year=self.month.year,
                    product_type=CfsrGranuleProductType.ANALYSIS,
                ),
                CfsrGranuleProductType.FORECAST: UntarCfsrV1MonthlyFile(
                    year=self.month.year,
                    product_type=CfsrGranuleProductType.FORECAST,
                ),
            }
        elif self.cfsr_version == 2:
            # v2 files are monthly and contain both analysis and forecast data in one.
            return UntarCfsrV2MonthlyFile(month=self.month)

    def output(self):
        fn = DATA_MONTHLY_FILENAME_TEMPLATE.format(yearmonth=self.yearmonth)
        return luigi.LocalTarget(DATA_FINISHED_DIR / fn)

    def run(self):
        if self.cfsr_version == 1:
            # v1 data is in yearly tar files that contain _either_ forecast _or_
            # analysis data.
            analysis_files_dir = Path(
                self.input()[CfsrGranuleProductType.ANALYSIS].path,
            )
            forecast_files_dir = Path(
                self.input()[CfsrGranuleProductType.FORECAST].path,
            )
        elif self.cfsr_version == 2:
            # v2 files are monthly and contain both analysis and forecast data in one.
            analysis_files_dir = Path(self.input().path)
            forecast_files_dir = Path(self.input().path)

        analysis_input = select_monthly_grib2(
            analysis_files_dir,
            month=self.yearmonth,
            product_type=CfsrGranuleProductType.ANALYSIS,
        )
        forecast_input = select_monthly_grib2(
            forecast_files_dir,
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
