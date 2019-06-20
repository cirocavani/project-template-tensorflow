#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..

source conf/env.sh

mkdir -p .cache

echo "Installing..."

CONDA_PKG=Miniconda3-4.6.14-Linux-x86_64.sh
CONDA_URL=https://repo.anaconda.com/miniconda/$CONDA_PKG

if [ ! -f .cache/$CONDA_PKG ]; then
    curl -k -L -o .cache/$CONDA_PKG $CONDA_URL
fi

rm -rf $CONDA_INSTDIR
rm -rf $JUPYTER_DATA_DIR
mkdir -p $JUPYTER_DATA_DIR

bash .cache/$CONDA_PKG -b -f -p $CONDA_INSTDIR

$CONDA_INSTDIR/bin/conda update -q -y conda
$CONDA_INSTDIR/bin/conda update -q -y --all
$CONDA_INSTDIR/bin/conda env update -q -n base -f setup/environment.yml

echo "Install done!"
