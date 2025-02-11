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

#define M_LO_LO(i, j) vzip1q_u64(m ##i, m ##j)
#define M_LO_HI(i, j) vcombine_u64(vget_low_u64(m ##i ), vget_high_u64(m ##j ))
#define M_HI_HI(i, j) vzip2q_u64(m ##i, m ##j)

#define LOAD_MSG_0_1(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_LO(0, 1);                                          \
        b1 = M_LO_LO(2, 3);                                          \
    } while(0)

#define LOAD_MSG_0_2(b0, b1)                                         \
    do {                                                             \
        b0 = M_HI_HI(0, 1);                                          \
        b1 = M_HI_HI(2, 3);                                          \
    } while(0)

#define LOAD_MSG_0_3(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_LO(4, 5);                                          \
        b1 = M_LO_LO(6, 7);                                          \
    } while(0)

#define LOAD_MSG_0_4(b0, b1)                                         \
    do {                                                             \
        b0 = M_HI_HI(4, 5);                                          \
        b1 = M_HI_HI(6, 7);                                          \
    } while(0)

#define LOAD_MSG_1_1(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_LO(7, 2);                                          \
        b1 = M_HI_HI(4, 6);                                          \
    } while(0)

#define LOAD_MSG_1_2(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_LO(5, 4);                                          \
        b1 = vextq_u64(m7, m3, 1);                                   \
    } while(0)

#define LOAD_MSG_1_3(b0, b1)                                         \
    do {                                                             \
        b0 = vextq_u64(m0, m0, 1);                                   \
        b1 = M_HI_HI(5, 2);                                          \
    } while(0)

#define LOAD_MSG_1_4(b0, b1)                                         \
    do {                                                             \
      b0 = M_LO_LO(6, 1);                                            \
      b1 = M_HI_HI(3, 1);                                            \
    } while(0)

#define LOAD_MSG_2_1(b0, b1)                                         \
    do {                                                             \
        b0 = vextq_u64(m5, m6, 1);                                   \
        b1 = M_HI_HI(2, 7);                                          \
    } while(0)

#define LOAD_MSG_2_2(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_LO(4, 0);                                          \
        b1 = M_LO_HI(1, 6);                                          \
    } while(0)

#define LOAD_MSG_2_3(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_HI(5, 1);                                          \
        b1 = M_HI_HI(3, 4);                                          \
    } while(0)

#define LOAD_MSG_2_4(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_LO(7, 3);                                          \
        b1 = vextq_u64(m0, m2, 1);                                   \
    } while(0)

#define LOAD_MSG_3_1(b0, b1)                                         \
    do {                                                             \
        b0 = M_HI_HI(3, 1);                                          \
        b1 = M_HI_HI(6, 5);                                          \
    } while(0)

#define LOAD_MSG_3_2(b0, b1)                                         \
    do {                                                             \
        b0 = M_HI_HI(4, 0);                                          \
        b1 = M_LO_LO(6, 7);                                          \
    } while(0)

#define LOAD_MSG_3_3(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_HI(1, 2);                                          \
        b1 = M_LO_HI(2, 7);                                          \
    } while(0)

#define LOAD_MSG_3_4(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_LO(3, 5);                                          \
        b1 = M_LO_LO(0, 4);                                          \
    } while(0)

#define LOAD_MSG_4_1(b0, b1)                                         \
    do {                                                             \
        b0 = M_HI_HI(4, 2);                                          \
        b1 = M_LO_LO(1, 5);                                          \
    } while(0)

#define LOAD_MSG_4_2(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_HI(0, 3);                                          \
        b1 = M_LO_HI(2, 7);                                          \
    } while(0)

#define LOAD_MSG_4_3(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_HI(7, 5);                                          \
        b1 = M_LO_HI(3, 1);                                          \
    } while(0)

#define LOAD_MSG_4_4(b0, b1)                                         \
    do {                                                             \
        b0 = vextq_u64(m0, m6, 1);                                   \
        b1 = M_LO_HI(4, 6);                                          \
    } while(0)

