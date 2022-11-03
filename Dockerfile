FROM mambaorg/micromamba:1.0

# Activate the conda environment during build process
ARG MAMBA_DOCKERFILE_ACTIVATE=1

# Custom user to ensure outputs have correct UID. copied from docs:
# https://github.com/mamba-org/micromamba-docker#changing-the-user-id-or-name
ARG NEW_MAMBA_USER=app
ARG NEW_MAMBA_USER_ID=1000
ARG NEW_MAMBA_USER_GID=1000
USER root
RUN usermod "--login=${NEW_MAMBA_USER}" "--home=/home/${NEW_MAMBA_USER}" \
    --move-home "-u ${NEW_MAMBA_USER_ID}" "${MAMBA_USER}" \
    || ( \
      echo ""; \
      echo ">>> ERROR: Are you doing a development build? If so, run \`./scripts/build_dev.sh\`!"; \
      echo ""; \
      exit 1; \
    ) \
    && groupmod "--new-name=${NEW_MAMBA_USER}" \
    "-g ${NEW_MAMBA_USER_GID}" "${MAMBA_USER}" \
    # Update the expected value of MAMBA_USER for the
    # _entrypoint.sh consistency check.
    && echo "${NEW_MAMBA_USER}" > "/etc/arg_mamba_user" \
    && :
ENV MAMBA_USER=$NEW_MAMBA_USER

WORKDIR /app

# NOTE: For some reason, micromamba doesn't like the filename
# "environment-lock.yml". It fails to parse it because it's missing some
# special lockfile key.
COPY environment-lock.yml ./environment.yml

# Install dependencies to conda environment
RUN micromamba install -y \
    # NOTE: -p is important to install to the "base" env
    -p /opt/conda \
    -f environment.yml
RUN micromamba clean --all --yes

# Install source
COPY ./setup.py .
COPY ./pyproject.toml .
COPY ./luigi.toml .
COPY ./.mypy.ini .
COPY ./logging.conf .
COPY ./tasks ./tasks
COPY ./sipn_reanalysis_ingest ./sipn_reanalysis_ingest

# Set up `sipn-reanalysis-ingest` CLI command
RUN pip install --no-deps -e .

USER $MAMBA_USER

# Did the environment setup work?
RUN python -c "import sipn_reanalysis_ingest"
RUN which sipn-reanalysis-ingest

# NOTE: Default entrypoint is `ENTRYPOINT ["/usr/local/bin/_entrypoint.sh"]`.
#       Do not override, or env will not correctly activate.
