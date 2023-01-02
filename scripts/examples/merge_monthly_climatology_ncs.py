#!/usr/bin/env python
from pathlib import Path

import xarray as xra


test_data_dir = Path('/share/apps/sipn-reanalysis-all/_test_data')
input_dir = test_data_dir / '_climatology_separate_files'
input_file_mask = '??.1981-2010_climate.nc'

output_dir = test_data_dir / 'climatology'
output_fp = output_dir / 'monthly_1981-2010_climatology.nc'


def set_month_from_fn(dataset: xra.Dataset) -> xra.Dataset:
    fp = Path(dataset.encoding['source'])
    month = int(fp.name[0:2])

    return dataset.assign(month=month)


def main() -> None:
    files = sorted(input_dir.glob(input_file_mask))

    dataset = xra.open_mfdataset(
        files,
        concat_dim='month',
        preprocess=set_month_from_fn,
        combine='nested',
        parallel=True,
        engine='netcdf4',
    )

    output_path = output_dir / output_fp
    comp = {
        "zlib": True,
        "complevel": 5,
    }
    encoding = {var: comp for var in dataset.data_vars}
    dataset.to_netcdf(
        output_path,
        mode="w",
        format="NETCDF4",
        encoding=encoding,
    )
    return


if __name__ == '__main__':
    main()
