FROM mambaorg/micromamba:0.23.3

# Activate the conda environment during build process
ARG MAMBA_DOCKERFILE_ACTIVATE=1

# Custom user to ensure outputs have correct UID
# docs: https://github.com/mamba-org/micromamba-docker#changing-the-user-id-or-name
# ARG NEW_MAMBA_USER=app
# ARG NEW_MAMBA_USER_ID=1000
# ARG NEW_MAMBA_USER_GID=1000
# USER root
# RUN usermod "--login=${NEW_MAMBA_USER}" "--home=/home/${NEW_MAMBA_USER}" \
#         --move-home "-u ${NEW_MAMBA_USER_ID}" "${MAMBA_USER}" && \
#     groupmod "--new-name=${NEW_MAMBA_USER}" \
#              "-g ${NEW_MAMBA_USER_GID}" "${MAMBA_USER}" && \
#     # Update the expected value of MAMBA_USER for the
#     # _entrypoint.sh consistency check.
#     echo "${NEW_MAMBA_USER}" > "/etc/arg_mamba_user" && \
#     :
# ENV MAMBA_USER=$NEW_MAMBA_USER
# USER $MAMBA_USER

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

# Install the package from source
# TODO: Remove?
# RUN pip install --no-deps -e .

# Did the environment setup work?
# RUN python -c "import sipn_reanalysis_ingest"

# WARNING: _entrypoint.sh required for environment activation
ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "luigid"]
