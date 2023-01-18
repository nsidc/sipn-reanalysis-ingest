import numpy as np
import xarray as xr

from sipn_reanalysis_ingest._types import CfsrPeriodicity
from sipn_reanalysis_ingest.util.convert.misc import make_new3d
from sipn_reanalysis_ingest.util.variables import get_variables_map, var_rename_mapping


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

    # Call function to create an array that combines the surface and upper level data
    # a single array
    t3n = make_new3d(t1, t2)

    # Create a xarray dataarray with new array, reassign attributes
    T = xr.DataArray(
        t3n,
        coords={'lev1': lev1, 'y': y, 'x': x},
        dims=['lev1', 'y', 'x'],
    )
    T = T.assign_attrs({'long_name': 'Temperature', 'units': 'K'})
    del t1, t2, t3n

    # Specific humidity
    t1 = dataset[varmap['sh']['2m']]
    t2 = dataset[varmap['sh']['500mb']]
    t3n = make_new3d(t1, t2)
    SH = xr.DataArray(
        t3n,
        coords={'lev1': lev1, 'y': y, 'x': x},
        dims=['lev1', 'y', 'x'],
    )
    SH = SH.assign_attrs({'long_name': 'Specific humidity', 'units': 'kg/kg'})
    del t1, t2, t3n

    # Relative humidity
    t1 = dataset[varmap['rh']['2m']]
    t2 = dataset[varmap['rh']['500mb']]
    t3n = make_new3d(t1, t2)
    RH = xr.DataArray(
        t3n,
        coords={'lev1': lev1, 'y': y, 'x': x},
        dims=['lev1', 'y', 'x'],
    )
    RH = RH.assign_attrs({'long_name': 'Relative humidity', 'units': 'kg/kg'})
    del t1, t2, t3n

    # Winds
    # Notice that we are using u1,u2,v1,v2 instead of t1 as above for wind speed
    # calculation purposes
    u1 = dataset[varmap['u']['10m']]
    u2 = dataset[varmap['u']['500mb']]
    u3n = make_new3d(u1, u2)
    U = xr.DataArray(
        u3n,
        coords={'lev2': lev2, 'y': y, 'x': x},
        dims=['lev2', 'y', 'x'],
    )
    U = U.assign_attrs({'long_name': 'U-component of wind', 'units': 'm/s'})

    v1 = dataset[varmap['v']['10m']]
    v2 = dataset[varmap['v']['500mb']]
    v3n = make_new3d(v1, v2)
    V = xr.DataArray(
        v3n,
        coords={'lev2': lev2, 'y': y, 'x': x},
        dims=['lev2', 'y', 'x'],
    )
    V = V.assign_attrs({'long_name': 'V-component of wind', 'units': 'm/s'})

    # Calculate wind speed
    wspd1 = np.sqrt(v1.values * v1.values + u1.values * u1.values)
    wspd2 = np.sqrt(v2.values * v2.values + u2.values * u2.values)
    t3n = np.empty((4, 517, 511), dtype='float32')
    t3n[3, :, :] = wspd1[:, :]
    t3n[0:3, :, :] = wspd2[:, :]
    WSPD = xr.DataArray(
        t3n,
        coords={'lev2': lev2, 'y': y, 'x': x},
        dims=['lev2', 'y', 'x'],
    )
    WSPD = WSPD.assign_attrs({'long_name': 'Wind speed', 'units': 'm/s'})
    del u1, u2, v1, v2, u3n, v3n, t3n, wspd1, wspd2

    # Rename variables for remaining variables
    dataset = dataset.rename_vars(var_rename_mapping(periodicity))
    hgt = dataset.HGT
    pwat = dataset.PWAT
    slp = dataset.MSLP

    # Add dimension to 2d arrays so all arrays are 3d
    slp = slp.expand_dims(dim='lev4', axis=0)
    pwat = pwat.expand_dims(dim='lev5', axis=0)

    # Change dimension name for the height variable
    hgt = hgt.swap_dims({'lv_ISBL0': 'lev3'})

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
