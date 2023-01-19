# Operations

To run a scheduled ingest, first the application must be deployed using the
`deploy/deploy` script.

On the deployed system, run `./scripts/container_cli.sh` to connect to the container and
submit jobs to the running container.

First, the `run` command will ingest data into the `wip` folder, then the `promote`
command will promote that data to the final storage location.

_NOTE_: Intermittent failures may occur, seemingly at random. All the ones we've
encountered can be resolved by re-running the `run` step, which will pick up where it
left off.


## Daily

Example - ingest 1980:

```
./scripts/container_cli.sh run daily -s 1980-01-01 -e 1980-12-31
./scripts/container_cli.sh promote daily
```


## Monthly

Example - ingest 1980:

```
./scripts/container_cli.sh run monthly -s 1980-01 -e 1980-12
./scripts/container_cli.sh promote monthly
```
