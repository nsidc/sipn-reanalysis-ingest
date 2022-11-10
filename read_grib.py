"""
   Functions to read in the grib data

   Begin: 11/7/22
   Who wrote this?: Liz Cassano

   Will return an array of daily data for eventual output to a single netcdf file
"""

import glob
import Nio

def read_grib(vars):
   numfiles=glob.glob("*.grb2")
   for i in numfiles:
      fn=Nio.open_file(i)
      for v in vars:
         var=fn.variables[v]
