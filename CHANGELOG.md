# v1.0.4 (2023-02-17)

* Bugfix: Populate the HGT variable correctly
* Handle transition from 5-daily to daily data on April 1, 2011
    * For exactly April 1, download a daily AND 5-daily file (because we need one
      6-hourly forecast file from the previous day)
    * For dates after April 1, download daily data files instead of 5-daily data files.


# v1.0.3 (2023-02-15)

* Update restart policy to tolerate host reboots


# v1.0.2 (2023-01-25)

* Bugfix: Check if `_FillValue` attr exists on dataset before attempting to delete it


# v1.0.1 (2023-01-20)

* Ensure all output variables use NaN as fill value


# v1.0.0 (2023-01-19)

* Initial release
