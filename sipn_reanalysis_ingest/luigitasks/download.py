from pathlib import Path

import luigi

from sipn_reanalysis_ingest.util.download import download_cfsr_5day_tar
from sipn_reanalysis_ingest.util.untar import untar_cfsr_5day_tar
from sipn_reanalysis_ingest.constants.paths import DATA_DOWNLOAD_DIR, DATA_UNTAR_DIR


class UntarInput(luigi.Task):
    """Untar a 5-day CFSR tar file."""

    start_5day_window = luigi.DateParameter()
    end_5day_window = luigi.DateParameter()

    def requires(self):
        return DownloadInput(
            start_5day_window=self.start_5day_window,
            end_5day_window=self.end_5day_window,
        )

    def output(self):
        return luigi.LocalTarget(
            DATA_UNTAR_DIR
            / f'{self.start_5day_window:%Y%m%d}-{self.end_5day_window:%Y%m%d}'
        )

    def run(self):
        with self.output().temporary_path() as tmpd:
            tmp_dir = Path(tmpd)
            tmp_dir.mkdir()
            untar_cfsr_5day_tar(
                Path(self.input().path),
                output_dir=tmp_dir, 
            )




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
