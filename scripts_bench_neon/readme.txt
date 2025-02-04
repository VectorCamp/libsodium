for the libsodium

./autogen.sh -s
./configure

replace with the one in scripts_bench_neon
libsodium/scripts_bench_neon/Makefile.in -> libsodium/src/libsodium/Makefile.in for neon patch

and remember to change the blake2b_ref in libsodium/src/libsodium/crypto_generichash/blake2b/ref/blake2b-ref.c to neon or reference

make && make check
sudo make install 

#benchmark_throughput
gcc -o benchmark benchmark.c -I /include -L /lib -lsodium && ./benchmark

#bench
make bench
sudo ./generichash_bench > generichashData.data