HERE=$(dirname ${BASH_SOURCE})

if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    echo "script ${BASH_SOURCE[0]} is not meant to be sourced."
    return
fi

if [ $(rpm -qa|grep -c libzstd-devel) -eq 0 ]; then
    echo "Installing libzstd-devel"
    sudo yum install libzstd-devel
fi


source ${HERE}/env.sh

set -e
# -- Avro
wget http://apache.mirrors.hoobly.com/avro/avro-1.9.2/cpp/avro-cpp-1.9.2.tar.gz
tar -xf avro-cpp-1.9.2.tar.gz
mkdir avro-cpp-1.9.2/build
cd avro-cpp-1.9.2/build
cmake .. -DCMAKE_INSTALL_PREFIX=${TOP} -DBoost_NO_BOOST_CMAKE=ON
make -j$(nproc) install
# Check that avro is in path
command -v avrogencpp

# -- python venv
python -m venv ${TOP}/venv
source ${TOP}/venv/bin/activate
pip install -U pip
git clone https://github.com/brettviren/moo.git
cd moo/
pip install -e .
cd ..
moo
mkdir -p ${TOP}/include/nlohmann
wget -O ${TOP}/include/nlohmann/json.hpp https://github.com/nlohmann/json/releases/download/v3.8.0/json.hpp
wget -O ${TOP}/bin/waf https://waf.io/waf-2.0.20
chmod +x ${TOP}/bin/waf
waf --version
cd $TOP
git clone https://github.com/brettviren/cogs.git
cd cogs
waf --help
waf configure --prefix=$TOP --with-ers=$ERS_FQ_DIR --with-boost=$BOOST_FQ_DIR --with-nljs=$TOP --with-avro=$TOP
waf install
cd ..

