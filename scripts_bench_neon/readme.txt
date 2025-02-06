for the libsodium

cd libsodium
mkdir builddir
cd scripts_bench_neon

make libsodium_avx2 (or neon or ssse3 or sse4.1 make lib and runs benchmarks)
