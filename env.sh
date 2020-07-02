
HERE=$(dirname ${BASH_SOURCE})
echo "Setting env variables"
export TOP=$(realpath "${HERE}/cogsbox")
export PATH=${TOP}/bin:$PATH
export LD_LIBRARY_PATH=${TOP}/lib:${TOP}/lib64:$LD_LIBRARY_PATH

echo "Setting uo UPS environment"
source /cvmfs/dune.opensciencegrid.org/dunedaq/DUNE/products/setup
setup ers v0_26_00 -q e19:prof
setup cmake v3_17_2
setup boost v1_70_0 -q e19:prof
export PRODUCTS=$PRODUCTS:/cvmfs/larsoft.opensciencegrid.org/products
setup python v3_7_2

echo "Activating VENV"
source ${TOP}/venv/bin/activate
