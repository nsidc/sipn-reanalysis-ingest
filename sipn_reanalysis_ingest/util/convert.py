from pathlib import Path

import click

from sipn_reanalysis_ingest.util.log import logger


def convert_grib2s_to_nc(
    grib2_files: list[Path],
    *,
    output_path: Path,
) -> Path:
    with open(output_path, 'w') as f:
        f.write('NetCDF data goes in here!\n')

    logger.info(f'Created {output_path}')
    return output_path


if __name__ == '__main__':

    @click.command()
    @click.argument(
        'grib2_files',
        nargs=-1,
    )
    @click.option(
        '-o',
        '--output',
        'output_path',
        type=click.Path(),
        help='The path the output .nc file will be written to',
        required=True,
    )
    def cli_test_convert(grib2_files, output_path):
        """Test this module from CLI.

        e.g.:

            PYTHONPATH=. python sipn_reanalysis_ingest/util/convert.py
        """
        convert_grib2s_to_nc(grib2_files, output_path=output_path)

    cli_test_convert()
