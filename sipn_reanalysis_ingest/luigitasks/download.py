from pathlib import Path

import luigi

from sipn_reanalysis_ingest._types import CfsrProductType
from sipn_reanalysis_ingest.util.download import download_cfsr_5day_tar, download_dir


class DownloadInput(luigi.Task):
    """Download a 5-day CFSR tar file."""

    start_5day_window = luigi.DateParameter()
    end_5day_window = luigi.DateParameter()
    product_type = luigi.EnumParameter(enum=CfsrProductType)

    def output(self):
        return luigi.LocalTarget(
            download_dir(
                window_start=self.start_5day_window,
                window_end=self.end_5day_window,
                product_type=self.product_type,
            ),
        )

    def run(self):
        # TODO: Validate window
        with self.output().temporary_path() as tmpf:
            tmp_fp = Path(tmpf)
            download_cfsr_5day_tar(
                start_date=self.start_5day_window,
                output_fp=tmp_fp,
            )
