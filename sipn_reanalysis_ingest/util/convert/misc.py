import numpy as np
import xarray as xr

from sipn_reanalysis_ingest._types import CfsrPeriodicity
from sipn_reanalysis_ingest.constants.crs import PROJ_DEST, PROJ_SRC
from sipn_reanalysis_ingest.util.variables import get_all_grib_variables


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


def select_dataset_variables(
    dataset: xr.Dataset,
    *,
    periodicity: CfsrPeriodicity,
) -> xr.Dataset:
    """Keep only specified dataset variables."""
    variables = get_all_grib_variables(periodicity)
    totvar = list(dataset)
    rmvars = [x for x in totvar if x not in variables]

    filtered = dataset.drop_vars(rmvars)
    return filtered


def subset_latitude_and_levels(dataset: xr.Dataset) -> xr.Dataset:
    """Extract data to 40N and only grab levels at 925, 850, and 500mb."""
    subset = dataset.isel(lat_0=slice(0, 101, 1), lv_ISBL0=[21, 30, 33])
    return subset


def reproject_dataset_to_polarstereo_north(dataset: xr.Dataset) -> xr.Dataset:
    dataset.rio.write_crs(PROJ_SRC, inplace=True)
    dataset.rio.set_spatial_dims(x_dim="lon_0", y_dim="lat_0", inplace=True)
    dataset.rio.write_coordinate_system(inplace=True)
    reprojected = dataset.rio.reproject(PROJ_DEST)

    return reprojected
