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

#ifndef blake2b_load_neon_H
#define blake2b_load_neon_H

//#define M_LO_LO(i, j) vcombine_u64(vget_low_u64(m ##i ), vget_low_u64(m ##j ))
#define M_LO_LO(i, j) vzip1q_u64(m ##i, m ##j)
#define M_LO_HI(i, j) vcombine_u64(vget_low_u64(m ##i ), vget_high_u64(m ##j ))
//#define M_HI_HI(i, j) vcombine_u64(vget_high_u64(m ##i ), vget_high_u64(m ##j ))
#define M_HI_HI(i, j) vzip2q_u64(m ##i, m ##j)

#define LOAD_MSG_0_1(b0, b1)                                         \
    do {                                                             \
        b0 = m0_lo_m1_lo; \
        b1 = m2_lo_m3_lo; \
    } while(0)

#define LOAD_MSG_0_2(b0, b1)                                         \
    do {                                                             \
        b0 = m0_hi_m1_hi; \
        b1 = m2_hi_m3_hi; \
    } while(0)

#define LOAD_MSG_0_3(b0, b1)                                         \
    do {                                                             \
        b0 = m4_lo_m5_lo;       \
        b1 = m6_lo_m7_lo;       \
    } while(0)

#define LOAD_MSG_0_4(b0, b1)                                         \
    do {                                                             \
        b0 = m4_hi_m5_hi;     \
        b1 = m6_hi_m7_hi;     \
    } while(0)

#define LOAD_MSG_1_1(b0, b1)                                         \
    do {                                                             \
        b0 = m7_lo_m2_lo;       \
        b1 = m4_hi_m6_hi;     \
    } while(0)

#define LOAD_MSG_1_2(b0, b1)                                         \
    do {                                                             \
        b0 = m5_lo_m4_lo;       \
        b1 = vextq_u64(m7, m3, 1);                                   \
    } while(0)

#define LOAD_MSG_1_3(b0, b1)                                         \
    do {                                                             \
        b0 = vextq_u64(m0, m0, 1);                                   \
        b1 = m5_hi_m2_hi;     \
    } while(0)

#define LOAD_MSG_1_4(b0, b1)                                         \
    do {                                                             \
      b0 = m6_lo_m1_lo;         \
      b1 = m3_hi_m1_hi;       \
    } while(0)

#define LOAD_MSG_2_1(b0, b1)                                         \
    do {                                                             \
        b0 = vextq_u64(m5, m6, 1);                                   \
        b1 = m2_hi_m7_hi;     \
    } while(0)

#define LOAD_MSG_2_2(b0, b1)                                         \
    do {                                                             \
        b0 = m4_lo_m0_lo;       \
        b1 = m1_lo_m6_hi;      \
    } while(0)

#define LOAD_MSG_2_3(b0, b1)                                         \
    do {                                                             \
        b0 = m5_lo_m1_hi;      \
        b1 = m3_hi_m4_hi;     \
    } while(0)

#define LOAD_MSG_2_4(b0, b1)                                         \
    do {                                                             \
        b0 = m7_lo_m3_lo;       \
        b1 = vextq_u64(m0, m2, 1);                                   \
    } while(0)

#define LOAD_MSG_3_1(b0, b1)                                         \
    do {                                                             \
        b0 = m3_hi_m1_hi;     \
        b1 = m6_hi_m5_hi;     \
    } while(0)

#define LOAD_MSG_3_2(b0, b1)                                         \
    do {                                                             \
        b0 = m4_hi_m0_hi;     \
        b1 = m6_lo_m7_lo;       \
    } while(0)

#define LOAD_MSG_3_3(b0, b1)                                         \
    do {                                                             \
        b0 = m1_lo_m2_hi;      \
        b1 = m2_lo_m7_hi;      \
    } while(0)

#define LOAD_MSG_3_4(b0, b1)                                         \
    do {                                                             \
        b0 = m3_lo_m5_lo;       \
        b1 = m0_lo_m4_lo;       \
    } while(0)

#define LOAD_MSG_4_1(b0, b1)                                         \
    do {                                                             \
        b0 = m4_hi_m2_hi;     \
        b1 = m1_lo_m5_lo;       \
    } while(0)

#define LOAD_MSG_4_2(b0, b1)                                         \
    do {                                                             \
        b0 = m0_lo_m3_hi;      \
        b1 = m2_lo_m7_hi;      \
    } while(0)

#define LOAD_MSG_4_3(b0, b1)                                         \
    do {                                                             \
        b0 = m7_lo_m5_hi;      \
        b1 = m3_lo_m1_hi;      \
    } while(0)

