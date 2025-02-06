for the libsodium

./autogen.sh -s
automake

mkdir builddir 
cd builddir 
../configure CFLAGS="-DDEV_MODE -O3 -DAVX2_ONLY" CPPFLAGS="-DDEV_MODE -O3 -DAVX2_ONLY" --prefix=$(HOME) 


-DAVX2_ONLY tests AVX2 
-DSSSE3_ONLY tests SSSE3 
-DSSE41_ONLY tests SSE41
-DNEON_ONLY tests NEON
nothing for ref

make && make check 
make install 

cd ./scripts_bench_neon
make all 
make run_benchmarks



