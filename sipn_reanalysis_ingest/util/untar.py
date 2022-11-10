import tarfile
from pathlib import Path


def untar_cfsr_5day_tar(tar_path: Path, *, output_dir: Path) -> None:
    with tarfile.open(tar_path) as tar:
        tar.extractall(output_dir)
