from pathlib import Path

import click

from sipn_reanalysis_ingest.errors import CfsrInputDataError
from sipn_reanalysis_ingest.util.log import logger
import sipn_reanalysis_ingest.util.convert.read_grib_daily as read_grib_daily 
import sipn_reanalysis_ingest.util.convert.read_grib_monthly as read_grib_monthly 

def convert_6hourly_grib2s_to_nc(
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

    with open(output_path, 'w') as f:
        f.write('NetCDF data goes in here!\n')
        f.write('\n')

        f.write('>> Analysis inputs:\n')
        for analysis_input in analysis_inputs:
            f.write(f'  * {analysis_input}\n')

        f.write('>> Forecast inputs:\n')
        for forecast_input in forecast_inputs:
            f.write(f'  * {forecast_input}\n')

    datet=analysis_inputs[0] 
    date=datet[12:21]
    read_grib_daily(analysis_inputs,forecast_inputs,date)

    logger.info(f'Created {output_path}')
    return output_path


def convert_monthly_grib2s_to_nc(
    *,
    analysis_input: Path,
    forecast_input: Path,
    output_path: Path,
) -> Path:
    with open(output_path, 'w') as f:
        f.write('NetCDF data goes in here!\n')
        f.write('\n')
        f.write(f'>> Analysis input: {analysis_input}\n')
        f.write(f'>> Forecast input: {forecast_input}\n')

    datet=analysis_input
    date=datet[12:21]
    read_grib_monthly(analysis_input,forecast_input,date)

    logger.info(f'Created {output_path}')
    return output_path


if __name__ == '__main__':

    @click.group()
    def cli():
        """Test conversion funcs from CLI.
        e.g.:
            PYTHONPATH=. python sipn_reanalysis_ingest/util/convert.py
        """
        pass

    @cli.command()
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
    def six_hourly(analysis_inputs, forecast_inputs, output_path):
        """Test 6-hourly convert function."""
        convert_6hourly_grib2s_to_nc(
            analysis_inputs=analysis_inputs,
            forecast_inputs=forecast_inputs,
            output_path=output_path,
        )

    @cli.command()
    @click.option(
        '-a',
        '--analysis-input',
        type=click.Path(),
        help='A monthly CFSR analysis input.',
        required=True,
    )
    @click.option(
        '-f',
        '--forecast-input',
        type=click.Path(),
        help='A monthly CFSR forecast input.',
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
    def monthly(analysis_input, forecast_input, output_path):
        """Test monthly convert function."""
        convert_monthly_grib2s_to_nc(
            analysis_input=analysis_input,
            forecast_input=forecast_input,
            output_path=output_path,
        )

    cli()

