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
#ifndef BLAKE2B_ROUND_H
#define BLAKE2B_ROUND_H

#define vrorq_n_u64_16(x) vreinterpretq_u64_s8(vqtbl1q_s8(vreinterpretq_s8_u64(x), (uint8x16_t)r16))
#define vrorq_n_u64_24(x) vreinterpretq_u64_s8(vqtbl1q_s8(vreinterpretq_s8_u64(x), (uint8x16_t)r24))
#define vrorq_n_u64_32(x) vreinterpretq_u64_u32(vrev64q_u32(vreinterpretq_u32_u64((x))))

#define vrorq_n_u64_63(x) vsliq_n_u64(vshrq_n_u64(x, 63), x, 1)

#define G1(row1l,row2l,row3l,row4l,row1h,row2h,row3h,row4h,b0,b1) \
do {\
  __asm__ volatile (                                          \
      "add %0.2d, %0.2d, %1.2d\n\t"  /* dest = dest + a */   \
      "add %0.2d, %0.2d, %2.2d\n\t"  /* dest = dest + b */   \
      : "+w" (row1l)                                          \
      : "w" (b0), "w" (row2l)                                     \
  );                                                          \
  __asm__ volatile (                                          \
    "add %0.2d, %0.2d, %1.2d\n\t"  /* dest = dest + a */   \
    "add %0.2d, %0.2d, %2.2d\n\t"  /* dest = dest + b */   \
    : "+w" (row1h)                                          \
    : "w" (b1), "w" (row2h)                                     \
  );                                                          \
  __asm__ volatile (                                               \
    "eor %0.16b, %0.16b, %1.16b\n"                                \
    : "+w" (row4l)                                               \
    : "w" (row1l)                                                 \
  );                                                               \
  __asm__ volatile (                                               \
    "eor %0.16b, %0.16b, %1.16b\n"                                \
    : "+w" (row4h)                                               \
    : "w" (row1h)                                                 \
  );                                                               \
  __asm__ volatile (                                             \
    "rev64 %0.4s, %0.4s\n"                                      \
    : "+w" (row4l)                                                \
    :                                                         \
  );                                                             \
  __asm__ volatile (                                             \
    "rev64 %0.4s, %0.4s\n"                                      \
    : "+w" (row4h)                                                \
    :                                                         \
  );                                                             \
  __asm__ volatile (                                                   \
    "add %0.2d, %0.2d, %2.2d\n\t" /* dest_l = dest_l + src_l */       \
    "add %1.2d, %1.2d, %3.2d\n\t" /* dest_h = dest_h + src_h */       \
    : "+w" (row3l), "+w" (row3h)                                   \
    : "w" (row4l), "w" (row4h)                                       \
  );                                                                   \
  __asm__ volatile (                                                   \
    "eor %0.16b, %0.16b, %2.16b\n\t"  /* dest_l = dest_l XOR src_l */  \
    "eor %1.16b, %1.16b, %3.16b\n\t"  /* dest_h = dest_h XOR src_h */  \
    : "+w" (row2l), "+w" (row2h)                                  \
    : "w" (row3l), "w" (row3h)                                      \
  );                                                                   \
  __asm__ volatile (                                                \
    "tbl %0.16b, {%0.16b}, %1.16b\n"                                \
    : "+w" (row2l)                                                 \
    : "w" (r24)                                                    \
  );                                                                 \
  __asm__ volatile (                                                \
    "tbl %0.16b, {%0.16b}, %1.16b\n"                                \
    : "+w" (row2h)                                                 \
    : "w" (r24)                                                    \
  );                                                                 \
} while(0)
  
