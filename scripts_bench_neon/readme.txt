for the libsodium

./autogen.sh -s
automake
mkdir builddir
cd builddir
../configure CFLAGS="-DDEV_MODE" CPPFLAGS="-DDEV_MODE" --prefix=$HOME

make && make check

#benchmark_throughput
gcc -o benchmark benchmark.c -I $HOME/include -L $HOME/lib -lsodium
LD_LIBRARY_PATH=$HOME/lib ./benchmark

#bench
make bench
sudo LD_LIBRARY_PATH=$HOME/lib ./generichash_bench > generichash_bench.data
