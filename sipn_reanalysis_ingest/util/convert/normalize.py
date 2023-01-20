import numpy as np
import xarray as xr

from sipn_reanalysis_ingest._types import CfsrPeriodicity
from sipn_reanalysis_ingest.util.convert.misc import (
    combine_surface_and_pls_with_nanfill,
    extract_var_from_dataset_with_nanfill,
)
from sipn_reanalysis_ingest.util.variables import get_variables_map, var_rename_mapping


# TODO: Do we need these `del` statements? Can we let the garbage collector handle it?
# TODO: Improve function name; does more than normalize varnames. Normalizes
# analysis-level dimension, normalizes fill values, calculates a new variable, etc.
def normalize_cfsr_varnames(
    dataset: xr.Dataset,
    *,
    periodicity: CfsrPeriodicity,
) -> xr.Dataset:
    varmap = get_variables_map(periodicity)

    # Temperature
    t1 = dataset[varmap['t']['2m']]
    t2 = dataset[varmap['t']['500mb']]

    # Get coords
    x = t1.coords['x']
    y = t1.coords['y']
    lev1 = list(reversed(varmap['t'].keys()))
    lev2 = list(reversed(varmap['u'].keys()))
    lev3 = list(reversed(varmap['hgt'].keys()))
    lev4 = list(varmap['mslp'].keys())
    lev5 = list(varmap['pwat'].keys())

    # Create an array that combines the surface and upper level data into a single 3d
    # array
    t3n = combine_surface_and_pls_with_nanfill(
        surface2d=t1.to_numpy(),
        pl3d=t2.to_numpy(),
    )

    # Create a xarray dataarray with new array, reassign attributes
    T = xr.DataArray(
        t3n,
        coords={'lev1': lev1, 'y': y, 'x': x},
        dims=['lev1', 'y', 'x'],
    )
    del t1, t2, t3n
    T = T.assign_attrs({'long_name': 'Temperature', 'units': 'K'})

    # Specific humidity
    sh1 = dataset[varmap['sh']['2m']]
    sh2 = dataset[varmap['sh']['500mb']]
    sh3n = combine_surface_and_pls_with_nanfill(
        surface2d=sh1.to_numpy(),
        pl3d=sh2.to_numpy(),
    )
    SH = xr.DataArray(
        sh3n,
        coords={'lev1': lev1, 'y': y, 'x': x},
        dims=['lev1', 'y', 'x'],
    )
    del sh1, sh2, sh3n
    SH = SH.assign_attrs({'long_name': 'Specific humidity', 'units': 'kg/kg'})

    # Relative humidity
    rh1 = dataset[varmap['rh']['2m']]
    rh2 = dataset[varmap['rh']['500mb']]
    rh3n = combine_surface_and_pls_with_nanfill(
        surface2d=rh1.to_numpy(),
        pl3d=rh2.to_numpy(),
    )
    RH = xr.DataArray(
        rh3n,
        coords={'lev1': lev1, 'y': y, 'x': x},
        dims=['lev1', 'y', 'x'],
    )
    del rh1, rh2, rh3n
    RH = RH.assign_attrs({'long_name': 'Relative humidity', 'units': 'kg/kg'})

    # Winds
    # Notice that we are using u1,u2,v1,v2 instead of t1 as above for wind speed
    # calculation purposes
    u1 = dataset[varmap['u']['10m']]
    u2 = dataset[varmap['u']['500mb']]
    u3n = combine_surface_and_pls_with_nanfill(
        surface2d=u1.to_numpy(),
        pl3d=u2.to_numpy(),
    )
    U = xr.DataArray(
        u3n,
        coords={'lev2': lev2, 'y': y, 'x': x},
        dims=['lev2', 'y', 'x'],
    )
    del u3n
    U = U.assign_attrs({'long_name': 'U-component of wind', 'units': 'm/s'})

    v1 = dataset[varmap['v']['10m']]
    v2 = dataset[varmap['v']['500mb']]
    v3n = combine_surface_and_pls_with_nanfill(
        surface2d=v1.to_numpy(),
        pl3d=v2.to_numpy(),
    )
    V = xr.DataArray(
        v3n,
        coords={'lev2': lev2, 'y': y, 'x': x},
        dims=['lev2', 'y', 'x'],
    )
    del v3n
    V = V.assign_attrs({'long_name': 'V-component of wind', 'units': 'm/s'})

    # Calculate wind speed
    wspd1 = np.sqrt(v1.values * v1.values + u1.values * u1.values)
    wspd2 = np.sqrt(v2.values * v2.values + u2.values * u2.values)
    del u1, u2, v1, v2
    wspd3n = combine_surface_and_pls_with_nanfill(
        surface2d=wspd1,
        pl3d=wspd2,
    )
    WSPD = xr.DataArray(
        wspd3n,
        coords={'lev2': lev2, 'y': y, 'x': x},
        dims=['lev2', 'y', 'x'],
    )
    WSPD = WSPD.assign_attrs({'long_name': 'Wind speed', 'units': 'm/s'})
    del wspd1, wspd2, wspd3n

    # Rename variables for remaining variables
    dataset = dataset.rename_vars(var_rename_mapping(periodicity))
    hgt = extract_var_from_dataset_with_nanfill(dataset, variable='HGT')
    pwat = extract_var_from_dataset_with_nanfill(dataset, variable='PWAT')
    slp = extract_var_from_dataset_with_nanfill(dataset, variable='MSLP')

    # Add dimension to 2d arrays so all arrays are 3d
    slp = slp.expand_dims(dim='lev4', axis=0)
    pwat = pwat.expand_dims(dim='lev5', axis=0)

    # Change dimension name for the height variable
    hgt = hgt.rename({'lv_ISBL0': 'lev3'})

    # Create the dataset that will finally be written out to the netcdf file!
    dataout = xr.Dataset(
        data_vars={
            'T': T,
            'U': U,
            'V': V,
            'HGT': hgt,
            'SH': SH,
            'RH': RH,
            'MSLP': slp,
            'PWAT': pwat,
            'WSPD': WSPD,
        },
        coords={
            'x': x,
            'y': y,
            'lev1': lev1,
            'lev2': lev2,
            'lev3': lev3,
            'lev4': lev4,
            'lev5': lev5,
        },
    )
    return dataout
