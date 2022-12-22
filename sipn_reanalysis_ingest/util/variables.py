from typing import Literal, TypedDict, cast

from sipn_reanalysis_ingest._types import CfsrPeriodicity

# Use "alternative" syntax to support keys starting with numbers:
LevelsToGribVariables2m = TypedDict(
    'LevelsToGribVariables2m', {'2m': str, '925mb': str, '850mb': str, '500mb': str}
)
LevelsToGribVariables10m = TypedDict(
    'LevelsToGribVariables10m', {'10m': str, '925mb': str, '850mb': str, '500mb': str}
)
LevelsToGribVariablesPressureOnly = TypedDict(
    'LevelsToGribVariablesPressureOnly', {'925mb': str, '850mb': str, '500mb': str}
)


class AtmosColToGribVariable(TypedDict):
    atmscol: str


class SeaLevelToGribVariable(TypedDict):
    sl: str


class Variables(TypedDict):
    t: LevelsToGribVariables2m
    sh: LevelsToGribVariables2m
    rh: LevelsToGribVariables2m
    u: LevelsToGribVariables10m
    v: LevelsToGribVariables10m
    hgt: LevelsToGribVariablesPressureOnly
    pwat: AtmosColToGribVariable
    slp: SeaLevelToGribVariable


def get_variables_map(periodicity: Literal['daily', 'monthly']) -> Variables:
    if periodicity == 'daily':
        infix = 'P0'
    elif periodicity == 'monthly':
        infix = 'P8'

    return {
        't': {
            '2m': f'TMP_{infix}_L103_GLL0',
            '925mb': f'TMP_{infix}_L100_GLL0',
            '850mb': f'TMP_{infix}_L100_GLL0',
            '500mb': f'TMP_{infix}_L100_GLL0',
        },
        'sh': {
            '2m': f'SPFH_{infix}_L103_GLL0',
            '925mb': f'SPFH_{infix}_L100_GLL0',
            '850mb': f'SPFH_{infix}_L100_GLL0',
            '500mb': f'SPFH_{infix}_L100_GLL0',
        },
        'rh': {
            '2m': f'RH_{infix}_L103_GLL0',
            '925mb': f'RH_{infix}_L100_GLL0',
            '850mb': f'RH_{infix}_L100_GLL0',
            '500mb': f'RH_{infix}_L100_GLL0',
        },
        'u': {
            '10m': f'UGRD_{infix}_L103_GLL0',
            '925mb': f'UGRD_{infix}_L100_GLL0',
            '850mb': f'UGRD_{infix}_L100_GLL0',
            '500mb': f'UGRD_{infix}_L100_GLL0',
        },
        'v': {
            '10m': f'VGRD_{infix}_L103_GLL0',
            '925mb': f'VGRD_{infix}_L100_GLL0',
            '850mb': f'VGRD_{infix}_L100_GLL0',
            '500mb': f'VGRD_{infix}_L100_GLL0',
        },
        'hgt': {
            '925mb': f'HGT_{infix}_L100_GLL0',
            '850mb': f'HGT_{infix}_L100_GLL0',
            '500mb': f'HGT_{infix}_L100_GLL0',
        },
        'pwat': {'atmscol': f'PWAT_{infix}_L200_GLL0'},
        'slp': {'sl': f'PRMSL_{infix}_L101_GLL0'},
    }


def get_all_grib_variables(periodicity: CfsrPeriodicity) -> list[str]:
    # NOTE: Conversions to dict are to satisfy type checker:
    #       https://github.com/python/mypy/issues/6082
    varmap = cast(dict, get_variables_map(periodicity))

    grib_vars = []
    # Dig two levels into the dict
    for level_mapping in varmap.values():
        for grib_varname in level_mapping.values():
            grib_vars.append(grib_varname)

    return grib_vars
