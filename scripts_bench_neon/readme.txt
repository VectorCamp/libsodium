for the libsodium

./autogen.sh -s
automake
mkdir builddir
cd builddir
../configure CFLAGS="-DDEV_MODE" CPPFLAGS="-DDEV_MODE"

make && make check

#benchmark_throughput
gcc -o benchmark benchmark.c -I /include -L /lib -lsodium && ./benchmark

#bench
make bench
sudo ./generichash_bench > generichashData.data
