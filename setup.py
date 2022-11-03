from setuptools import find_packages, setup

setup(
    name="sipn-reanalysis-ingest",
    version="0.1.0",
    description="CLI for SIPN Reanalysis data ingest processing",
    url="git@github.com:nsidc/sipn-reanalysis-ingest.git",
    author="National Snow and Ice Data Center",
    author_email="nsidc@nsidc.org",
    packages=find_packages(),
    entry_points={
        "console_scripts": ["sipn-reanalysis-ingest = sipn_reanalysis_ingest.cli:cli"]
    },
    include_package_data=True,
)
