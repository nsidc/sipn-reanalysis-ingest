## function to process CFSR data

import variables
from sipn_reanalysis_ingest.constants.variables import CFSR_VARIABLES

import Nio

def process_cfsr():
    read_grib(CFSR_VARIABLES)

if __name__ == "__main__":
    process_cfsr()
