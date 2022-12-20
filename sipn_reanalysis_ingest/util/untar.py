import tarfile
from pathlib import Path


def untar(tar_path: Path, *, output_dir: Path) -> None:
    with tarfile.open(tar_path) as tar:
        tar.extractall(output_dir)
