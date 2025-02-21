//ROUND0
.macro LOAD_MSG_0_1 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip1    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_0_2 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip2    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_0_3 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip1    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_0_4 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip2    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm

//ROUND1
.macro LOAD_MSG_1_1 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip2    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_1_2 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    ext    \b1\().16b, \m2\().16b, \m3\().16b, #8  // b1
.endm
.macro LOAD_MSG_1_3 m0, m1, m2, m3, b0, b1
    ext    \b0\().16b, \m0\().16b, \m1\().16b, #8  // b0
    zip2    \b1\().2d, \m2\().2d, \m3\().2d  // b1
   
.endm
.macro LOAD_MSG_1_4 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip2    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm

//ROUND2
.macro LOAD_MSG_2_1 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    ext    \b1\().16b, \m2\().16b, \m3\().16b, #8  // b1
.endm
.macro LOAD_MSG_2_2 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d                 //LOAD_MSG_2_2
    mov     \b1\().16b, \m2\().16b
    mov     \b1\().d[1], \m3\().d[1]
.endm
.macro LOAD_MSG_2_3 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d                 //LOAD_MSG_2_2
    mov     \b1\().16b, \m2\().16b
    mov     \b1\().d[1], \m3\().d[1]
   
.endm
.macro LOAD_MSG_2_4 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    ext    \b1\().16b, \m2\().16b, \m3\().16b, #8  // b1
.endm

//ROUND3
.macro LOAD_MSG_3_1 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip2    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_3_2 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip1    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_3_3 m0, m1, m2, m3, b0, b1
    mov     \b0\().16b, \m0\().16b
    mov     \b0\().d[1], \m1\().d[1]
    mov     \b1\().16b, \m2\().16b
    mov     \b1\().d[1], \m3\().d[1]
.endm
.macro LOAD_MSG_3_4 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip1    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
//ROUND3
.macro LOAD_MSG_4_1 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip1    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_4_2 m0, m1, b0, b1
    // v1 same
    mov     \b0\().16b, \m0\().16b
    mov     \b0\().d[1], \m1\().d[1]
.endm
.macro LOAD_MSG_4_3 m0, m1, m2, m3 b0, b1
    mov     \b0\().16b, \m0\().16b
    mov     \b0\().d[1], \m1\().d[1]
    mov     \b1\().16b, \m2\().16b
    mov     \b1\().d[1], \m3\().d[1]
.endm
.macro LOAD_MSG_4_4 m0, m1, m2, m3, b0, b1
    ext    \b0\().16b, \m0\().16b, \m1\().16b, #8  // b0
    mov     \b1\().16b, \m2\().16b
    mov     \b1\().d[1], \m3\().d[1]
.endm
//ROUND5
.macro LOAD_MSG_5_1 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip1    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_5_2 m0, m1, m2, m3, b0, b1
    // v1 same
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip2    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_5_3 m0, m1, m2, m3 b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    mov     \b1\().16b, \m2\().16b
    mov     \b1\().d[1], \m3\().d[1]
.endm
.macro LOAD_MSG_5_4 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    mov     \b1\().16b, \m2\().16b
    mov     \b1\().d[1], \m3\().d[1]
.endm
//ROUND6
.macro LOAD_MSG_6_1 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    mov     \b1\().16b, \m2\().16b
    mov     \b1\().d[1], \m3\().d[1]
.endm
.macro LOAD_MSG_6_2 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    ext    \b1\().16b, \m2\().16b, \m3\().16b, #8  // b1
.endm
.macro LOAD_MSG_6_3 m0, m1, m2, m3 b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    ext    \b1\().16b, \m2\().16b, \m3\().16b, #8  // b1
.endm
.macro LOAD_MSG_6_4 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    mov     \b1\().16b, \m2\().16b
    mov     \b1\().d[1], \m3\().d[0]
.endm
//ROUND7
.macro LOAD_MSG_7_1 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    mov     \b1\().16b, \m2\().16b
    mov     \b1\().d[1], \m3\().d[1]
.endm
.macro LOAD_MSG_7_2 m0, m1, m2, m3, b0, b1
    ext    \b0\().16b, \m0\().16b, \m1\().16b, #8  // b0
    zip2    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_7_3 m0, m1, m2, m3 b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip1    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_7_4 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip1    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
