#!/bin/bash
set -eu

cd $(dirname "$0")

source conf/env.sh

mkdir -p .cache

echo "Setup..."

if [ ! -f .cache/Miniconda3-4.3.21-Linux-x86_64.sh ]; then
    curl -k -L \
        https://repo.continuum.io/miniconda/Miniconda3-4.3.21-Linux-x86_64.sh \
        -o .cache/Miniconda3-4.3.21-Linux-x86_64.sh
fi
rm -rf $CONDA_HOME
bash .cache/Miniconda3-4.3.21-Linux-x86_64.sh -b -f -p $CONDA_HOME

$CONDA_HOME/bin/conda update -y --all
$CONDA_HOME/bin/conda install -y jupyter
$CONDA_HOME/bin/pip install tensorflow

rm -rf $JUPYTER_DATA_DIR
mkdir -p $JUPYTER_DATA_DIR

echo "Setup done."
