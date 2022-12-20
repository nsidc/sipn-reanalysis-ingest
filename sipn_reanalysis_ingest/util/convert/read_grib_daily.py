# DELETEME: down to and including "noqa" line.
# Skip static analysis on this file, it's a WIP.
# mypy: ignore-errors
# flake8: noqa
"""Functions to read in the grib data.

Begin: 11/7/22
author: @ecassano

Will return an array of daily data for eventual output to a single netcdf file
"""

import xarray as xr
import Nio
import numpy as np
import rioxarray
import sipn_reanalysis_ingest.constants.variables as variables
from sipn_reanalysis_ingest.util.convert.reorg_xarr import reorg_xarr

def read_grib_daily(afiles,ffiles,date):

# Parse through variables to extract variable names
    vs=[v for v in dir(variables) if not v.startswith('__')]
    si=[]
    for z in vs:
       si.append(list(getattr(variables,z).values()))

    vari=[]
    for i in si:
       [vari.append(x) for x in i if x not in vari]

    indir='/data/ecassano/Current_projects/SIPN2/Python/'

# Forecast files
    ffiles=[indir+f for f in ffiles]
    fnf = xr.open_mfdataset(ffiles,
        concat_dim = 't', 
        combine = 'nested',
        parallel = True, 
        engine='pynio')
# Analysis files
    afiles=[indir+f for f in afiles]
    fna = xr.open_mfdataset(afiles,
        concat_dim = 't', 
        combine = 'nested',
        parallel = True, 
        engine='pynio')

# Merge everything into a single dataset
    fn=fna.merge(fnf,compat='override')

# Remove variables that we do not need
    totvar=[i for i in fn]
    rmvars=[x for x in totvar if x not in vari]
    fnsm=fn.drop_vars(rmvars)

# Extract data to 40N and only grab levels at 925, 850, and 500mb.
    fnsm=fnsm.isel(lat_0=slice(0,101,1),lv_ISBL0=[21,30,33])

# Calculate daily mean
    newfn=fnsm.mean(dim='t',keep_attrs=True)

# Reproject to northern hemisphere polar stereographic
    newfn.rio.write_crs("epsg:4326",inplace=True)
    newfn.rio.set_spatial_dims(
       x_dim="lon_0",
       y_dim="lat_0",
       inplace=True)
    newfn.rio.write_coordinate_system(inplace=True)
    dataproj=newfn.rio.reproject("+proj=stere +lat_0=90 +lat_ts=70 +lon_0=-45 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m")

# Call function to restructure dataset with proper variable names, array sizes, etc.
    dataout=reorg_xarr(dataproj)

# Write newly restructured dataset to a netcdf file
    fname="cfsr." + date + ".nc"
    dataout.to_netcdf(fname,mode="a",format="NETCDF4")

    return

if __name__ == '__main__':
   import sipn_reanalysis_ingest.constants.variables as variables
   from sipn_reanalysis_ingest.util.convert.reorg_xarr import reorg_xarr
   afiles=['pgbhnl.gdas.1979123000.grb2', 'pgbhnl.gdas.1979123006.grb2', 'pgbhnl.gdas.1979123012.grb2', 'pgbhnl.gdas.1979123018.grb2']
   ffiles=['pgbh06.gdas.1979122918.grb2', 'pgbh06.gdas.1979123000.grb2', 'pgbh06.gdas.1979123006.grb2', 'pgbh06.gdas.1979123012.grb2']
   indir='/data/ecassano/Current_projects/SIPN2/Python/'
   read_grib_daily(afiles,ffiles,"19791230")
