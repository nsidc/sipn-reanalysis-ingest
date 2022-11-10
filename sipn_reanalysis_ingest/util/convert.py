from pathlib import Path

import click

from sipn_reanalysis_ingest.util.log import logger


def convert_grib2s_to_nc(
    *,
    analysis_inputs: list[Path],
    forecast_inputs: list[Path],
    output_path: Path,
) -> Path:
    if not (
        len(analysis_inputs) == 4
        and len(forecast_inputs) == 4
    ):
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

            PYTHONPATH=. python sipn_reanalysis_ingest/util/convert.py
        """
        convert_grib2s_to_nc(
            analysis_inputs=analysis_inputs,
            forecast_inputs=forecast_inputs,
            output_path=output_path,
        )

    cli_test_convert()
