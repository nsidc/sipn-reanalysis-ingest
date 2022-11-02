import datetime as dt

import click

from sipn_reanalysis_ingest.util.cli import DateParameter


@click.group()
def cli():
    pass


@cli.command(
    short_help='Test run of daily file ingest pipeline',
)
@click.option(
    '-w',
    '--workers',
    help='Number of Luigi workers to use. 1 worker recommended for development',
    type=int,
    default=2,
    show_default=True,
)
@click.option(
    '-s',
    '--start-date',
    help='Start date (YYYY-MM-DD)',
    type=DateParameter(),
)
@click.option(
    '-e',
    '--end-date',
    help='End date (YYYY-MM-DD)',
    type=DateParameter(),
)
def process(workers, start_date, end_date):
    """Create NetCDFs with only data we care about from CFSR source data.

    The source data (GRIB2) will be filtered for only the variables we care about,
    subset to only the region we care about, and reprojected for our area of interest.
    """
    # NOTE: Imports are inside the function body to avoid the import being executed
    # during sphinx-click's analysis of this module.
    import luigi


    print('cli')
    # luigi.build(
    #     [
    #         MakeNetCdf(date=date)
    #         for date in range(start_date, end_date)
    #     ],
    #     workers=workers,
    # )


if __name__ == '__main__':
    cli()
