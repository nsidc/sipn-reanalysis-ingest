# DELETEME: down to and including "noqa" line.
# Skip static analysis on this file, it's a WIP.
# mypy: ignore-errors
# flake8: noqa
"""Functions to read in the grib data.

Begin: 11/7/22
author: @ecassano

Will return an array of daily data for eventual output to a single netcdf file
"""

from pathlib import Path

import Nio
import numpy as np
import rioxarray
import xarray as xr

import sipn_reanalysis_ingest.constants.variables_daily as variables
from sipn_reanalysis_ingest.constants.crs import PROJ_DEST, PROJ_SRC
from sipn_reanalysis_ingest.util.convert.reorg_xarr_daily import (
    reorg_xarr_daily as reorg_xarr,
)


def read_grib_daily(
    afiles: list[Path],
    ffiles: list[Path],
    output_path: Path,
) -> None:

    # Parse through variables to extract variable names
    vs = [v for v in dir(variables) if not v.startswith('__')]
    si = []
    for z in vs:
        si.append(list(getattr(variables, z).values()))

    vari = []
    for i in si:
        [vari.append(x) for x in i if x not in vari]

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

    # Remove variables that we do not need
    totvar = [i for i in fn]
    rmvars = [x for x in totvar if x not in vari]
    fnsm = fn.drop_vars(rmvars)

    # Extract data to 40N and only grab levels at 925, 850, and 500mb.
    fnsm = fnsm.isel(lat_0=slice(0, 101, 1), lv_ISBL0=[21, 30, 33])

    # Calculate daily mean
    newfn = fnsm.mean(dim='t', keep_attrs=True)

    # Reproject to northern hemisphere polar stereographic
    newfn.rio.write_crs(PROJ_SRC, inplace=True)
    newfn.rio.set_spatial_dims(x_dim="lon_0", y_dim="lat_0", inplace=True)
    newfn.rio.write_coordinate_system(inplace=True)
    dataproj = newfn.rio.reproject(PROJ_DEST)

    # Call function to restructure dataset with proper variable names, array sizes, etc.
    dataout = reorg_xarr(dataproj)

    # Write newly restructured dataset to a netcdf file
    comp = {"zlib": True, "complevel": 5}
    encoding = {var: comp for var in dataout.data_vars}
    dataout.to_netcdf(
        output_path,
        mode="w",
        format="NETCDF4",
        encoding=encoding,
    )

    return
