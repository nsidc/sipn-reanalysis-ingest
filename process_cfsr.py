'''
   Program to process CFSR data

   This program:
	-untars the CFSR data
	-Extracts the necessary data
	-Writes output to netcdf files, 1 for each day
'''

import glob
import tarfile
import Nio
import read_grib
import variables

def process_cfsr():
   untar_files()
   read_grib(variables.fourd10m)

   write_netcdf(array)
   read_grib(variables.fourd2m)
   read_grib(variables.threed)
   read_grib(variables.twodf)
   read_grib(variables.twoda)


def untar_files():
   datadir="/data/ecassano/Current_projects/SIPN2/CFSR/"
   numfiles=glob.glob(datadir+"*.1979*tar")
   for i in numfiles:
      tar=tarfile.open(i)
      tar.extractall()
      tar.close()

if __name__ == "__main__":
   process_cfsr()