#define LOAD_MSG_5_1(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_LO(1, 3);                                          \
        b1 = M_LO_LO(0, 4);                                          \
    } while(0)

#define LOAD_MSG_5_2(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_LO(6, 5);                                          \
        b1 = M_HI_HI(5, 1);                                          \
    } while(0)

#define LOAD_MSG_5_3(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_HI(2, 3);                                          \
        b1 = M_HI_HI(7, 0);                                          \
    } while(0)

#define LOAD_MSG_5_4(b0, b1)                                         \
    do {                                                             \
        b0 = M_HI_HI(6, 2);                                          \
        b1 = M_LO_HI(7, 4);                                          \
    } while(0)

#define LOAD_MSG_6_1(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_HI(6, 0);                                          \
        b1 = M_LO_LO(7, 2);                                          \
    } while(0)

#define LOAD_MSG_6_2(b0, b1)                                         \
    do {                                                             \
        b0 = M_HI_HI(2, 7);                                          \
        b1 = vextq_u64(m6, m5, 1);                                   \
    } while(0)

#define LOAD_MSG_6_3(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_LO(0, 3);                                          \
        b1 = vextq_u64(m4, m4, 1);                                   \
    } while(0)

#define LOAD_MSG_6_4(b0, b1)                                         \
    do {                                                             \
        b0 = M_HI_HI(3, 1);                                          \
        b1 = M_LO_HI(1, 5);                                          \
    } while(0)

#define LOAD_MSG_7_1(b0, b1)                                         \
    do {                                                             \
        b0 = M_HI_HI(6, 3);                                          \
        b1 = M_LO_HI(6, 1);                                          \
    } while(0)

#define LOAD_MSG_7_2(b0, b1)                                         \
    do {                                                             \
        b0 = vextq_u64(m5, m7, 1);                                   \
        b1 = M_HI_HI(0, 4);                                          \
    } while(0)

#define LOAD_MSG_7_3(b0, b1)                                         \
    do {                                                             \
        b0 = M_HI_HI(2, 7);                                          \
        b1 = M_LO_LO(4, 1);                                          \
    } while(0)

#define LOAD_MSG_7_4(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_LO(0, 2);                                          \
        b1 = M_LO_LO(3, 5);                                          \
    } while(0)

#define LOAD_MSG_8_1(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_LO(3, 7);                                          \
        b1 = vextq_u64(m5, m0, 1);                                   \
    } while(0)

#define LOAD_MSG_8_2(b0, b1)                                         \
    do {                                                             \
        b0 = M_HI_HI(7, 4);                                          \
        b1 = vextq_u64(m1, m4, 1);                                   \
    } while(0)

#define LOAD_MSG_8_3(b0, b1)                                         \
    do {                                                             \
        b0 = m6;                                                     \
        b1 = vextq_u64(m0, m5, 1);                                   \
    } while(0)

#define LOAD_MSG_8_4(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_HI(1, 3);                                          \
        b1 = m2;                                                     \
    } while(0)

#define LOAD_MSG_9_1(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_LO(5, 4);                                          \
        b1 = M_HI_HI(3, 0);                                          \
    } while(0)

#define LOAD_MSG_9_2(b0, b1)                                         \
    do {                                                             \
        b0 = M_LO_LO(1, 2);                                          \
        b1 = M_LO_HI(3, 2);                                          \
    } while(0)

#define LOAD_MSG_9_3(b0, b1)                                         \
    do {                                                             \
        b0 = M_HI_HI(7, 4);                                          \
        b1 = M_HI_HI(1, 6);                                          \
    } while(0)

#define LOAD_MSG_9_4(b0, b1)                                         \
    do {                                                             \
        b0 = vextq_u64(m5, m7, 1);                                   \
        b1 = M_LO_LO(6, 0);                                          \
    } while(0)

#endif
