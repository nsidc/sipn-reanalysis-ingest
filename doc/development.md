# Development

## Install dependencies

To install dependencies to a new conda environment:

```
conda env create
```

Whenever you update the `environment.yml`, please update the lockfile with:

```
inv env.lock
```


## Formatting

Format the code with:

```
inv format
```


## Static analysis

Run static analysis with:

```
inv test
```
