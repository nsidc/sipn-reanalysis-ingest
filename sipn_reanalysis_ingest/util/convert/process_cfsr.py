"""Program to process CFSR data.

This program:
    -untars the CFSR data
    -Extracts the necessary data
    -Writes output to netcdf files, 1 for each day
"""

import glob
import tarfile

import sipn_reanalysis_ingest.constants.variables as variables
from sipn_reanalysis_ingest.util.convert.read_grib import read_grib
from sipn_reanalysis_ingest.util.convert.write_netcdf import write_netcdf


def process_cfsr():
    untar_files()
    read_grib(variables.fourd10m)

    array = ...

    write_netcdf(array)
    read_grib(variables.fourd2m)
    read_grib(variables.threed)
    read_grib(variables.twodf)
    read_grib(variables.twoda)


def untar_files():
    datadir = "/data/ecassano/Current_projects/SIPN2/CFSR/"
    numfiles = glob.glob(datadir + "*.1979*tar")
    for i in numfiles:
        tar = tarfile.open(i)
        tar.extractall()
        tar.close()


if __name__ == "__main__":
    process_cfsr()
