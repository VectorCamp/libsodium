#include <sodium.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Function to run a single benchmark and save results
void run_benchmark(FILE *fp, const char *description, size_t message_len, size_t hash_len, int iterations) {
    unsigned char *message = malloc(message_len);
    unsigned char *hash = malloc(hash_len);

    if (!message || !hash) {
        printf("Memory allocation failed!\n");
        free(message);
        free(hash);
        return;
    }

    randombytes_buf(message, message_len);

    // Start timing
    clock_t start = clock();
    for (int i = 0; i < iterations; i++) {
        crypto_generichash(hash, hash_len, message, message_len, NULL, 0);
    }
    clock_t end = clock();

    double cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
    double time_per_hash = (cpu_time_used * 1e6) / iterations; // µs per hash
    double total_data_processed = (double)(message_len * iterations) / (1024 * 1024); // Convert to MB
    double throughput = total_data_processed / cpu_time_used; // MB per second

    // Print results to console
    printf("Benchmark: %s\n", description);
    printf("  Message size: %zu bytes\n", message_len);
    printf("  Hash length: %zu bytes\n", hash_len);
    printf("  Iterations: %d\n", iterations);
    printf("  Total time: %.6f seconds\n", cpu_time_used);
    printf("  Time per hash: %.6f microseconds\n", time_per_hash);
    printf("  Throughput: %.2f MB/s\n\n", throughput);

    // Save data for Gnuplot (Format: message_len time_per_hash throughput)
    fprintf(fp, "%zu %.6f %.2f\n", message_len, time_per_hash, throughput);

    free(message);
    free(hash);
}

int main() {
    if (sodium_init() < 0) {
        printf("Libsodium initialization failed!\n");
        return 1;
    }

    FILE *fp = fopen("benchmark_results.data", "w");
    if (!fp) {
        printf("Error opening file for writing!\n");
        return 1;
    }

    // Define power-of-2 message sizes for benchmarking
    size_t sizes[] = {
        16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192,
        16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304,
        8388608, 16777216
    };
    
    int num_sizes = sizeof(sizes) / sizeof(sizes[0]);

    // Adjust iterations to balance test duration for different message sizes
    int iterations[num_sizes];
    for (int i = 0; i < num_sizes; i++) {
        if (sizes[i] < 1024)
            iterations[i] = 200000;
        else if (sizes[i] < 65536)
            iterations[i] = 50000;
        else if (sizes[i] < 1048576)
            iterations[i] = 10000;
        else if (sizes[i] < 8388608)
            iterations[i] = 1000;
        else
            iterations[i] = 100;
    }

    for (int i = 0; i < num_sizes; i++) {
        char desc[100];
        snprintf(desc, sizeof(desc), "Message size: %zu bytes", sizes[i]);
        run_benchmark(fp, desc, sizes[i], crypto_generichash_BYTES, iterations[i]);
    }

    fclose(fp);
    return 0;
}