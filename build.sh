#!/bin/sh
# Common Setup, DO NOT MODIFY
cd /app
set -e

###############################################
# PROJECT DEPENDENCIES AND CONFIGURATION
###############################################
# Install project dependencies
python -m pip install --upgrade pip
python -m pip install mako packaging grpcio-tools==1.59.0 build pytest pytest-timeout coverage numpy hightime grpcio==1.67.0 protobuf==5.27.2

###############################################
# BUILD
###############################################
echo "================= 0909 BUILD START 0909 ================="
./build.sh
echo "================= 0909 BUILD END 0909 ================="
