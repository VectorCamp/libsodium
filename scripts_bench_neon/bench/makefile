CC=gcc
# # Use gnu99 to support inline asm
# CFLAGS=-O3 -march=native -mavx2 -Wall -Wextra -DSUPERCOP

# CFLAGS=-O3 -march=native -mssse3 -Wall -Wextra -DSUPERCOP
CFLAGS=-O3 -march=native -mcpu=neoverse-n1 -Wall -Wextra -DSUPERCOP

# CFLAGS=-O3 -Wall -Wextra -DSUPERCOP
LIBS=-lsodium
INCLUDE_DIR=$(HOME)/include
LIB_DIR=$(HOME)/lib
FILES=bench.c

# Target for generating the executable
all: bench

bench: $(FILES)
	$(CC) $(FILES) $(CFLAGS) -I$(INCLUDE_DIR) -L$(LIB_DIR) $(LIBS) -o generichash_bench

# Make the data files by running the benchmark programs
plot: bench
	./generichash_bench > generichash.data

# Clean up generated files
clean:
	rm -f generichash_bench generichash.data plotcycles.pdf
