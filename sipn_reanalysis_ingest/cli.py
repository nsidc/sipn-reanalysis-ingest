import datetime as dt

import click

from sipn_reanalysis_ingest.util.cli import DateParameter, MonthParameter
from sipn_reanalysis_ingest.util.log import logger


@click.group()
@click.option(
    '-w',
    '--workers',
    help='Number of Luigi workers to use. 1 worker recommended for development',
    type=int,
    default=1,
    show_default=True,
)
@click.pass_context
def cli(ctx, workers: int):
    ctx.ensure_object(dict)
    ctx.obj['workers'] = workers

    logger.info(f'Running with {workers=}')


@cli.command(
    short_help='Run daily file ingest pipeline',
)
@click.option(
    '-s',
    '--start-date',
    help='Start date (YYYY-MM-DD)',
    type=DateParameter(),
    required=True,
)
@click.option(
    '-e',
    '--end-date',
    help='End date (YYYY-MM-DD)',
    type=DateParameter(),
    required=True,
)
@click.pass_context
def daily(ctx, start_date: dt.date, end_date: dt.date):
    """Create daily NetCDFs with only data we care about from CFSR source data.

    The source data (GRIB2) will be filtered for only the variables of interest,
    subset to only the region of interest, and reprojected for the area of interest.
    """
    # NOTE: Imports are inside the function body to avoid the import being executed
    # during sphinx-click's analysis of this module.
    import luigi

    from sipn_reanalysis_ingest.luigitasks.main import ProcessDateRange

    luigi.build(
        [ProcessDateRange(start_date=start_date, end_date=end_date)],
        workers=ctx.obj['workers'],
    )


@cli.command(
    short_help='Run monthly file ingest pipeline',
)
@click.option(
    '-s',
    '--start-month',
    help='Start month (YYYY-MM)',
    type=MonthParameter(),
    required=True,
)
@click.option(
    '-e',
    '--end-month',
    help='End month (YYYY-MM)',
    type=MonthParameter(),
    required=True,
)
@click.pass_context
def monthly(ctx, start_month, end_month):
    """Create daily NetCDFs with only data we care about from CFSR source data.

    The source data (GRIB2) will be filtered for only the variables of interest,
    subset to only the region of interest, and reprojected for the area of interest.
    """
    # NOTE: Imports are inside the function body to avoid the import being executed
    # during sphinx-click's analysis of this module.
    import luigi

    from sipn_reanalysis_ingest.luigitasks.main import ProcessMonthRange

    luigi.build(
        [ProcessMonthRange(start_month=start_month, end_month=end_month)],
        workers=ctx.obj['workers'],
    )


if __name__ == '__main__':
    # https://click.palletsprojects.com/en/8.1.x/commands/#nested-handling-and-contexts
    cli(obj={})
