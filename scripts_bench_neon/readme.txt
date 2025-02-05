for the libsodium

./autogen.sh -s
automake
mkdir builddir
cd builddir
../configure CFLAGS="-DDEV_MODE" CPPFLAGS="-DDEV_MODE" --prefix=$HOME

make && make check

cd ./scripts_bench_neon
make all
make benchmarks
