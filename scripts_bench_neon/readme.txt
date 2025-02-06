for the libsodium

./autogen.sh -s
automake

mkdir builddir 
cd builddir 
../configure CFLAGS="-DDEV_MODE" CPPFLAGS="-DDEV_MODE -O3 -DAVX2_ONLY" --prefix=$(HOME) 

(-DAVX2_ONLY or -DSSSE3_ONLY or -DSSE41_ONLY or -DNEON_ONLY nothing for ref)
make && make check 
make install 

cd ./scripts_bench_neon
make all 
make run_benchmarks



