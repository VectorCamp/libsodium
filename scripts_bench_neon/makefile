CC=gcc

CFLAGS=-O3 -Wall -Wextra
# CFLAGS=-O3 -march=native -Wall -Wextra
# # CFLAGS=-O3 -mcpu=neoverse-n1 -Wall -Wextra
# CFLAGS=-O3  -mavx2  -Wall -Wextra
# CFLAGS=-O3  -mssse3 -Wall -Wextra
# CFLAGS=-O3  -msse4.1 -Wall -Wextra
LIBS=-lsodium
INCLUDE_DIR=$(HOME)/include
LIB_DIR=$(HOME)/lib

# Target for generating the executable
all: build_cycles \
	 build_throughput_timeperhash
build_cycles: benchmark_cycles.c
	$(CC) benchmark_cycles.c $(CFLAGS) -I$(INCLUDE_DIR) -L$(LIB_DIR) $(LIBS) -o benchmark_cycles

run_cycles:
	sudo LD_LIBRARY_PATH=$(HOME)/lib ./benchmark_cycles > benchmark_cycles.data
#benchmark_throughput_timeperhash
build_throughput_timeperhash: benchmark_throughput_timeperhash.c
	gcc -o benchmark_throughput_timeperhash benchmark_throughput_timeperhash.c -I $(HOME)/include -L $(HOME)/lib -lsodium
run_throughput_timeperhash:
	LD_LIBRARY_PATH=$(HOME)/lib ./benchmark_throughput_timeperhash

run_benchmarks: run_cycles \
	        run_throughput_timeperhash
	
# Clean up generated files
clean:
	rm -f benchmark_cycles benchmark_cycles.data benchmark_throughput_timeperhash benchmark_throughput_timeperhash.data
