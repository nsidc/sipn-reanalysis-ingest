from pathlib import Path

import click

import sipn_reanalysis_ingest.constants.variables as variables
from sipn_reanalysis_ingest.errors import CfsrInputDataError
from sipn_reanalysis_ingest.util.log import logger
from sipn_reanalysis_ingest.util.convert.read_grib import read_grib


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

    create_netcdf(date,lat_0,lon_0)
    read_grib(variables.t,analysis_inputs,forecast_inputs)

    array = ...

    read_grib(variables.v)
    read_grib(variables.u)
    read_grib(variables.sh)
    read_grib(variables.rh)
    read_grib(variables.hgt)
    read_grib(variables.pwat)
    read_grib(variables.slp)

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
