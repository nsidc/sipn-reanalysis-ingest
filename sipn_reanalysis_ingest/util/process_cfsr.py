## function to process CFSR data
## TODO
# 	- from NCAR best?
# 	- How often new data available
## ENDToDo

import glob
import tarfile

# import Nio

BREAK!

def process_cfsr():
    vars = [
        "TMP_P0_L103_GGA0",
        "UGRD_P0_L103_GGA0",
        "VGRD_P0_L103_GGA0",
        "PWAT_P0_L200_GLL0",
        "SPFH_P0_L103_GLL0",
        "RH_P0_L103_GLL0",
        "UGRD_P0_L100_GLL0",
        "VGRD_P0_L100_GLL0",
        "SPFH_P0_L100_GLL0",
    ]
    untar_files()
    read_grib(vars)


def untar_files():
    datadir = "/data/ecassano/Current_projects/SIPN2/CFSR/"
    numfiles = glob.glob(datadir + "*.1979*tar")
    for i in numfiles:
        tar = tarfile.open(i)
        tar.extractall()
        tar.close()


def read_grib(vars):
    raise NotImplementedError()
    # numfiles = glob.glob("*19790101*.grb2")
    # for i in numfiles:
    #     fn = Nio.open_file(i)
    #     for v in vars:
    #         var = fn.variables[v]
    #         ...


if __name__ == "__main__":
    process_cfsr()
