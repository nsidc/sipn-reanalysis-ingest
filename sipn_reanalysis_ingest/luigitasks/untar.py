from pathlib import Path

import luigi

from sipn_reanalysis_ingest.luigitasks.download import DownloadInput
from sipn_reanalysis_ingest.util.untar import untar_cfsr_5day_tar, untar_dir


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
            untar_dir(self.start_5day_window, self.end_5day_window),
        )

    def run(self):
        with self.output().temporary_path() as tmpd:
            tmp_dir = Path(tmpd)
            tmp_dir.mkdir()
            untar_cfsr_5day_tar(
                Path(self.input().path),
                output_dir=tmp_dir,
            )

            Path(self.input().path).unlink()
