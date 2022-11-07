from pathlib import Path

import luigi

from sipn_reanalysis_ingest.constants.paths import DATA_DOWNLOAD_DIR
from sipn_reanalysis_ingest.util.download import download_cfsr_5day_tar


class DownloadInput(luigi.Task):
    """Download a 5-day CFSR tar file."""

    start_5day_window = luigi.DateParameter()
    end_5day_window = luigi.DateParameter()

    def output(self):
        return luigi.LocalTarget(
            DATA_DOWNLOAD_DIR
            / f'{self.start_5day_window:%Y%m%d}-{self.end_5day_window:%Y%m%d}.tar'
        )

    def run(self):
        # TODO: Validate window
        with self.output().temporary_path() as tmpf:
            tmp_fp = Path(tmpf)
            download_cfsr_5day_tar(
                start_date=self.start_5day_window,
                output_fp=tmp_fp,
            )
