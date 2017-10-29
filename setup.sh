#!/bin/bash
set -eu

cd $(dirname "$0")

source conf/env.sh

mkdir -p .cache

echo "Setup..."

CONDA_PKG=Miniconda3-4.3.30-Linux-x86_64.sh

if [ ! -f .cache/$CONDA_PKG ]; then
    curl -k -L \
        https://repo.continuum.io/miniconda/$CONDA_PKG \
        -o .cache/$CONDA_PKG
fi
rm -rf $CONDA_HOME
bash .cache/$CONDA_PKG -b -f -p $CONDA_HOME

$CONDA_HOME/bin/conda update -y conda
$CONDA_HOME/bin/conda update -y --all
$CONDA_HOME/bin/conda install -y jupyter
$CONDA_HOME/bin/pip install tensorflow

rm -rf $JUPYTER_DATA_DIR
mkdir -p $JUPYTER_DATA_DIR

echo "Setup done."