#define LOAD_MSG_4_4(b0, b1)                                         \
    do {                                                             \
        b0 = vextq_u64(m0, m6, 1);                                   \
        b1 = m4_lo_m6_hi;      \
    } while(0)

#define LOAD_MSG_5_1(b0, b1)                                         \
    do {                                                             \
        b0 = m1_lo_m3_lo;       \
        b1 = m0_lo_m4_lo;       \
    } while(0)

#define LOAD_MSG_5_2(b0, b1)                                         \
    do {                                                             \
        b0 = m6_lo_m5_lo;       \
        b1 = m5_hi_m1_hi;     \
    } while(0)

#define LOAD_MSG_5_3(b0, b1)                                         \
    do {                                                             \
        b0 = m2_lo_m3_hi;      \
        b1 = m7_hi_m0_hi;     \
    } while(0)

#define LOAD_MSG_5_4(b0, b1)                                         \
    do {                                                             \
        b0 = m6_hi_m2_hi;     \
        b1 = m7_lo_m4_hi;      \
    } while(0)

#define LOAD_MSG_6_1(b0, b1)                                         \
    do {                                                             \
        b0 = m6_lo_m0_hi;      \
        b1 = m7_lo_m2_lo;       \
    } while(0)

#define LOAD_MSG_6_2(b0, b1)                                         \
    do {                                                             \
        b0 = m2_hi_m7_hi;     \
        b1 = vextq_u64(m6, m5, 1);                                   \
    } while(0)

#define LOAD_MSG_6_3(b0, b1)                                         \
    do {                                                             \
        b0 = m0_lo_m3_lo;       \
        b1 = vextq_u64(m4, m4, 1);                                   \
    } while(0)

#define LOAD_MSG_6_4(b0, b1)                                         \
    do {                                                             \
        b0 = m3_hi_m1_hi;     \
        b1 = m1_lo_m5_hi;      \
    } while(0)

#define LOAD_MSG_7_1(b0, b1)                                         \
    do {                                                             \
        b0 = m6_hi_m3_hi;     \
        b1 = m6_lo_m1_hi;      \
    } while(0)

#define LOAD_MSG_7_2(b0, b1)                                         \
    do {                                                             \
        b0 = vextq_u64(m5, m7, 1);                                   \
        b1 = m0_hi_m4_hi;     \
    } while(0)

#define LOAD_MSG_7_3(b0, b1)                                         \
    do {                                                             \
        b0 = m2_hi_m7_hi;     \
        b1 = m4_lo_m1_lo;       \
    } while(0)

#define LOAD_MSG_7_4(b0, b1)                                         \
    do {                                                             \
        b0 = m0_lo_m2_lo;       \
        b1 = m3_lo_m5_lo;       \
    } while(0)

#define LOAD_MSG_8_1(b0, b1)                                         \
    do {                                                             \
        b0 = m3_lo_m7_lo;       \
        b1 = vextq_u64(m5, m0, 1);                                   \
    } while(0)

#define LOAD_MSG_8_2(b0, b1)                                         \
    do {                                                             \
        b0 = m7_hi_m4_hi;     \
        b1 = vextq_u64(m1, m4, 1);                                   \
    } while(0)

#define LOAD_MSG_8_3(b0, b1)                                         \
    do {                                                             \
        b0 = m6;                                                     \
        b1 = vextq_u64(m0, m5, 1);                                   \
    } while(0)

#define LOAD_MSG_8_4(b0, b1)                                         \
    do {                                                             \
        b0 = m1_lo_m3_hi;      \
        b1 = m2;                                                     \
    } while(0)

#define LOAD_MSG_9_1(b0, b1)                                         \
    do {                                                             \
        b0 = m5_lo_m4_lo;       \
        b1 = m3_hi_m0_hi;     \
    } while(0)

#define LOAD_MSG_9_2(b0, b1)                                         \
    do {                                                             \
        b0 = m1_lo_m2_lo;       \
        b1 = m3_lo_m2_hi;      \
    } while(0)

#define LOAD_MSG_9_3(b0, b1)                                         \
    do {                                                             \
        b0 = m7_hi_m4_hi;     \
        b1 = m1_hi_m6_hi;     \
    } while(0)

#define LOAD_MSG_9_4(b0, b1)                                         \
    do {                                                             \
        b0 = vextq_u64(m5, m7, 1);                                   \
        b1 = m6_lo_m0_lo;       \
    } while(0)

#endif
