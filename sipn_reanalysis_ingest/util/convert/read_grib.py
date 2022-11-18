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

def read_grib(var,afiles,ffiles):
    
    outvar = np.empty([101,720,len(var)],dtype="float")
    outlev = np.empty(len(var))
    for v in var:
       try: 
          for i in afiles:
             fn = xr.open_dataset(i,engine='pynio')
             invar = fn.variables[var[v]]
             data = invar.data
             if(len(var) > 0):
                outvar[:,:,1]=data[33,0:101,:]
                outvar[:,:,2]=data[30,0:101,:]
                outvar[:,:,3]=data[21,0:101,:]
             else:
                outvar[:,:,0]=data[0:101,720]
### Grab data
       except: 
          for i in ffiles:
             fn = xr.open_dataset(i,engine='pynio')
             invar = fn.variables[var[v]]
             data = invar.data
             outvar[:,:,0]=data[0:101,720]

### Interpolate
### Write netcdf data
