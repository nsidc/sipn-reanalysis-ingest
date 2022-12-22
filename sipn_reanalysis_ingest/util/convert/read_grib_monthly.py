"""Functions to read in the grib data.

Begin: 11/7/22
author: @ecassano

Will return an array of daily data for eventual output to a single netcdf file
"""
from pathlib import Path

import rioxarray
import xarray as xr

import sipn_reanalysis_ingest.constants.variables_monthly as variables
from sipn_reanalysis_ingest.constants.crs import PROJ_DEST, PROJ_SRC
from sipn_reanalysis_ingest.util.convert.reorg_xarr_monthly import (
    reorg_xarr_monthly as reorg_xarr,
)
from sipn_reanalysis_ingest.util.convert.write import write_dataset


def read_grib_monthly(afile: Path, ffile: Path, output_path: Path) -> None:

    # Parse through variables to extract variable names
    vs = [v for v in dir(variables) if not v.startswith('__')]
    si = []
    for z in vs:
        si.append(list(getattr(variables, z).values()))

    vari = []
    for i in si:
        for x in i:
            if x not in vari:
                vari.append(x)

    # Open analysis and forecast monthly file
    fnf = xr.open_dataset(ffile, engine='pynio')
    fna = xr.open_dataset(afile, engine='pynio')

    # Merge these into a single dataset
    fn = fna.merge(fnf, compat='override')

    # Remove variables that we do not need
    totvar = list(fn)
    rmvars = [x for x in totvar if x not in vari]
    fnsm = fn.drop_vars(rmvars)

    # Extract data to 40N and only grab levels at 925, 850, and 500mb.
    fnsm = fnsm.isel(lat_0=slice(0, 101, 1), lv_ISBL0=[21, 30, 33])

    # Reproject to northern hemisphere polar stereographic
    fnsm.rio.write_crs(PROJ_SRC, inplace=True)
    fnsm.rio.set_spatial_dims(x_dim="lon_0", y_dim="lat_0", inplace=True)
    fnsm.rio.write_coordinate_system(inplace=True)
    dataproj = fnsm.rio.reproject(PROJ_DEST)

    # Call function to restructure dataset with proper variable names, array sizes, etc.
    dataout = reorg_xarr(dataproj)

    write_dataset(dataout, output_path=output_path)
    return