//ROUND8
.macro LOAD_MSG_8_1 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    ext    \b1\().16b, \m2\().16b, \m3\().16b, #8  // b1
.endm
.macro LOAD_MSG_8_2 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    ext    \b1\().16b, \m2\().16b, \m3\().16b, #8  // b1
.endm
.macro LOAD_MSG_8_3 m2, m3, b1
    ext    \b1\().16b, \m2\().16b, \m3\().16b, #8  // b1
.endm
.macro LOAD_MSG_8_4 m2, m3, b0
    mov     \b0\().16b, \m2\().16b
    mov     \b0\().d[1], \m3\().d[1]
.endm
//ROUND9
.macro LOAD_MSG_9_1 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip2    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_9_2 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    mov     \b1\().16b, \m2\().16b
    mov     \b1\().d[1], \m3\().d[1]
.endm
.macro LOAD_MSG_9_3 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip2    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_9_4 m0, m1, b0
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
.endm
//ROUND10
.macro LOAD_MSG_10_1 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip1    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_10_2 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip2    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_10_3 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip1    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_10_4 m0, m1, m2, m3, b0, b1
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip2    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
//ROUND11
.macro LOAD_MSG_11_1 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip2    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro LOAD_MSG_11_2 m0, m1, b0
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
.endm
.macro LOAD_MSG_11_3 m0, m1, b0
    zip2    \b0\().2d, \m0\().2d, \m1\().2d  // b0
.endm
.macro LOAD_MSG_11_4 m0, m1, m2, m3, b0, b1
    zip1    \b0\().2d, \m0\().2d, \m1\().2d  // b0
    zip2    \b1\().2d, \m2\().2d, \m3\().2d  // b1
.endm
.macro G1 row1l,row2l,row3l,row4l,row1h,row2h,row3h,row4h,b0,b1,r24,oldrow2l,oldrow2h
add     \row1l\().2d, \row1l\().2d, \b0\().2d  // row1l = row1l + b0                   //G1
add     \row1l\().2d, \row1l\().2d, \oldrow2l\().2d  // row1l = row1l(v17) + row2l(v21)
add     \row1h\().2d, \row1h\().2d, \b1\().2d  // row1h = row1h + b1
add     \row1h\().2d, \row1h\().2d, \oldrow2h\().2d  // row1h = row1h(v16) +  row2h(v20)
eor     \row4l\().16b, \row4l\().16b, \row1l\().16b     //row4l= row4l eor row1l
eor     \row4h\().16b, \row4h\().16b, \row1h\().16b     //row4h = row4h eor row1h
rev64   \row4l\().4s, \row4l\().4s                //row4l rev64 row4l
rev64   \row4h\().4s, \row4h\().4s                //row4h rev64 row4h
add     \row3l\().2d, \row3l\().2d, \row4l\().2d         // row3l = row3l + row4l 
add     \row3h\().2d, \row3h\().2d, \row4h\().2d         // row3h = row3h + row4h
eor     \row2l\().16b, \oldrow2l\().16b, \row3l\().16b      //row2l = veorq_u64(row2l, row3l);
eor     \row2h\().16b, \oldrow2h\().16b, \row3h\().16b      //row2h = veorq_u64(row2h, row3h);
tbl     \row2l\().16b, {\row2l\().16b}, \r24\().16b   //row2l = vrorq_n_u64_24(row2l);
tbl     \row2h\().16b, {\row2h\().16b}, \r24\().16b   //row2h = vrorq_n_u64_24(row2h); 
.endm