#define G2(row1l,row2l,row3l,row4l,row1h,row2h,row3h,row4h,b0,b1) \
  __asm__ volatile (                                          \
    "add %0.2d, %0.2d, %1.2d\n\t"  /* dest = dest + a */   \
    "add %0.2d, %0.2d, %2.2d\n\t"  /* dest = dest + b */   \
    : "+w" (row1l)                                          \
    : "w" (b0), "w" (row2l)                                     \
  );                                                          \
  __asm__ volatile (                                          \
  "add %0.2d, %0.2d, %1.2d\n\t"  /* dest = dest + a */   \
  "add %0.2d, %0.2d, %2.2d\n\t"  /* dest = dest + b */   \
  : "+w" (row1h)                                          \
  : "w" (b1), "w" (row2h)                                     \
  );                                                          \
  __asm__ volatile (                                               \
    "eor %0.16b, %0.16b, %1.16b\n"                                \
    : "+w" (row4l)                                               \
    : "w" (row1l)                                                 \
  );                                                               \
  __asm__ volatile (                                               \
    "eor %0.16b, %0.16b, %1.16b\n"                                \
    : "+w" (row4h)                                               \
    : "w" (row1h)                                                 \
  );                                                               \
  __asm__ volatile (                                                \
    "tbl %0.16b, {%0.16b}, %1.16b\n"                                \
    : "+w" (row4l)                                                 \
    : "w" (r16)                                                    \
  );                                                                 \
  __asm__ volatile (                                                \
    "tbl %0.16b, {%0.16b}, %1.16b\n"                                \
    : "+w" (row4h)                                                 \
    : "w" (r16)                                                    \
  );                                                                 \
  __asm__ volatile (                                                   \
    "add %0.2d, %0.2d, %2.2d\n\t" /* dest_l = dest_l + src_l */       \
    "add %1.2d, %1.2d, %3.2d\n\t" /* dest_h = dest_h + src_h */       \
    : "+w" (row3l), "+w" (row3h)                                   \
    : "w" (row4l), "w" (row4h)                                       \
  );                                                                   \
  __asm__ volatile (                                                   \
    "eor %0.16b, %0.16b, %2.16b\n\t"  /* dest_l = dest_l XOR src_l */  \
    "eor %1.16b, %1.16b, %3.16b\n\t"  /* dest_h = dest_h XOR src_h */  \
    : "+w" (row2l), "+w" (row2h)                                  \
    : "w" (row3l), "w" (row3h)                                      \
  );                                                                   \
  __asm__ volatile (                                       \
    "ushr %0.2d, %1.2d, #63\n\t"                       \
    : "+w" (t0)                                       \
    : "w" (row2l)                    \
  );                                  \
  __asm__ volatile ( \
    "sli %0.2d, %1.2d, #1\n\t" \
    : "+w" (t0)    \
    : "w" (row2l)  \
  );  \
  row2l = t0; \
  __asm__ volatile (                                       \
    "ushr %0.2d, %1.2d, #63\n\t"                       \
    : "+w" (t1)                                       \
    : "w" (row2h)                    \
  );                                  \
  __asm__ volatile ( \
    "sli %0.2d, %1.2d, #1\n\t" \
    : "+w" (t1)    \
    : "w" (row2h)  \
  );  \
  row2h = t1;
  

#define DIAGONALIZE(row1l,row2l,row3l,row4l,row1h,row2h,row3h,row4h) \
    t0 = vextq_u64(row2l, row2h, 1); \
    t1 = vextq_u64(row2h, row2l, 1); \
    row2l = t0; row2h = t1; t0 = row3l;  row3l = row3h; row3h = t0; \
    t2 = vextq_u64(row4h, row4l, 1); t3 = vextq_u64(row4l, row4h, 1); \
    row4l = t2; row4h = t3;

#define UNDIAGONALIZE(row1l,row2l,row3l,row4l,row1h,row2h,row3h,row4h) \
    t0 = vextq_u64(row2h, row2l, 1); \
    t1 = vextq_u64(row2l, row2h, 1); \
    row2l = t0; row2h = t1; t0 = row3l; row3l = row3h; row3h = t0; \
    t2 = vextq_u64(row4l, row4h, 1); t3 = vextq_u64(row4h, row4l, 1); \
    row4l = t2; row4h = t3;

#include "blake2b-load-neon.h"

#define ROUND(r) \
  LOAD_MSG_ ##r ##_1(b0, b1); \
  G1(row1l,row2l,row3l,row4l,row1h,row2h,row3h,row4h,b0,b1); \
  LOAD_MSG_ ##r ##_2(b0, b1); \
  G2(row1l,row2l,row3l,row4l,row1h,row2h,row3h,row4h,b0,b1); \
  DIAGONALIZE(row1l,row2l,row3l,row4l,row1h,row2h,row3h,row4h); \
  LOAD_MSG_ ##r ##_3(b0, b1); \
  G1(row1l,row2l,row3l,row4l,row1h,row2h,row3h,row4h,b0,b1); \
  LOAD_MSG_ ##r ##_4(b0, b1); \
  G2(row1l,row2l,row3l,row4l,row1h,row2h,row3h,row4h,b0,b1); \
  UNDIAGONALIZE(row1l,row2l,row3l,row4l,row1h,row2h,row3h,row4h);

#endif
