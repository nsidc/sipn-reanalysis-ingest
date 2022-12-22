import xarray as xr


def write_dataset(dataset: xr.Dataset, *, output_path: Path) -> None:
    # Set up compression for all variables
    comp = {
        "zlib": True,
        "complevel": 5,
    }
    encoding = {var: comp for var in dataout.data_vars}

    dataout.to_netcdf(
        output_path,
        mode="w",
        format="NETCDF4",
        encoding=encoding,
    )
    return
