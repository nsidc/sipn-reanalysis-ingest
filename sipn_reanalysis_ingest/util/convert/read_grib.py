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

def read_grib(var,oname,afiles,ffiles,date):

    indir='/data/ecassano/Current_projects/SIPN2/Python/'
    tempvar = np.empty([101,720,len(var),4],dtype="float")
    outlev = np.empty(len(var))
    afiles=[indir+f for f in afiles]
    fn = xr.open_mfdataset(afiles,
        concat_dim = 't', 
        combine = 'nested',
        parallel = True, 
        engine='pynio')
    fn.rio.write_crs("epsg:4326",inplace=True)
    fn.rio.set_spatial_dims(
       x_dim="lon_0",
       y_dim="lat_0",
       inplace=True)
    fn.rio.write_coordinate_system(inplace=True)
    
    breakpoint() 
    return
    for v in var:
       try: 
          num=0
          for i in afiles:
             fn = xr.open_dataset(i,engine='pynio')
             invar = fn.variables[var[v]]
             data = invar.data
             if(len(var) > 0):
                if(len(var) == 3):
                   tempvar[:,:,0,num]=data[33,0:101,:]
                   tempvar[:,:,1,num]=data[30,0:101,:]
                   tempvar[:,:,2,num]=data[21,0:101,:]
                else:
                   tempvar[:,:,1,num]=data[33,0:101,:]
                   tempvar[:,:,2,num]=data[30,0:101,:]
                   tempvar[:,:,3,num]=data[21,0:101,:]
             else:
                tempvar[:,:,0,num]=data[0:101,:]
             num=num+1
       except: 
          num=0
          for i in ffiles:
             fn = xr.open_dataset(i,engine='pynio')
             invar = fn.variables[var[v]]
             data = invar.data
             tempvar[:,:,0,num]=data[0:101,:]
             num=num+1
    array=np.mean(tempvar,axis=3) 
    
### Interpolate

#    interpolate(array)

    lat_0=101
    lon_0=720
    level=len(var)


#    dataout=xr.DataArray(array,dims=['lat_0','lon_0','level'],coords={'lat_0':lat_0,'lon_0':lon_0,'level':level})
    dataout=xr.DataArray(array,dims=['lat_0','lon_0','level'])

    ds=xr.Dataset(data_vars = {oname:dataout})

    fname="cfsr." + date + ".nc"
    breakpoint()
    ds.to_netcdf(fname,mode="a",format="NETCDF4")


### Write netcdf data

if __name__ == '__main__':
   import sipn_reanalysis_ingest.constants.variables as variables
   afiles=['pgbhnl.gdas.1979123000.grb2', 'pgbhnl.gdas.1979123006.grb2', 'pgbhnl.gdas.1979123012.grb2', 'pgbhnl.gdas.1979123018.grb2']
   ffiles=['pgbh06.gdas.1979122918.grb2', 'pgbh06.gdas.1979123000.grb2', 'pgbh06.gdas.1979123006.grb2', 'pgbh06.gdas.1979123012.grb2']
   indir='/data/ecassano/Current_projects/SIPN2/Python/'
   var=variables.t
   read_grib(var,'T',afiles,ffiles,"19791230")
