# Development

## Running

Start the job scheduler with the below command. Omit `-b` if you don't need to build the
image:

```
./scripts/dev_up.sh -b
```

### Submitting jobs to scheduler

```
./scripts/container_cli.sh --help
```


## Using tooling outside Docker

This software runs in Docker, but You may want to have dependencies on your host for
e.g. running tests. To install dependencies to a new conda environment:

```
conda env create
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


### Static analysis

Run static analysis with:

```
inv test
```


## TODO

* Figure out how to handle users within container. How can we use the current user?
  * A build script passing in the correct ARG values?
* Settle on a consistent logging mechanism. Make luigi logger into a constant?
