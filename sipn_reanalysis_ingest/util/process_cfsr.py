## function to process CFSR data
## TODO
# 	- from NCAR best?
# 	- How often new data available
## ENDToDo

import glob
import tarfile

from sipn_reanalysis_ingest.constants.variables import CFSR_VARIABLES

# import Nio


def process_cfsr():
    untar_files()
    read_grib(CFSR_VARIABLES)


def untar_files():
    datadir = "/data/ecassano/Current_projects/SIPN2/CFSR/"
    numfiles = glob.glob(datadir + "*.1979*tar")
    for i in numfiles:
        tar = tarfile.open(i)
        tar.extractall()
        tar.close()


def read_grib(variables):
    raise NotImplementedError()
    # numfiles = glob.glob("*19790101*.grb2")
    # for i in numfiles:
    #     grib_file = Nio.open_file(i)
    #     for v in variables:
    #         var = grib_file.variables[v]
    #         ...


if __name__ == "__main__":
    process_cfsr()
