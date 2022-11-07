# Development

## Running

Start the job scheduler with the below command (omit `-b` if you don't need to build the
image):

```
./scripts/dev/up.sh -b
```

Restart the job scheduler with (omit `-b` if you don't need to build the image):

```
./scripts/dev/recreate.sh -b
```


### Submitting jobs to scheduler

```
./scripts/container_cli.sh --help
```


### Debugging

Ensure the number of workers is set to 1 so attaching to a debugger in the container is
easy (simply trigger a `breakpoint()` in your code).

To get a shell prompt within the container:

```
./scripts/container_prompt.sh
```


## Using tooling outside Docker

This software runs in Docker, but you may want to have dependencies on your host for
e.g. running tests. To install dependencies to a new conda environment:

```
conda env create
conda activate sipn-reanalysis-ingest
```

To list available tooling:

```
invoke --list
```

...or use the shorter `inv` alias:

```
inv --list
```


### Changing dependencies

It's critical to update the lockfile every time dependencies are changed. Whenever you
update the `environment.yml`, please update the lockfile with:

```
inv env.lock
```


### Formatting

Format the code with:

```
inv format
```


### Static analysis and tests

Run all tests, including static anlysis with flake8 and mypy, with:

```
inv test
```


## TODO

* Settle on a consistent logging mechanism.
* Improve cleanup code. Once a group of `Grib2ToNc` jobs depending on the same input
  tar is complete, then all contents of that tar should be cleaned up. Currently, if
  e.g. 1 day is requested, then only 1 day of GRIB2 files will be cleaned up, and 4 will
  be remaining on disk.
