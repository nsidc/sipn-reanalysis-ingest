# DELETEME: down to and including "noqa" line.
# Skip static analysis on this file, it's a WIP.
# mypy: ignore-errors
# flake8: noqa
"""Functions to read in the grib data.

Begin: 11/7/22
author: @ecassano

Will return an array of daily data for eventual output to a single netcdf file
"""

import Nio

def read_grib(var,afiles,ffiles):
    for v in list(var):
       try: 
          for i in afiles:
             fn = Nio.open_file(i)
             invar = fn.variables[var[v]]
### Grab data
       except: 
          for i in ffiles:
             fn = Nio.open_file(i)
             invar = fn.variables[var[v]]
             
