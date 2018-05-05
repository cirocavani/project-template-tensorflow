#!/bin/bash
set -eu

cd $(dirname "$0")/..

source conf/env.sh

mkdir -p .cache

echo "Installing..."

CONDA_PKG=Miniconda3-4.5.1-Linux-x86_64.sh

if [ ! -f .cache/$CONDA_PKG ]; then
    curl -k -L \
        https://repo.continuum.io/miniconda/$CONDA_PKG \
        -o .cache/$CONDA_PKG
fi

rm -rf $CONDA_HOME
rm -rf $JUPYTER_DATA_DIR
mkdir -p $JUPYTER_DATA_DIR

bash .cache/$CONDA_PKG -b -f -p $CONDA_HOME

$CONDA_HOME/bin/conda update -q -y conda
$CONDA_HOME/bin/conda update -q -y --all
$CONDA_HOME/bin/conda env update -q -n base -f setup/environment.yml

echo "Install done!"
