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

def read_grib_monthly(afile,ffile,date):

    vs=[v for v in dir(variables_monthly) if not v.startswith('__')]
    si=[]
    for z in vs:
       si.append(list(getattr(variables_monthly,z).values()))

    vari=[]
    for i in si:
       [vari.append(x) for x in i if x not in vari]

    indir='/scr1/ecassano/CFSR/'
    fnf = xr.open_dataset(indir+ffile,engine='pynio')
    fna = xr.open_dataset(indir+afile,engine='pynio')
    fn=fna.merge(fnf,compat='override')
    totvar=[i for i in fn]
    rmvars=[x for x in totvar if x not in vari]
    fnsm=fn.drop_vars(rmvars)

    fnsm=fnsm.isel(lat_0=slice(0,101,1),lv_ISBL0=[21,30,33])
    fnsm.rio.write_crs("epsg:4326",inplace=True)
    fnsm.rio.set_spatial_dims(
       x_dim="lon_0",
       y_dim="lat_0",
       inplace=True)
    fnsm.rio.write_coordinate_system(inplace=True)
    dataproj=fnsm.rio.reproject("+proj=stere +lat_0=90 +lat_ts=70 +lon_0=-45 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m")

    dataout=reorg_xarr_monthly(dataproj)
    fname="cfsr." + date + ".nc"
    dataout.to_netcdf(fname,mode="a",format="NETCDF4")

    breakpoint() 
    return

if __name__ == '__main__':
   import sipn_reanalysis_ingest.constants.variables_monthly as variables_monthly
   from sipn_reanalysis_ingest.util.convert.reorg_xarr_monthly import reorg_xarr_monthly
   ffile='pgbh06.gdas.197912.grb2'
   afile='pgbhnl.gdas.197912.grb2'
   read_grib_monthly(afile,ffile,"197912")
