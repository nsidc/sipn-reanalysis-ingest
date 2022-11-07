from pathlib import Path

from sipn_reanalysis_ingest.util.log import logger 


def convert_grib2s_to_nc(
    grib2_files: list[Path],
    *,
    output_path: Path,
) -> Path:
    with open(output_path, 'w') as f:
        f.write('NetCDF data goes in here!')

    logger.info(f'Created {output_path}')
    return output_path
