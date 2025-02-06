for the libsodium

./autogen.sh -s
automake

cd scripts_bench_neon
make libsodium_avx2 (or ssse3,sse41,neon, it runs the benchmarks too and deletes old data)


