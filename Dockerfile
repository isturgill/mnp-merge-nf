# mnp-merge
# Version 1.0.0
# Minimal Docker image for Pixi and Sentieon merge_mnp.py
# Maintainer: Ian R. Sturgill <https://www.github.com/isturgill>

FROM ghcr.io/prefix-dev/pixi:0.76.2-jammy-cuda-13.0.0

WORKDIR /mnp

# Add Python and package dependencies
COPY pixi.toml pixi.lock ./
RUN pixi install --locked
RUN pixi clean cache --yes

# Add Sentieon merge_mnp scripts
COPY scripts /scripts

COPY Dockerfile /
