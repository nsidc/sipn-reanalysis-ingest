from pathlib import Path

import luigi

from sipn_reanalysis_ingest._types import CfsrProductType
from sipn_reanalysis_ingest.util.download import download_cfsr_5day_tar
from sipn_reanalysis_ingest.util.paths import download_dir


class DownloadInput(luigi.Task):
    """Download a 5-day CFSR tar file."""

    window_start = luigi.DateParameter()
    window_end = luigi.DateParameter()
    product_type = luigi.EnumParameter(enum=CfsrProductType)

    def output(self):
        return luigi.LocalTarget(
            download_dir(
                window_start=self.window_start,
                window_end=self.window_end,
                product_type=self.product_type,
            ),
        )

    def run(self):
        # TODO: Validate window
        with self.output().temporary_path() as tmpf:
            tmp_fp = Path(tmpf)
            download_cfsr_5day_tar(
                window_start=self.window_start,
                product_type=self.product_type,
                output_fp=tmp_fp,
            )
