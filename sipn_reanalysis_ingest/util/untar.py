import tarfile
from pathlib import Path


def untar(tar_path: Path, *, output_dir: Path) -> None:
    with tarfile.open(tar_path) as tar:
        tar.extractall(output_dir)


def untar_daily_tar(tar_path: Path, *, output_dir: Path) -> None:
    """Extract only analysis and 6-hour forecast files from a daily tar.

    Daily tars also contain unwanted 1-hour through 9-hour forecast files.
    """
    with tarfile.open(tar_path) as tar:
        fns = [
            fn.name
            for fn in tar.getmembers()
            if any(substr in fn.name for substr in ('pgrbhanl', 'pgrbh06'))
        ]
        for fn in fns:
            tar.extract(fn, path=output_dir)
