"""Functions to read in the grib data.

Begin: 11/7/22
author: @ecassano

Will return an array of daily data for eventual output to a single netcdf file
"""
from pathlib import Path
from typing import Final

import rioxarray  # noqa: F401; Activate xarray extension
import xarray as xr

from sipn_reanalysis_ingest.util.convert.misc import (
    reproject_dataset_to_polarstereo_north,
    select_dataset_variables,
    subset_latitude_and_levels,
)
from sipn_reanalysis_ingest.util.convert.normalize import normalize_cfsr_varnames
from sipn_reanalysis_ingest.util.convert.write import write_dataset


def read_grib_monthly(afile: Path, ffile: Path, output_path: Path) -> None:
    # Open analysis and forecast monthly file
    fnf = xr.open_dataset(ffile, engine='pynio')
    fna = xr.open_dataset(afile, engine='pynio')

    # Merge these into a single dataset
    fn = fna.merge(fnf, compat='override')

    periodicity: Final = 'monthly'
    fnsm = select_dataset_variables(fn, periodicity=periodicity)
    fnsm = subset_latitude_and_levels(fnsm)
    dataproj = reproject_dataset_to_polarstereo_north(fnsm)
    dataout = normalize_cfsr_varnames(dataproj, periodicity=periodicity)

    write_dataset(dataout, output_path=output_path)
    return
