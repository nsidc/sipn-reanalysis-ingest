# DELETEME: down to and including "noqa" line.
# Skip static analysis on this file, it's a WIP.
# mypy: ignore-errors
# flake8: noqa
import Ngl
import Nio
import numpy as np

def write_netcdf(outf,array):

    outf.create_variable('t', 'f', ('time', 'lat', 'lon'))
