import numpy as np
import xarray as xr

from sipn_reanalysis_ingest._types import CfsrPeriodicity
from sipn_reanalysis_ingest.constants.crs import PROJ_DEST, PROJ_SRC
from sipn_reanalysis_ingest.util.variables import get_all_grib_variables


def combine_surface_and_pls_with_nanfill(
    *,
    surface2d: np.ndarray,
    pl3d: np.ndarray,
) -> np.ndarray:
    """Combine surface and upper level variables into a single data array.

    Variables are combined by stacking the surface level 2d array "on top" of the upper
    level 3d array.

    * surface2d: 2d array representing surface level
    * pl3d: 3d array representing pressure levels above surface. Expected to contain
      exactly 3 pressure levels.
    """
    combined = np.empty((4, 517, 511), dtype='float32')
    combined[3, :, :] = surface2d[:, :]
    combined[0:3, :, :] = pl3d[:, :]
    return _max_to_nan(combined)


def extract_var_from_dataset_with_nanfill(
    dataset: xr.Dataset,
    *,
    variable: str,
) -> xr.DataArray:
    data_array = dataset[variable]

    # Get rid of any fill value already set
    if '_FillValue' in data_array.attrs:
        del data_array.attrs['_FillValue']

    data_array.data = _max_to_nan(data_array.to_numpy())
    return data_array


def _max_to_nan(array: np.ndarray) -> np.ndarray:
    """Replace the maximum value for the array's dtype with NaN.

    Expects only float32 datatypes.
    """
    dtype = array.dtype
    if dtype != np.float32:
        raise RuntimeError(f'Expected float32 dtype, got {dtype}')

    max_val = np.finfo(dtype).max

    array[array == max_val] = np.nan
    array[array == np.inf] = np.nan
    return array


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
