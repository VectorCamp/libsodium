for the libsodium

./autogen.sh -s
automake

mkdir builddir 
cd builddir 

to enable arch-specific optimizations you need to enable one of the following, like

-DAVX2_ONLY tests AVX2 
-DSSSE3_ONLY tests SSSE3 
-DSSE41_ONLY tests SSE41
-DNEON_ONLY tests NEON
ommitting this will fallback to C implementation

AVX2 for example tests this
../configure CFLAGS="-DDEV_MODE -O3 -DAVX2_ONLY" CPPFLAGS="-DDEV_MODE -O3 -DAVX2_ONLY" --prefix=$HOME


make && make check 
make install 

cd ./scripts_bench_neon
make all

make run_benchmarks (makes 2 files one for throughtput,time per hash and one with the cycles per byte and total cycles)



