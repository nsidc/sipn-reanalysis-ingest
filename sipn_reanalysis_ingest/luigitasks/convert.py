import datetime as dt
from pathlib import Path

import luigi

from sipn_reanalysis_ingest._types import (
    CfsrGranuleProductType,
    TarsRequiredForDailyData,
)
from sipn_reanalysis_ingest.constants.cfsr import (
    CFSR_DAILY_TAR_ON_OR_AFTER,
    CFSR_VERSION_BY_DATE,
)
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
    select_5daily_6hourly_analysis_grib2s,
    select_5daily_6hourly_forecast_grib2s,
    select_daily_6hourly_analysis_grib2s,
    select_daily_6hourly_forecast_grib2s,
    select_edgecase_6hourly_forecast_grib2s,
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
    def tars_required(self) -> TarsRequiredForDailyData:
        if self.date == CFSR_DAILY_TAR_ON_OR_AFTER:
            return TarsRequiredForDailyData.BOTH
        elif self.date < CFSR_DAILY_TAR_ON_OR_AFTER:
            return TarsRequiredForDailyData.FIVE_DAILY
        elif self.date > CFSR_DAILY_TAR_ON_OR_AFTER:
            return TarsRequiredForDailyData.DAILY

        # TODO: How to convince Mypy that the code will never reach this line?
        raise RuntimeError('This should not be reachable')

    def requires(self):
        if self.tars_required == TarsRequiredForDailyData.FIVE_DAILY:
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

        elif self.tars_required == TarsRequiredForDailyData.BOTH:
            forecast_5day_window = Cfsr5ishDayWindow.from_date_in_window(
                self.date - dt.timedelta(days=1)
            )
            req = [
                UntarCfsr5DayFile(
                    window_start=forecast_5day_window.start,
                    window_end=forecast_5day_window.end,
                    product_type=CfsrGranuleProductType.FORECAST,
                ),
                UntarCfsr1DayFile(date=self.date),
            ]
            return req

        elif self.tars_required == TarsRequiredForDailyData.DAILY:
            req = [
                UntarCfsr1DayFile(date=self.date - dt.timedelta(days=1)),
                UntarCfsr1DayFile(date=self.date),
            ]
            return req

    def output(self):
        fn = DATA_DAILY_FILENAME_TEMPLATE.format(date=self.date)
        return luigi.LocalTarget(DATA_FINISHED_DIR / fn)

    def run(self):
        if self.tars_required == TarsRequiredForDailyData.FIVE_DAILY:
            analysis_dir = Path(self.input()[CfsrGranuleProductType.ANALYSIS].path)
            analysis_inputs = select_5daily_6hourly_analysis_grib2s(
                analysis_dir, date=self.date
            )

            forecast_dirs = [
                Path(d.path)
                for d in luigi.task.flatten(
                    self.input()[CfsrGranuleProductType.FORECAST]
                )
            ]
            forecast_inputs = select_5daily_6hourly_forecast_grib2s(
                forecast_dirs,
                date=self.date,
            )

        elif self.tars_required == TarsRequiredForDailyData.BOTH:
            current_date_dir = Path(self.input()[1].path)
            analysis_inputs = select_daily_6hourly_analysis_grib2s(current_date_dir)

            previous_5day_window_forecast_dir = Path(self.input()[0].path)
            forecast_inputs = select_edgecase_6hourly_forecast_grib2s(
                previous_5day_window_forecast_grib2_dir=previous_5day_window_forecast_dir,
                current_date_grib2_dir=current_date_dir,
                previous_date=self.date - dt.timedelta(days=1),
            )

        elif self.tars_required == TarsRequiredForDailyData.DAILY:
            current_date_dir = Path(self.input()[1].path)
            analysis_inputs = select_daily_6hourly_analysis_grib2s(current_date_dir)

            previous_date_dir = Path(self.input()[0].path)
            forecast_inputs = select_daily_6hourly_forecast_grib2s(
                current_date_grib2_dir=current_date_dir,
                previous_date_grib2_dir=previous_date_dir,
            )

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
