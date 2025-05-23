###############################################
# BASE IMAGE
###############################################
# Use Python 3.12 as the base image
FROM python:3.12-slim

###############################################
# WORKING DIRECTORY
###############################################
# Set working directory, the repo should always be cloned into /app
# DO NOT MODIFY THIS SECTIONs
RUN mkdir /app
WORKDIR /app

###############################################
# SYSTEM DEPENDENCIES
###############################################
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    bash \
    make \
    zip \
    build-essential \
    python3 \
    python3-pip \
    python3-setuptools \
    python-is-python3 \
    && rm -rf /var/lib/apt/lists/*

###############################################
# REPO SETUP
###############################################
# Clone repository
RUN git clone https://github.com/ni/nimi-python .
# RUN git submodule update --init --recursive

# Freeze the repository to a reproducible state.
# Use one of the two approaches below depending on the task version:

# - If the task version is "latest" or there is no specified version, freeze to the latest commit before a given date:
RUN LATEST_COMMIT=$(git rev-list -n 1 --before="2025-05-22" HEAD) && git reset --hard $LATEST_COMMIT

# - If the task version is NOT "latest" (e.g., a specific commit hash), pin to a specific commit explicitly (use this only when needed):
# RUN git checkout <commit-sha-or-tag>


###############################################
# PROJECT DEPENDENCIES AND CONFIGURATION
###############################################
COPY ./build.sh /build.sh
RUN chmod +x /build.sh
RUN /build.sh

###############################################
# ENTRYPOINT / CMD
###############################################
# ENTRYPOINT should always be /bin/bash,. If the build and test commands are set as CMD or ENTRYPOINT, convert them to RUN commands and move them to the previous sections
ENTRYPOINT ["/bin/bash"]
