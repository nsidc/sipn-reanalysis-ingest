# Operations

To run a scheduled ingest, first the application must be deployed using the
`deploy/deploy` script.

On the deployed system, run `./scripts/container_cli.sh` to connect to the container and
submit jobs to the running container.

First, the `run` command will ingest data into the `wip` folder, then the `promote`
command will promote that data to the final storage location.

_NOTE_: Intermittent failures may occur, seemingly at random (see issue #29). All the
ones we've encountered can be resolved by re-running the `run` step, which will pick up
where it left off.


## Daily

Example - ingest 1980:

```
./scripts/container_cli.sh run daily -s 1980-01-01 -e 1980-12-31
./scripts/container_cli.sh promote daily
```


### Forward processing

Daily input data becomes available in 5-day batches. The batches always start on the
1st, 6th, 11th, 16th, 21st, 26th, and 31st (for 31-day months). e.g., for January,
`01-01` to `01-05`, `01-06` to `01-10`, ..., `01-26` to `01-30`, and `01-31` to `01-31`.

The input data becomes available the day after the end date of the batch, e.g. the
`01-01` to `01-05` batch arrives on `01-06`. TODO: is this correct?


## Monthly

Example - ingest 1980:

```
./scripts/container_cli.sh run monthly -s 1980-01 -e 1980-12
./scripts/container_cli.sh promote monthly
```


### Forward processing

Monthly input data becomes available the day after the end of the month, e.g. the
January input file will be available on February 1st. TODO: Is this correct?
