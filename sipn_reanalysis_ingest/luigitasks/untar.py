from pathlib import Path

import luigi

from sipn_reanalysis_ingest._types import CfsrGranuleProductType
from sipn_reanalysis_ingest.luigitasks.download import (  # DownloadCfsrV1MonthlyTar,
    DownloadCfsr5DayTar,
    DownloadCfsrV1MonthlyTar,
    DownloadCfsrV2MonthlyTar,
)
from sipn_reanalysis_ingest.util.date import YearMonth
from sipn_reanalysis_ingest.util.paths import (
    untar_5day_tar_dir,
    untar_monthly_tar_dir,
    untar_yearly_tar_dir,
)
from sipn_reanalysis_ingest.util.untar import untar

# TODO: GranuleTask mixin or luigi.Task subclass that modifies __init__ to calculate
# `granule` instance attribute? Child class has to populate a `GranuleType` attibute to
# make it work?


class UntarFileTask(luigi.Task):
    """Share behavior between all untar classes."""

    def run(self):
        with self.output().temporary_path() as tmpd:
            tmp_dir = Path(tmpd)
            tmp_dir.mkdir()
            untar(Path(self.input().path), output_dir=tmp_dir)

            Path(self.input().path).unlink()


class UntarCfsr5DayFile(UntarFileTask):
    """Untar a 5-day CFSR tar file."""

    window_start = luigi.DateParameter()
    window_end = luigi.DateParameter()
    product_type = luigi.EnumParameter(enum=CfsrGranuleProductType)

    def requires(self):
        return DownloadCfsr5DayTar(
            window_start=self.window_start,
            window_end=self.window_end,
            product_type=self.product_type,
        )

    def output(self):
        return luigi.LocalTarget(
            untar_5day_tar_dir(
                window_start=self.window_start,
                window_end=self.window_end,
                product_type=self.product_type,
            )
        )


class UntarCfsrDailyFile(UntarFileTask):
    """Untar a daily CFSR tar file."""

    date = luigi.DateParameter()

    def requires(self):
        ...

    def output(self):
        ...


class UntarCfsrV1MonthlyFile(UntarFileTask):
    """Untar monthly CFSRv1 data, which is packaged in a yearly tar file."""

    year = luigi.IntParameter()
    product_type = luigi.EnumParameter(enum=CfsrGranuleProductType)

    def requires(self):
        return DownloadCfsrV1MonthlyTar(
            year=self.year,
            product_type=self.product_type,
        )

    def output(self):
        return luigi.LocalTarget(
            untar_yearly_tar_dir(
                year=self.year,
                product_type=self.product_type,
            )
        )


class UntarCfsrV2MonthlyFile(UntarFileTask):
    """Untar a monthly CFSRv2 tar file.

    All product types, including those we don't want, are inluded in v2 monthly tars.
    """

    month = luigi.MonthParameter()

    def requires(self):
        return DownloadCfsrV2MonthlyTar(month=self.month)

    def output(self):
        return luigi.LocalTarget(
            untar_monthly_tar_dir(
                month=YearMonth(self.month.year, self.month.month),
            )
        )
