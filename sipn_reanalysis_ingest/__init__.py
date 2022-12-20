from pathlib import Path

import click

import sipn_reanalysis_ingest.constants.variables as variables
import sipn_reanalysis_ingest.constants.variables_monthly as variables_monthly
from sipn_reanalysis_ingest.errors import CfsrInputDataError
from sipn_reanalysis_ingest.util.log import logger
from sipn_reanalysis_ingest.util.convert.read_grib_daily import read_grib_daily
from sipn_reanalysis_ingest.util.convert.read_grib_monthly import read_grib_monthly


def convert_grib2s_to_nc(
    *,
    analysis_inputs: list[Path],
    forecast_inputs: list[Path],
    output_path: Path,
) -> Path:
    if not (len(analysis_inputs) == 4 and len(forecast_inputs) == 4):
        raise CfsrInputDataError(
            'Expected 4 of each type of file. Received:'
            f' {analysis_inputs=}; {forecast_inputs=}'
        )

    datet=analysis_inputs[0]
    date=datet[12:21]

    read_grib(analysis_inputs,forecast_inputs,date)

    logger.info(f'Created {output_path}')
    return output_path

if __name__ == '__main__':

    @click.command()
    @click.option(
        '-a',
        '--analysis-inputs',
        type=click.Path(),
        nargs=4,
        help='Exactly four 6-hourly CFSR analysis inputs.',
        required=True,
    )
    @click.option(
        '-f',
        '--forecast-inputs',
        type=click.Path(),
        nargs=4,
        help='Exactly four 6-hourly CFSR forecast inputs.',
        required=True,
    )
    @click.option(
        '-o',
        '--output',
        'output_path',
        type=click.Path(),
        help='The path the output .nc file will be written to',
        required=True,
    )
    def cli_test_convert(analysis_inputs, forecast_inputs, output_path):
        """Test this module from CLI.

        e.g.:

            PYTHONPATH=. python sipn_reanalysis_ingest/util/convert/__init__.py
        """
        convert_grib2s_to_nc(
            analysis_inputs=analysis_inputs,
            forecast_inputs=forecast_inputs,
            output_path=output_path,
        )

    cli_test_convert()
