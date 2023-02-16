from pathlib import Path

import luigi

from sipn_reanalysis_ingest._types import CfsrGranuleProductType
from sipn_reanalysis_ingest.util.date import YearMonth
from sipn_reanalysis_ingest.util.download import (
    download_cfsr_5day_tar,
    download_cfsr_1day_tar,
    download_cfsr_monthly_tar,
    download_cfsr_yearly_tar,
)
from sipn_reanalysis_ingest.util.paths import (
    download_5day_tar_path,
    download_1day_tar_path,
    download_monthly_tar_path,
    download_yearly_tar_path,
)


class DownloadCfsr5DayTar(luigi.Task):
    """Download 6-hourly CFSR data, which are delivered in 5-daily tar files."""

    window_start = luigi.DateParameter()
    window_end = luigi.DateParameter()
    product_type = luigi.EnumParameter(enum=CfsrGranuleProductType)

    def output(self):
        return luigi.LocalTarget(
            download_5day_tar_path(
                window_start=self.window_start,
                window_end=self.window_end,
                product_type=self.product_type,
            ),
        )

    def run(self):
        # TODO: Validate window
        with self.output().temporary_path() as tmpf:
            tmp_fp = Path(tmpf)
            tmp_fp.parent.mkdir(parents=True, exist_ok=True)
            download_cfsr_5day_tar(
                window_start=self.window_start,
                product_type=self.product_type,
                output_fp=tmp_fp,
            )


class DownloadCfsr1DayTar(luigi.Task):
    """Download V2 after March 31, 2011 (as of 1/25/23)
    6-hourly CFSR data which are daily tar files."""

    date = luigi.DateParameter()

    def output(self):
        return luigi.LocalTarget(
            download_1day_tar_path(date=self.date),
        )

    def run(self):
        # TODO: Validate window
        with self.output().temporary_path() as tmpf:
            tmp_fp = Path(tmpf)
            tmp_fp.parent.mkdir(parents=True, exist_ok=True)
            download_cfsr_1day_tar(
                date=self.date,
                output_fp=tmp_fp,
            )


class DownloadCfsrV1MonthlyTar(luigi.Task):
    """Download monthly CFSRv1 data, which are delivered in yearly tar files."""

    year = luigi.IntParameter()
    product_type = luigi.EnumParameter(enum=CfsrGranuleProductType)

    def output(self):
        return luigi.LocalTarget(
            download_yearly_tar_path(
                year=self.year,
                product_type=self.product_type,
            ),
        )

    def run(self):
        with self.output().temporary_path() as tmpf:
            tmp_fp = Path(tmpf)
            tmp_fp.parent.mkdir(parents=True, exist_ok=True)
            download_cfsr_yearly_tar(
                year=self.year,
                product_type=self.product_type,
                output_fp=tmp_fp,
            )


class DownloadCfsrV2MonthlyTar(luigi.Task):
    """Download a monthly CFSRv2 tar file.

    v2 monthly tar files include all "product types", including some we don't want.
    """

    month = luigi.MonthParameter()

    @property
    def yearmonth(self) -> YearMonth:
        return YearMonth(year=self.month.year, month=self.month.month)

    def output(self):
        return luigi.LocalTarget(download_monthly_tar_path(month=self.yearmonth))

    def run(self):
        with self.output().temporary_path() as tmpf:
            tmp_fp = Path(tmpf)
            tmp_fp.parent.mkdir(parents=True, exist_ok=True)
            download_cfsr_monthly_tar(
                month=self.yearmonth,
                output_fp=tmp_fp,
            )