.macro G2 row1l,row2l,row3l,row4l,row1h,row2h,row3h,row4h,b0,b1,r16,oldrow2l,oldrow2h,newrow2l,newrow2h
add     \row1l\().2d, \row1l\().2d, \b0\().2d  // row1l = row1l + b0                   //G2
add     \row1l\().2d, \row1l\().2d, \oldrow2l\().2d  // row1l = row1l(v17) + row2l(v21)
add     \row1h\().2d, \row1h\().2d, \b1\().2d  // row1h = row1h + b1
add     \row1h\().2d, \row1h\().2d, \oldrow2h\().2d  // row1h = row1h(v16) +  row2h(v20)
eor     \row4l\().16b, \row4l\().16b, \row1l\().16b     //row4l= row4l eor row1l
eor     \row4h\().16b, \row4h\().16b, \row1h\().16b     //row4h = row4h eor row1h
tbl     \row4l\().16b, {\row4l\().16b}, \r16\().16b   
tbl     \row4h\().16b, {\row4h\().16b}, \r16\().16b   
add     \row3l\().2d, \row3l\().2d, \row4l\().2d         // row3l = row3l + row4l 
add     \row3h\().2d, \row3h\().2d, \row4h\().2d         // row3h = row3h + row4h   
eor     \row2l\().16b, \row2l\().16b, \row3l\().16b      //row2l = veorq_u64(row2l, row3l);
eor     \row2h\().16b, \row2h\().16b, \row3h\().16b      //row2h = veorq_u64(row2h, row3h);
ushr    \newrow2l\().2d, \row2l\().2d, #63 
sli     \newrow2l\().2d, \row2l\().2d, #1        
ushr    \newrow2h\().2d, \row2h\().2d, #63          
sli     \newrow2h\().2d, \row2h\().2d, #1         
.endm

.macro DIAGONALIZE row2l,row4l,row2h,row4h,oldrow2l,oldrow4l,oldrow2h,oldrow4h
ext     \row2l\().16b, \oldrow2l\().16b, \oldrow2h\().16b, #8    
ext     \row4l\().16b, \oldrow4h\().16b, \oldrow4l\().16b, #8     
ext     \row2h\().16b, \oldrow2h\().16b, \oldrow2l\().16b, #8   
ext     \row4h\().16b, \oldrow4l\().16b, \oldrow4h\().16b, #8      
.endm


.macro UNDIAGONALIZE row2l,row4l,row2h,row4h,oldrow2l,oldrow4l,oldrow2h,oldrow4h
ext     \row2l\().16b, \oldrow2h\().16b, \oldrow2l\().16b, #8
ext     \row4l\().16b, \oldrow4l\().16b, \oldrow4h\().16b, #8
ext     \row2h\().16b, \oldrow2l\().16b, \oldrow2h\().16b, #8
ext     \row4h\().16b, \oldrow4h\().16b, \oldrow4l\().16b, #8      
.endm


