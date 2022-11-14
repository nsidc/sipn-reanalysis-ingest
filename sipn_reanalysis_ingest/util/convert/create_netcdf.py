# DELETEME: down to and including "noqa" line.
# Skip static analysis on this file, it's a WIP.
# mypy: ignore-errors
# flake8: noqa
import Ngl
import Nio
import numpy as np

def create_fies(date,lat_0,lon_0):
    outf = Nio.open_file("cfsr." + date + ".nc", "c")

    outf.create_dimension('lat_0', array.dimensions['lat_0'])

    outf.create_variable('lat_0', lat_0.typecode(), lat.dimensions)

    outf.create_variable('t', 'f', ('time', 'lat', 'lon'))
