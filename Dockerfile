# Use Ubuntu 18.04 as the base image
FROM ubuntu:18.04

LABEL org.opencontainers.image.source="https://github.com/spark-hydro/SWAT-MODFLOW3"

# Install build tools
RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y gfortran make build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy repository
COPY . /app

# Build SMRT modules first
WORKDIR /app/src
RUN make clean && make

# Default command
CMD ["/bin/bash"]
