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

To list available tooling shortcuts:

```
invoke --list
```

...or use the shorter `inv` alias:

```
inv --list
```


### Typechecking and tests

Run all tests, including typechecking with mypy, with:

```
inv test
```


### Changing dependencies

It's critical to update the lockfile every time dependencies are changed. Whenever you
update the `environment.yml`, please update the lockfile with:

```
conda-lock -p linux-64 -p osx-64
```


### Formatting and linting

Linting and formatting are done automatically with `pre-commit`. To configure it:

```
pre-commit install
```

After running this command, linting and formatting will occur automatically at
commit-time.

To manually trigger linting and formatting:

```
pre-commit run --all-files
```


## TODO

* Settle on a consistent logging mechanism.
* Create constant for grid dimensions (517, 511) and replace all magic numbers.
