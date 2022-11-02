import datetime as dt
from pathlib import Path

from sipn_reanalysis_ingest.util.download import download_cfsr_5day_tar

# TODO: Make a real CLI
if __name__ == '__main__':
    fp = download_cfsr_5day_tar(
        start_date=dt.date(2010, 10, 6),
        output_dir=Path('/tmp'),
    )

    print(f'Output: {fp}')