.global blake2b_compress_neon_assembly
.type blake2b_compress_neon_assembly, %function
.balign 64
blake2b_compress_neon_assembly:
stp     d8, d9, [sp, #-80]!
mov     x2, x0
ldp     q31, q30, [x1]      // Load m0, m1 (block + 0, block + 16)
stp     d10, d11, [sp, #16] 
ldp     q29, q28, [x1, #32] // Load m2, m3 (block + 32, block + 48)
stp     d12, d13, [sp, #32]
ldp     q27, q26, [x1, #64] // Load m4, m5 (block + 64, block + 80)
stp     d14, d15, [sp, #48]
ldp     q25, q24, [x1, #96] // Load m6, m7 (block + 96, block + 112)
ldp     q23, q22, [x0]      // Load h0, h1 (S->h[0], S->h[2])
ldp     q21, q20, [x0, #32] // Load h2, h3 (S->h[4], S->h[6])
ldp     q7, q5, [x2, #64]           //vld1q_u64(&S->t[0]) , vld1q_u64(&S->f[0])    
ldr     q6, .rodata + 32            //blake2b_IV[4]
ldr     q4, .rodata + 48             //blake2b_IV[6]
ldr     q3, .rodata + 0             //&blake2b_IV[0] row3l
ldr     q2, .rodata + 16            //&blake2b_IV[2] row3h
ldr     q15, .rodata + 80           // r24
ldr     q12, .rodata + 64             // r16
mov     v17.16b, v23.16b        // const uint64x2_t h0 = row1l = vld1q_u64(&S->h[0]);
mov     v16.16b, v22.16b        // const uint64x2_t h1 = row1h = vld1q_u64(&S->h[2]);
eor     v6.16b, v7.16b, v6.16b      //const uint64x2_t h2 = row2l = vld1q_u64(&S->h[4]);
eor     v4.16b, v5.16b, v4.16b      //const uint64x2_t h3 = row2h = vld1q_u64(&S->h[6]);
mov     v7.16b, v21.16b             //row2l
mov     v5.16b, v20.16b             //row2h


//ROUND 0
LOAD_MSG_0_1 v31, v30, v29, v28, v19, v18
G1 v17,v7,v3,v6,v16,v5,v2,v4,v19,v18,v15,v21,v20
LOAD_MSG_0_2 v31, v30, v29, v28, v19, v18   

movi    v11.4s, #0x0
movi    v10.4s, #0x0
G2 v17,v7,v3,v6,v16,v5,v2,v4,v19,v18,v12,v7,v5,v11,v10   
DIAGONALIZE v19,v18,v10,v4,v11,v6,v10,v4
LOAD_MSG_0_3 v27, v26, v25, v24, v13, v14      
G1 v17,v19,v2,v18,v16,v10,v3,v4,v13,v14,v15,v19,v10 //G1
LOAD_MSG_0_4 v27, v26, v25, v24, v6 ,v14 
G2 v17,v19,v2,v18,v16,v10,v3,v4,v6,v14,v12,v19,v10,v14,v13  //G2 
UNDIAGONALIZE v0,v11,v13,v4,v14,v18,v13,v4

//ROUND1
LOAD_MSG_1_1 v24, v29, v27, v25, v7, v5
G1 v17,v0,v3,v11,v16,v1,v2,v4,v7,v5,v15,v0,v13
LOAD_MSG_1_2 v26, v27, v24, v28, v18, v19
G2 v17,v0,v3,v11,v16,v1,v2,v4,v18,v19,v12,v0,v1,v6,v13 
DIAGONALIZE v10,v14,v13,v4,v6,v11,v13,v4
LOAD_MSG_1_3 v31, v31, v26, v29, v7, v5
G1 v17,v10,v2,v14,v16,v13,v3,v4,v7,v5,v15,v10,v13
LOAD_MSG_1_4 v25, v30, v28, v30, v0, v1
G2 v17,v10,v2,v14,v16,v13,v3,v4,v0,v1,v12,v10,v13,v18,v11
UNDIAGONALIZE v6,v5,v11,v4,v18,v14,v11,v4

//ROUND2
LOAD_MSG_2_1 v29, v24, v26, v25, v0, v1
G1 v17,v6,v3,v5,v16,v10,v2,v4,v1,v0,v15,v6,v11
LOAD_MSG_2_2 v27, v31, v30, v25, v13, v14
G2 v17,v6,v3,v5,v16,v10,v2,v4,v13,v14,v12,v6,v10,v18,v11
DIAGONALIZE v0,v1,v11,v4,v18,v5,v11,v4
LOAD_MSG_2_3 v28, v27, v26, v30, v13, v14
G1 v17,v0,v2,v1,v16,v6,v3,v4,v14,v13,v15,v0,v11
LOAD_MSG_2_4 v24, v28, v31, v29, v10, v18
G2 v17,v0,v2,v1,v16,v6,v3,v4,v10,v18,v12,v0,v6,v5,v11
UNDIAGONALIZE v13,v14,v11,v4,v5,v1,v11,v4

//ROUND3
LOAD_MSG_3_1 v28, v30, v25, v26, v10, v6
G1 v17,v13,v3,v14,v16,v0,v2,v4,v10,v6,v15,v13,v11
LOAD_MSG_3_2 v27, v31, v25, v24, v1, v5
G2 v17,v13,v3,v14,v16,v0,v2,v4,v1,v5,v12,v13,v0,v18,v11
DIAGONALIZE v10,v6,v11,v4,v18,v14,v11,v4
LOAD_MSG_3_3  v30, v29, v29, v24, v5, v1
G1 v17,v10,v2,v6,v16,v13,v3,v4,v5,v1,v15,v10,v11
LOAD_MSG_3_4 v28, v26, v31, v27, v0, v18
G2 v17,v10,v2,v6,v16,v13,v3,v4,v0,v18,v12,v10,v13,v5,v11
DIAGONALIZE v14,v0,v11,v4,v11,v4,v5,v6


//ROUND4
LOAD_MSG_4_1 v27, v29, v30, v26, v18, v6
G1 v17,v14,v3,v0,v16,v13,v2,v4,v18,v6,v15,v14,v11
LOAD_MSG_4_2 v31, v28, v5, v1
G2 v17,v14,v3,v0,v16,v13,v2,v4,v5,v1,v12,v14,v13,v10,v11
DIAGONALIZE v18,v6,v11,v4,v10,v0,v11,v4
LOAD_MSG_4_3 v24, v26, v28, v30, v5, v0
mov     d1, v26.d[1]                                //stray move
G1 v17,v18,v2,v6,v16,v13,v3,v4,v5,v0,v15,v18,v11
LOAD_MSG_4_4 v31, v25, v27, v25, v10, v5
G2 v17,v18,v2,v6,v16,v13,v3,v4,v10,v5,v12,v18,v13,v14,v11
UNDIAGONALIZE v0,v10,v11,v4,v14,v6,v11,v4

//ROUND5
LOAD_MSG_5_1 v30, v28, v31, v27, v5, v6
G1 v17,v0,v3,v10,v16,v13,v2,v4,v5,v6,v15,v0,v11
LOAD_MSG_5_2 v25, v26, v26, v30, v14, v5
G2 v17,v0,v3,v10,v16,v13,v2,v4,v14,v5,v12,v0,v13,v18,v11
DIAGONALIZE v6,v14,v11,v4,v18,v10,v11,v4
LOAD_MSG_5_3 v24, v31, v29, v28 v5, v10
G1 v17,v6,v2,v14,v16,v13,v3,v4,v10,v5,v15,v6,v11
LOAD_MSG_5_4 v25, v29, v24, v27, v18, v5
G2 v17,v6,v2,v14,v16,v13,v3,v4,v18,v5,v12,v6,v13,v0,v11
UNDIAGONALIZE v10,v18,v11,v4,v0,v14,v11,v4



//ROUND6
LOAD_MSG_6_1 v24, v29, v25, v31, v5, v14
G1 v17,v10,v3,v18,v16,v13,v2,v4,v14,v5,v15,v10,v11
LOAD_MSG_6_2 v29, v24, v25, v26, v0, v5
G2 v17,v10,v3,v18,v16,v13,v2,v4,v0,v5,v12,v10,v13,v6,v11
DIAGONALIZE v14,v0,v11,v4,v6,v18,v11,v4
LOAD_MSG_6_3 v31, v28, v27, v27 v5, v18
G1 v17,v14,v2,v0,v16,v11,v3,v4,v5,v18,v15,v14,v11
LOAD_MSG_6_4 v28, v30, v30, v1, v6, v5
G2 v17,v14,v2,v0,v16,v11,v3,v4,v6,v5,v12,v14,v11,v10,v13
UNDIAGONALIZE v18,v6,v13,v4,v10,v0,v13,v4


//ROUND7
LOAD_MSG_7_1 v25, v28, v25, v30, v5, v0
G1 v17,v18,v3,v6,v16,v11,v2,v4,v5,v0,v15,v18,v13
LOAD_MSG_7_2 v26, v24, v31, v27, v10, v5

G2 v17,v18,v3,v6,v16,v11,v2,v4,v10,v5,v12,v18,v11,v14,v13
DIAGONALIZE v0,v5,v13,v4,v14,v6,v13,v4
LOAD_MSG_7_3 v29, v24, v27, v30 v6, v18
G1 v17,v0,v2,v5,v16,v14,v3,v4,v6,v18,v15,v0,v13
LOAD_MSG_7_4 v31, v29, v28, v26, v6, v18
G2 v17,v0,v2,v5,v16,v14,v3,v4,v6,v18,v12,v0,v14,v11,v13
UNDIAGONALIZE v6,v18,v13,v4,v11,v5,v13,v4




//ROUND8
LOAD_MSG_8_1 v28, v24, v26, v31, v5, v0
G1 v17,v6,v3,v18,v16,v11,v2,v4,v5,v0,v15,v6,v13
LOAD_MSG_8_2 v24, v27, v30, v27, v5, v0
G2 v17,v6,v3,v18,v16,v11,v2,v4,v5,v0,v12,v6,v11,v14,v13
DIAGONALIZE v5,v0,v13,v4,v14,v18,v13,v4
LOAD_MSG_8_3 v31, v26, v18
G1 v17,v5,v2,v0,v16,v11,v3,v4,v25,v18,v15,v5,v13
LOAD_MSG_8_4 v30, v28, v14
G2 v17,v5,v2,v0,v16,v11,v3,v4,v14,v29,v12,v5,v11,v6,v13
UNDIAGONALIZE v18,v14,v13,v4,v6,v0,v13,v4


//ROUND9
LOAD_MSG_9_1 v26, v27, v28, v31, v0, v5
G1 v17,v18,v3,v14,v16,v13,v2,v4,v0,v5,v15,v18,v13
LOAD_MSG_9_2 v30, v29, v28, v29, v0, v5
G2 v17,v18,v3,v14,v16,v13,v2,v4,v0,v5,v12,v18,v13,v11,v6
DIAGONALIZE v0,v5,v6,v4,v11,v14,v6,v4
LOAD_MSG_9_3 v24, v27, v30, v25, v14, v18
G1 v17,v0,v2,v5,v16,v11,v3,v4,v14,v18,v15,v0,v6
LOAD_MSG_9_4 v25, v31, v14
G2 v17,v0,v2,v5,v16,v11,v3,v4,v10,v14,v12,v0,v11,v13,v6
UNDIAGONALIZE v18,v14,v6,v4,v13,v5,v6,v4


//ROUND10
LOAD_MSG_10_1 v31, v30, v29, v28, v0, v11
G1 v17,v18,v3,v14,v16,v0,v2,v4,v0,v11,v15,v18,v6
LOAD_MSG_10_2 v31, v30, v29, v28, v31, v11
G2 v17,v18,v3,v14,v16,v0,v2,v4,v31,v11,v12,v18,v0,v13,v6
DIAGONALIZE v31,v11,v6,v4,v13,v14,v6,v4
LOAD_MSG_10_3 v27, v26, v25, v24, v14, v18
G1 v17,v31,v2,v11,v16,v6,v3,v4,v14,v18,v15,v31,v6
LOAD_MSG_10_4 v27, v26, v25, v24, v14, v18
G2 v17,v31,v2,v11,v16,v6,v3,v4,v14,v18,v12,v31,v6,v0,v13
UNDIAGONALIZE v31,v6,v13,v4,v0,v11,v13,v4


//ROUND11
LOAD_MSG_11_1 v24, v29, v27, v25, v24, v0
G1 v17,v31,v3,v6,v16,v0,v2,v4,v24,v0,v15,v31,v13
LOAD_MSG_11_2 v26, v27, v27
G2 v17,v31,v3,v6,v16,v0,v2,v4,v27,v19,v12,v31,v0,v24,v13
DIAGONALIZE v31,v0,v13,v4,v24,v6,v13,v4
LOAD_MSG_11_3 v26, v29, v26
G1 v17,v31,v2,v0,v16,v26,v3,v4,v7,v26,v15,v31,v13
LOAD_MSG_11_4 v25, v30, v28, v30, v25, v28
G2 v17,v31,v2,v0,v16,v26,v3,v4,v25,v28,v12,v31,v26,v24,v13
eor     v3.16b, v17.16b, v3.16b
eor     v2.16b, v16.16b, v2.16b
eor     v3.16b, v3.16b, v23.16b
eor     v2.16b, v2.16b, v22.16b
stp     q3, q2, [x2]
UNDIAGONALIZE v3,v2,v13,v4,v24,v0,v13,v4

eor     v2.16b, v3.16b, v2.16b
eor     v4.16b, v13.16b, v4.16b
eor     v2.16b, v2.16b, v21.16b
eor     v4.16b, v4.16b, v20.16b
stp     q2, q4, [x2, #32]
ldp     d10, d11, [sp, #16]
ldp     d12, d13, [sp, #32]
ldp     d14, d15, [sp, #48]
ldp     d8, d9, [sp], #80
ret
// Constants in .rodata
.section .rodata
.balign 64          // Align to 64 bytes (CRYPTO_ALIGN(64))
.type blake2b_IV, %object
.size blake2b_IV, 64
blake2b_IV:
    .quad		0x6a09e667f3bcc908, 0xbb67ae8584caa73b
	.quad		0x3c6ef372fe94f82b, 0xa54ff53a5f1d36f1
	.quad		0x510e527fade682d1, 0x9b05688c2b3e6c1f
	.quad		0x1f83d9abfb41bd6b, 0x5be0cd19137e2179
.type r16_const, %object
.size r16_const, 16
r16_const:
    .byte 2, 3, 4, 5, 6, 7, 0, 1, 10, 11, 12, 13, 14, 15, 8, 9
.type r24_const, %object
.size r24_const, 16
r24_const:
    .byte 3, 4, 5, 6, 7, 0, 1, 2, 11, 12, 13, 14, 15, 8, 9, 10


