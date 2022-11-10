<img alt="NSIDC logo" src="https://nsidc.org/themes/custom/nsidc/logo.svg" width="150" />


# SIPN Reanalysis Ingest

SIPN Reanalysis Ingest enables NSIDC operators to ingest data supporting the [SIPN
Reanalysis Plots program](https://github.com/nsidc/sipn-reanalysis-plots/).


## Level of Support

* This repository is not actively supported by NSIDC but we welcome issue submissions and
  pull requests in order to foster community contribution.

See the [LICENSE](LICENSE) for details on permissions and warranties. Please contact
nsidc@nsidc.org for more information.


## Requirements

Docker + docker-compose

_OR_

Python + Conda


## Installation

Install a pre-built image from DockerHub (TODO: Add a link here after first release):

```
docker pull nsidc/sipn-reanalysis-ingest
```

See [development documentation](doc/development.md) to learn how to build from source.


## Usage

*Before continuing*: Ensure the correct [environment variables](doc/envvars.md) are
populated.

For development usage, see [development documentation](doc/development.md).


### With Docker

Start the task scheduler service:

```
./scripts/container_start.sh
```

Submit a job:

```
./scripts/container_cli.sh --help
```


### Without Docker

```
PYTHONPATH=. python sipn_reanalysis_ingest/cli.py
```


## Troubleshooting

TODO


## License

See [LICENSE](LICENSE).


## Code of Conduct

See [Code of Conduct](CODE_OF_CONDUCT.md).


## Credit

This software was developed by the National Snow and Ice Data Center with funding from
multiple sources.
