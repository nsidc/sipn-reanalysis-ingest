"""Functions to read in the grib data.

Begin: 11/7/22
author: @ecassano

Will return an array of daily data for eventual output to a single netcdf file
"""

from pathlib import Path

import rioxarray  # noqa: F401; Activate xarray extension
import xarray as xr

import sipn_reanalysis_ingest.constants.variables_daily as variables
from sipn_reanalysis_ingest.util.convert.misc import (
    get_variable_names,
    reproject_dataset_to_polarstereo_north,
    select_dataset_variables,
    subset_latitude_and_levels,
)
from sipn_reanalysis_ingest.util.convert.reorg_xarr_daily import (
    reorg_xarr_daily as reorg_xarr,
)
from sipn_reanalysis_ingest.util.convert.write import write_dataset


def read_grib_daily(
    afiles: list[Path],
    ffiles: list[Path],
    output_path: Path,
) -> None:
    vari = get_variable_names(variables)

    # Forecast files
    fnf = xr.open_mfdataset(
        ffiles,
        concat_dim='t',
        combine='nested',
        parallel=True,
        engine='pynio',
    )

    # Analysis files
    fna = xr.open_mfdataset(
        afiles,
        concat_dim='t',
        combine='nested',
        parallel=True,
        engine='pynio',
    )

    # Merge everything into a single dataset (forecast and analysis have unique variable
    # names)
    fn = fna.merge(fnf, compat='override')

    fnsm = select_dataset_variables(fn, variables=vari)
    fnsm = subset_latitude_and_levels(fnsm)
    newfn = fnsm.mean(dim='t', keep_attrs=True)
    dataproj = reproject_dataset_to_polarstereo_north(newfn)

    # Call function to restructure dataset with proper variable names, array sizes, etc.
    dataout = reorg_xarr(dataproj)

    write_dataset(dataout, output_path=output_path)
    return
