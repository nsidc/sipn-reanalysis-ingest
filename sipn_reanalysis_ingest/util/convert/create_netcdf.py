# DELETEME: down to and including "noqa" line.
# Skip static analysis on this file, it's a WIP.
# mypy: ignore-errors
# flake8: noqa
import Ngl
import Nio
import numpy as np

def create_netcdf(date):

ds = xr.Dataset(
   ...:     {"foo": (("x", "y"), np.random.rand(4, 5))},
   ...:     coords={
   ...:         "x": [10, 20, 30, 40],
   ...:         "y": pd.date_range("2000-01-01", periods=5),
   ...:         "z": ("x", list("abcd")),
   ...:     },
   ...: )
   ...: 

In [2]: ds.to_netcdf("saved_on_disk.nc",mode="w",format="NETCDF4":q
)
    fn=xr.open_dataset("../../constants/Static_data_cfsr.nc")

    lat_0=fn.variables["lat_0"]
    lon_0=fn.variables["lon_0"]

    latout = xr.Dataset({"lat_0":("lat_0"),mode="w",format="NETCDF4"
   
    fname = "cfsr." + date + ".nc"

    outf.create_dimension('lat_0', fn.dimensions['lat_0'])
    outf.create_variable('lat_0', lat_0.typecode(), lat_0.dimensions)

    outf.create_dimension('lon_0', fn.dimensions['lon_0'])
    outf.create_variable('lon_0', lon_0.typecode(), lon_0.dimensions)

    outf.variables['lat_0'].assign_value(lat_0)
    outf.variables['lon_0'].assign_value(lon_0)

    outf.close()

    return(fname)
