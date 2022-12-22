import numpy as np
import xarray as xr


def make_new3d(t1: xr.DataArray, t2: xr.DataArray) -> np.ndarray:
    """Combine surface and upper level variables into a single data array.

    Variables are combined by stacking the surface level 2d array "on top" of the upper
    level 3d array.

    * t1: 2d array representing surface level
    * t2: 3d array representing pressure levels above surface
    """
    t1n = t1.to_numpy()
    t2n = t2.to_numpy()
    t3n = np.empty((4, 517, 511), dtype='float32')
    t3n[3, :, :] = t1n[:, :]
    t3n[0:3, :, :] = t2n[:, :]
    return t3n
