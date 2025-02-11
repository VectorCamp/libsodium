/*
   BLAKE2 reference source code package - reference C implementations

   Copyright 2012, Samuel Neves <sneves@dei.uc.pt>.  You may use this under the
   terms of the CC0, the OpenSSL Licence, or the Apache Public License 2.0, at
   your option.  The terms of these licenses can be found at:

   - CC0 1.0 Universal : http://creativecommons.org/publicdomain/zero/1.0
   - OpenSSL license   : https://www.openssl.org/source/license.html
   - Apache 2.0        : http://www.apache.org/licenses/LICENSE-2.0

   More information about the BLAKE2 hash function can be found at
   https://blake2.net.
*/

#include <stdint.h>
#include <string.h>

#include "blake2.h"
#include "private/common.h"

#if defined(__aarch64__)

# include <arm_neon.h>

# include "blake2b-compress-neon.h"

CRYPTO_ALIGN(64)
static const uint64_t blake2b_IV[8] = {
    0x6a09e667f3bcc908ULL, 0xbb67ae8584caa73bULL, 0x3c6ef372fe94f82bULL,
    0xa54ff53a5f1d36f1ULL, 0x510e527fade682d1ULL, 0x9b05688c2b3e6c1fULL,
    0x1f83d9abfb41bd6bULL, 0x5be0cd19137e2179ULL
};

static const uint8_t r16_data[] = {2, 3, 4, 5, 6, 7, 0, 1, 10, 11, 12, 13, 14, 15, 8, 9};
static const uint8_t r24_data[] = {3, 4, 5, 6, 7, 0, 1, 2, 11, 12, 13, 14, 15, 8, 9, 10};

int
blake2b_compress_neon(blake2b_state *S,
                      const uint8_t  block[BLAKE2B_BLOCKBYTES])
{
    uint64x2_t    row1l, row1h;
    uint64x2_t    row2l, row2h;
    uint64x2_t    row3l, row3h;
    uint64x2_t    row4l, row4h;
    uint64x2_t    b0, b1;
    uint64x2_t    t0, t1, t2, t3;
    const uint8x16_t r16 = vld1q_u8(r16_data);
    const uint8x16_t r24 = vld1q_u8(r24_data);

    __asm__("load_m0_7_label:;"::);
    const uint64x2_t m0 = vreinterpretq_u64_u8(vld1q_u8(block + 00));
    const uint64x2_t m1 = vreinterpretq_u64_u8(vld1q_u8(block + 16));
    const uint64x2_t m2 = vreinterpretq_u64_u8(vld1q_u8(block + 32));
    const uint64x2_t m3 = vreinterpretq_u64_u8(vld1q_u8(block + 48));
    const uint64x2_t m4 = vreinterpretq_u64_u8(vld1q_u8(block + 64));
    const uint64x2_t m5 = vreinterpretq_u64_u8(vld1q_u8(block + 80));
    const uint64x2_t m6 = vreinterpretq_u64_u8(vld1q_u8(block + 96));
    const uint64x2_t m7 = vreinterpretq_u64_u8(vld1q_u8(block + 112));

    __asm__("load_row12_label:;"::);
    const uint64x2_t h0 = row1l = vld1q_u64(&S->h[0]);
    const uint64x2_t h1 = row1h = vld1q_u64(&S->h[2]);
    const uint64x2_t h2 = row2l = vld1q_u64(&S->h[4]);
    const uint64x2_t h3 = row2h = vld1q_u64(&S->h[6]);

    __asm__("load_row34_label:;"::);
    row3l = vld1q_u64(&blake2b_IV[0]);
    row3h = vld1q_u64(&blake2b_IV[2]);
    row4l = veorq_u64(vld1q_u64(&blake2b_IV[4]), vld1q_u64(&S->t[0]));
    row4h = veorq_u64(vld1q_u64(&blake2b_IV[6]), vld1q_u64(&S->f[0]));

    __asm__("round0_label:;"::);
    ROUND(0);

    __asm__("round1_label:;"::);
    ROUND(1);

    __asm__("round2_label:;"::);
    ROUND(2);

    __asm__("round3_label:;"::);
    ROUND(3);

    __asm__("round4_label:;"::);
    ROUND(4);

    __asm__("round5_label:;"::);
    ROUND(5);

    __asm__("round6_label:;"::);
    ROUND(6);

    __asm__("round7_label:;"::);
    ROUND(7);

    __asm__("round8_label:;"::);
    ROUND(8);

    __asm__("round9_label:;"::);
    ROUND(9);

    __asm__("round10_label:;"::);
    ROUND(0); // Round 10 is identical to Round 0
    __asm__("round11_label:;"::);
    ROUND(1); // Round 11 is identical to Round 1

    __asm__("store_label:;"::);
    vst1q_u64(&S->h[0], veorq_u64(h0, veorq_u64(row1l, row3l)));
    vst1q_u64(&S->h[2], veorq_u64(h1, veorq_u64(row1h, row3h)));
    vst1q_u64(&S->h[4], veorq_u64(h2, veorq_u64(row2l, row4l)));
    vst1q_u64(&S->h[6], veorq_u64(h3, veorq_u64(row2h, row4h)));
    return 0;
}

#endif
