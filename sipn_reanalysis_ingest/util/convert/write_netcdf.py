# DELETEME: down to and including "noqa" line.
# Skip static analysis on this file, it's a WIP.
# mypy: ignore-errors
# flake8: noqa
import xarray as xr
import numpy as np

def write_netcdf(fname,array):

    outf = Nio.open_file(fname)
    outf.create_variable('t', 'f', ('time', 'lat', 'lon'))

    outf.to_netcdf(fname)
