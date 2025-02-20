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
zip1    v19.2d, v31.2d, v30.2d  // b0 = zip1 m0 m1
zip1    v18.2d, v29.2d, v28.2d  // b1 = zip1 m2 m3
mov     v17.16b, v23.16b        // h0 kati = row1l
add     v17.2d, v17.2d, v19.2d  // row1l = row1l + b0
add     v17.2d, v17.2d, v21.2d  // row1l = row1l(v17) + row2l(v21)
mov     v16.16b, v22.16b        // h1 kati = row1h
add     v16.2d, v16.2d, v18.2d  // row1h = row1h + b1
add     v16.2d, v16.2d, v20.2d  // row1h = row1h(v16) +  row2h(v20)
ldp     q7, q5, [x2, #64]           //vld1q_u64(&S->t[0]) , vld1q_u64(&S->f[0])    
ldr     q6, .rodata + 32            //blake2b_IV[4]
eor     v6.16b, v7.16b, v6.16b      //row4l= vld1q_u64(&S->t[0]) eor blake2b_IV[4]
eor     v6.16b, v6.16b, v17.16b     //row4l= row4l eor row1l
ldr     q4, .rodata + 48             //blake2b_IV[6]
eor     v4.16b, v5.16b, v4.16b      //row4h = vld1q_u64(&S->f[0])  eor blake2b_IV[6]
eor     v4.16b, v4.16b, v16.16b     //row4h = row4h eor row1h
rev64   v6.4s, v6.4s                //row4l rev64 row4l
rev64   v4.4s, v4.4s                //row4h rev64 row4h
ldr     q3, .rodata + 0             //&blake2b_IV[0] row3l
ldr     q2, .rodata + 16            //&blake2b_IV[2] row3h
add     v3.2d, v3.2d, v6.2d         // row3l = row3l + row4l 
add     v2.2d, v2.2d, v4.2d         // row3h = row3h + row4h
mov     v7.16b, v21.16b             //h2
mov     v5.16b, v20.16b             //h3
eor     v7.16b, v7.16b, v3.16b      //row2l = veorq_u64(row2l, row3l);
eor     v5.16b, v5.16b, v2.16b      //row2h = veorq_u64(row2h, row3h);
ldr     q15, .rodata + 80           // r24
tbl     v7.16b, {v7.16b}, v15.16b   //row2l = vrorq_n_u64_24(row2l);
tbl     v5.16b, {v5.16b}, v15.16b   //row2h = vrorq_n_u64_24(row2h);
zip2    v19.2d, v31.2d, v30.2d      
zip2    v18.2d, v29.2d, v28.2d      
add     v17.2d, v17.2d, v19.2d      
add     v17.2d, v17.2d, v7.2d       
add     v16.2d, v16.2d, v18.2d      
add     v16.2d, v16.2d, v5.2d       
eor     v6.16b, v6.16b, v17.16b     
eor     v4.16b, v4.16b, v16.16b     
ldr     q12, .rodata + 64             // r16
tbl     v6.16b, {v6.16b}, v12.16b   
tbl     v4.16b, {v4.16b}, v12.16b   
add     v3.2d, v3.2d, v6.2d         
add     v2.2d, v2.2d, v4.2d         
eor     v7.16b, v7.16b, v3.16b      
eor     v5.16b, v5.16b, v2.16b      
movi    v11.4s, #0x0                
ushr    v11.2d, v7.2d, #63          
sli     v11.2d, v7.2d, #1           
movi    v10.4s, #0x0
ushr    v10.2d, v5.2d, #63          
sli     v10.2d, v5.2d, #1           
ext     v19.16b, v11.16b, v10.16b, #8   
ext     v18.16b, v4.16b, v6.16b, #8     
ext     v10.16b, v10.16b, v11.16b, #8   
ext     v4.16b, v6.16b, v4.16b, #8      
zip1    v13.2d, v27.2d, v26.2d          
zip1    v14.2d, v25.2d, v24.2d          
add     v17.2d, v17.2d, v13.2d          
add     v17.2d, v17.2d, v19.2d          
add     v16.2d, v16.2d, v14.2d          
add     v16.2d, v16.2d, v10.2d          
eor     v18.16b, v18.16b, v17.16b       
eor     v4.16b, v4.16b, v16.16b         
rev64   v18.4s, v18.4s                  
rev64   v4.4s, v4.4s                    
//mov     v14.16b, v3.16b                 
add     v2.2d, v2.2d, v18.2d              
add     v14.2d, v3.2d, v4.2d              
//mov     v13.16b, v10.16b
eor     v19.16b, v19.16b, v2.16b          
eor     v13.16b, v10.16b, v14.16b         
tbl     v19.16b, {v19.16b}, v15.16b       
tbl     v13.16b, {v13.16b}, v15.16b       
zip2    v6.2d, v27.2d, v26.2d           
zip2    v3.2d, v25.2d, v24.2d           
add     v17.2d, v17.2d, v6.2d           
add     v17.2d, v17.2d, v19.2d          
add     v16.2d, v16.2d, v3.2d           
add     v16.2d, v16.2d, v13.2d          
eor     v18.16b, v18.16b, v17.16b       
eor     v4.16b, v4.16b, v16.16b         
tbl     v18.16b, {v18.16b}, v12.16b     
tbl     v4.16b, {v4.16b}, v12.16b       
add     v2.2d, v2.2d, v18.2d            
add     v14.2d, v14.2d, v4.2d           
eor     v19.16b, v19.16b, v2.16b        
eor     v13.16b, v13.16b, v14.16b       
ushr    v3.2d, v19.2d, #63
sli     v3.2d, v19.2d, #1
ushr    v10.2d, v13.2d, #63
sli     v10.2d, v13.2d, #1
ext     v0.16b, v10.16b, v3.16b, #8
ext     v11.16b, v18.16b, v4.16b, #8
ext     v10.16b, v3.16b, v10.16b, #8
ext     v4.16b, v4.16b, v18.16b, #8
zip1    v7.2d, v24.2d, v29.2d
zip2    v5.2d, v27.2d, v25.2d
add     v17.2d, v17.2d, v7.2d
add     v17.2d, v17.2d, v0.2d
add     v16.2d, v16.2d, v5.2d
add     v16.2d, v16.2d, v10.2d
eor     v11.16b, v11.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v11.4s, v11.4s
rev64   v4.4s, v4.4s
add     v14.2d, v14.2d, v11.2d
add     v6.2d, v2.2d, v4.2d
//mov     v1.16b, v10.16b
eor     v0.16b, v0.16b, v14.16b
eor     v1.16b, v10.16b, v6.16b
tbl     v0.16b, {v0.16b}, v15.16b
tbl     v1.16b, {v1.16b}, v15.16b
zip1    v18.2d, v26.2d, v27.2d
ext     v19.16b, v24.16b, v28.16b, #8
add     v17.2d, v17.2d, v18.2d
add     v17.2d, v17.2d, v0.2d
add     v16.2d, v16.2d, v19.2d
add     v16.2d, v16.2d, v1.2d
eor     v11.16b, v11.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v11.16b, {v11.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v14.2d, v14.2d, v11.2d
add     v6.2d, v6.2d, v4.2d
eor     v0.16b, v0.16b, v14.16b
eor     v1.16b, v1.16b, v6.16b
ushr    v2.2d, v0.2d, #63
sli     v2.2d, v0.2d, #1
ushr    v10.2d, v1.2d, #63
sli     v10.2d, v1.2d, #1
ext     v13.16b, v2.16b, v10.16b, #8
ext     v3.16b, v4.16b, v11.16b, #8
ext     v10.16b, v10.16b, v2.16b, #8
ext     v4.16b, v11.16b, v4.16b, #8
ext     v7.16b, v31.16b, v31.16b, #8
zip2    v5.2d, v26.2d, v29.2d
add     v17.2d, v17.2d, v7.2d
add     v17.2d, v17.2d, v13.2d
add     v16.2d, v16.2d, v5.2d
add     v16.2d, v16.2d, v10.2d
eor     v3.16b, v3.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v3.4s, v3.4s
rev64   v4.4s, v4.4s
add     v6.2d, v6.2d, v3.2d
add     v18.2d, v14.2d, v4.2d
//mov     v11.16b, v10.16b
eor     v13.16b, v13.16b, v6.16b
eor     v10.16b, v10.16b, v18.16b
tbl     v13.16b, {v13.16b}, v15.16b
tbl     v10.16b, {v10.16b}, v15.16b
zip1    v0.2d, v25.2d, v30.2d
zip2    v1.2d, v28.2d, v30.2d
add     v17.2d, v17.2d, v0.2d
add     v17.2d, v17.2d, v13.2d
add     v16.2d, v16.2d, v1.2d
add     v16.2d, v16.2d, v10.2d
eor     v3.16b, v3.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v3.16b, {v3.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v6.2d, v6.2d, v3.2d
add     v18.2d, v18.2d, v4.2d
eor     v13.16b, v13.16b, v6.16b
eor     v11.16b, v10.16b, v18.16b
ushr    v14.2d, v13.2d, #63
sli     v14.2d, v13.2d, #1
ushr    v10.2d, v11.2d, #63
sli     v10.2d, v11.2d, #1
ext     v2.16b, v10.16b, v14.16b, #8
ext     v5.16b, v3.16b, v4.16b, #8
ext     v10.16b, v14.16b, v10.16b, #8
ext     v4.16b, v4.16b, v3.16b, #8
zip2    v0.2d, v29.2d, v24.2d
ext     v1.16b, v26.16b, v25.16b, #8
add     v17.2d, v17.2d, v1.2d
add     v17.2d, v17.2d, v2.2d
add     v16.2d, v16.2d, v0.2d
add     v16.2d, v16.2d, v10.2d
eor     v5.16b, v5.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v5.4s, v5.4s
rev64   v4.4s, v4.4s
//mov     v3.16b, v6.16b
add     v18.2d, v18.2d, v5.2d
add     v3.2d, v6.2d, v4.2d
//mov     v13.16b, v10.16b
eor     v2.16b, v2.16b, v18.16b
eor     v13.16b, v10.16b, v3.16b
tbl     v2.16b, {v2.16b}, v15.16b
tbl     v13.16b, {v13.16b}, v15.16b
zip1    v11.2d, v27.2d, v31.2d
//mov     d8, v25.d[1]
add     v17.2d, v17.2d, v11.2d
add     v17.2d, v17.2d, v2.2d
mov     v14.16b, v30.16b
mov     v14.d[1], v25.d[1]
add     v16.2d, v16.2d, v14.2d
add     v16.2d, v16.2d, v13.2d
eor     v5.16b, v5.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v5.16b, {v5.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v18.2d, v18.2d, v5.2d
add     v3.2d, v3.2d, v4.2d
eor     v2.16b, v2.16b, v18.16b
eor     v13.16b, v13.16b, v3.16b
ushr    v6.2d, v2.2d, #63
sli     v6.2d, v2.2d, #1
ushr    v10.2d, v13.2d, #63
sli     v10.2d, v13.2d, #1
ext     v0.16b, v6.16b, v10.16b, #8
ext     v1.16b, v4.16b, v5.16b, #8
ext     v10.16b, v10.16b, v6.16b, #8
ext     v4.16b, v5.16b, v4.16b, #8
//mov     d9, v30.d[1]
zip2    v11.2d, v28.2d, v27.2d
mov     v14.16b, v26.16b
mov     v14.d[1], v30.d[1]
add     v17.2d, v17.2d, v14.2d
add     v17.2d, v17.2d, v0.2d
add     v16.2d, v16.2d, v11.2d
add     v16.2d, v16.2d, v10.2d
eor     v1.16b, v1.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v1.4s, v1.4s
rev64   v4.4s, v4.4s
//mov     v5.16b, v18.16b
add     v3.2d, v3.2d, v1.2d
add     v5.2d, v18.2d, v4.2d
//mov     v2.16b, v10.16b
eor     v0.16b, v0.16b, v3.16b
eor     v2.16b, v10.16b, v5.16b
tbl     v0.16b, {v0.16b}, v15.16b
tbl     v2.16b, {v2.16b}, v15.16b
zip1    v13.2d, v24.2d, v28.2d
add     v17.2d, v17.2d, v13.2d
add     v17.2d, v17.2d, v0.2d
ext     v6.16b, v31.16b, v29.16b, #8
add     v16.2d, v16.2d, v6.2d
add     v16.2d, v16.2d, v2.2d
eor     v1.16b, v1.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v1.16b, {v1.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v3.2d, v3.2d, v1.2d
add     v5.2d, v5.2d, v4.2d
eor     v0.16b, v0.16b, v3.16b
eor     v2.16b, v2.16b, v5.16b
ushr    v18.2d, v0.2d, #63
sli     v18.2d, v0.2d, #1
ushr    v10.2d, v2.2d, #63
sli     v10.2d, v2.2d, #1
ext     v11.16b, v10.16b, v18.16b, #8
ext     v14.16b, v1.16b, v4.16b, #8
ext     v10.16b, v18.16b, v10.16b, #8
ext     v4.16b, v4.16b, v1.16b, #8
zip2    v13.2d, v28.2d, v30.2d
zip2    v6.2d, v25.2d, v26.2d
add     v17.2d, v17.2d, v13.2d
add     v17.2d, v17.2d, v11.2d
add     v16.2d, v16.2d, v6.2d
add     v16.2d, v16.2d, v10.2d
eor     v14.16b, v14.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v14.4s, v14.4s
rev64   v4.4s, v4.4s
//mov     v1.16b, v3.16b
add     v5.2d, v5.2d, v14.2d
add     v1.2d, v3.2d, v4.2d
//mov     v0.16b, v10.16b
eor     v11.16b, v11.16b, v5.16b
eor     v0.16b, v10.16b, v1.16b
tbl     v11.16b, {v11.16b}, v15.16b
tbl     v0.16b, {v0.16b}, v15.16b
zip2    v2.2d, v27.2d, v31.2d
zip1    v18.2d, v25.2d, v24.2d
add     v17.2d, v17.2d, v2.2d
add     v17.2d, v17.2d, v11.2d
add     v16.2d, v16.2d, v18.2d
add     v16.2d, v16.2d, v0.2d
eor     v14.16b, v14.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v14.16b, {v14.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v5.2d, v5.2d, v14.2d
add     v1.2d, v1.2d, v4.2d
eor     v11.16b, v11.16b, v5.16b
eor     v0.16b, v0.16b, v1.16b
ushr    v3.2d, v11.2d, #63
sli     v3.2d, v11.2d, #1
ushr    v10.2d, v0.2d, #63
sli     v10.2d, v0.2d, #1
mov     v2.16b, v29.16b
//add     x0, sp, #0x48
mov     v18.16b, v30.16b
ext     v13.16b, v3.16b, v10.16b, #8
ext     v6.16b, v4.16b, v14.16b, #8
//st1     {v29.d}[1], [x0]
mov     v2.d[1], v24.d[1]
mov     v18.d[1], v29.d[1]
ext     v10.16b, v10.16b, v3.16b, #8
ext     v4.16b, v14.16b, v4.16b, #8
add     v17.2d, v17.2d, v18.2d
add     v17.2d, v17.2d, v13.2d
add     v16.2d, v16.2d, v2.2d
add     v16.2d, v16.2d, v10.2d
eor     v6.16b, v6.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v6.4s, v6.4s
rev64   v4.4s, v4.4s
//mov     v14.16b, v5.16b
add     v1.2d, v1.2d, v6.2d
add     v14.2d, v5.2d, v4.2d
//mov     v11.16b, v10.16b
eor     v13.16b, v13.16b, v1.16b
eor     v11.16b, v10.16b, v14.16b
tbl     v13.16b, {v13.16b}, v15.16b
tbl     v11.16b, {v11.16b}, v15.16b
zip1    v0.2d, v28.2d, v26.2d
zip1    v3.2d, v31.2d, v27.2d
add     v17.2d, v17.2d, v0.2d
add     v17.2d, v17.2d, v13.2d
add     v16.2d, v16.2d, v3.2d
add     v16.2d, v16.2d, v11.2d
eor     v6.16b, v6.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v6.16b, {v6.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v1.2d, v1.2d, v6.2d
add     v14.2d, v14.2d, v4.2d
eor     v13.16b, v13.16b, v1.16b
eor     v11.16b, v11.16b, v14.16b
ushr    v5.2d, v13.2d, #63
sli     v5.2d, v13.2d, #1
ushr    v10.2d, v11.2d, #63
sli     v10.2d, v11.2d, #1
ext     v18.16b, v10.16b, v5.16b, #8
ext     v0.16b, v6.16b, v4.16b, #8
ext     v10.16b, v5.16b, v10.16b, #8
ext     v4.16b, v4.16b, v6.16b, #8
zip2    v3.2d, v27.2d, v29.2d
zip1    v6.2d, v30.2d, v26.2d
add     v17.2d, v17.2d, v3.2d
add     v17.2d, v17.2d, v18.2d
add     v16.2d, v16.2d, v6.2d
add     v16.2d, v16.2d, v10.2d
eor     v0.16b, v0.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v0.4s, v0.4s
rev64   v4.4s, v4.4s
//mov     v13.16b, v1.16b
add     v14.2d, v14.2d, v0.2d
add     v13.2d, v1.2d, v4.2d
//mov     v11.16b, v10.16b
eor     v18.16b, v18.16b, v14.16b
eor     v11.16b, v10.16b, v13.16b
tbl     v18.16b, {v18.16b}, v15.16b
tbl     v11.16b, {v11.16b}, v15.16b
mov     v5.16b, v31.16b
//add     x0, sp, #0x40
//st1     {v28.d}[1], [x0]
mov     v5.d[1], v28.d[1]
add     v17.2d, v17.2d, v5.2d
add     v17.2d, v17.2d, v18.2d
add     v16.2d, v16.2d, v2.2d
add     v16.2d, v16.2d, v11.2d
eor     v0.16b, v0.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v0.16b, {v0.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v14.2d, v14.2d, v0.2d
add     v13.2d, v13.2d, v4.2d
eor     v18.16b, v18.16b, v14.16b
eor     v11.16b, v11.16b, v13.16b
ushr    v1.2d, v18.2d, #63
sli     v1.2d, v18.2d, #1
ushr    v10.2d, v11.2d, #63
sli     v10.2d, v11.2d, #1
mov     v5.16b, v24.16b
ext     v3.16b, v1.16b, v10.16b, #8
ext     v6.16b, v4.16b, v0.16b, #8
ext     v10.16b, v10.16b, v1.16b, #8
mov     v5.d[1], v26.d[1]
ext     v4.16b, v0.16b, v4.16b, #8
mov     d2, v26.d[1]
add     v17.2d, v17.2d, v5.2d
add     v17.2d, v17.2d, v3.2d
mov     v0.16b, v28.16b
mov     v0.d[1], v30.d[1]
add     v16.2d, v16.2d, v0.2d
add     v16.2d, v16.2d, v10.2d
eor     v6.16b, v6.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v6.4s, v6.4s
rev64   v4.4s, v4.4s
//mov     v18.16b, v14.16b
add     v13.2d, v13.2d, v6.2d
add     v18.2d, v14.2d, v4.2d
//mov     v11.16b, v10.16b
eor     v3.16b, v3.16b, v13.16b
eor     v11.16b, v10.16b, v18.16b
tbl     v3.16b, {v3.16b}, v15.16b
tbl     v11.16b, {v11.16b}, v15.16b
ext     v1.16b, v31.16b, v25.16b, #8
add     v17.2d, v17.2d, v1.2d
add     v17.2d, v17.2d, v3.2d
mov     v5.16b, v27.16b
mov     v5.d[1], v25.d[1]
add     v16.2d, v16.2d, v5.2d
add     v16.2d, v16.2d, v11.2d
eor     v6.16b, v6.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v6.16b, {v6.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v13.2d, v13.2d, v6.2d
add     v18.2d, v18.2d, v4.2d
eor     v3.16b, v3.16b, v13.16b
eor     v11.16b, v11.16b, v18.16b
ushr    v14.2d, v3.2d, #63
sli     v14.2d, v3.2d, #1
ushr    v10.2d, v11.2d, #63
sli     v10.2d, v11.2d, #1
ext     v0.16b, v10.16b, v14.16b, #8
ext     v1.16b, v6.16b, v4.16b, #8
ext     v10.16b, v14.16b, v10.16b, #8
ext     v4.16b, v4.16b, v6.16b, #8
zip1    v5.2d, v30.2d, v28.2d
zip1    v6.2d, v31.2d, v27.2d
add     v17.2d, v17.2d, v5.2d
add     v17.2d, v17.2d, v0.2d
add     v16.2d, v16.2d, v6.2d
add     v16.2d, v16.2d, v10.2d
eor     v1.16b, v1.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v1.4s, v1.4s
rev64   v4.4s, v4.4s
//mov     v3.16b, v13.16b
add     v18.2d, v18.2d, v1.2d
add     v3.2d, v13.2d, v4.2d
//mov     v11.16b, v10.16b
eor     v0.16b, v0.16b, v18.16b
eor     v11.16b, v10.16b, v3.16b
tbl     v0.16b, {v0.16b}, v15.16b
tbl     v11.16b, {v11.16b}, v15.16b
zip1    v14.2d, v25.2d, v26.2d
zip2    v5.2d, v26.2d, v30.2d
add     v17.2d, v17.2d, v14.2d
add     v17.2d, v17.2d, v0.2d
add     v16.2d, v16.2d, v5.2d
add     v16.2d, v16.2d, v11.2d
eor     v1.16b, v1.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v1.16b, {v1.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v18.2d, v18.2d, v1.2d
add     v3.2d, v3.2d, v4.2d
eor     v0.16b, v0.16b, v18.16b
eor     v11.16b, v11.16b, v3.16b
ushr    v13.2d, v0.2d, #63
sli     v13.2d, v0.2d, #1
ushr    v10.2d, v11.2d, #63
sli     v10.2d, v11.2d, #1
ext     v6.16b, v13.16b, v10.16b, #8
ext     v14.16b, v4.16b, v1.16b, #8
ext     v10.16b, v10.16b, v13.16b, #8
ext     v4.16b, v1.16b, v4.16b, #8
zip2    v5.2d, v24.2d, v31.2d
mov     v1.16b, v29.16b
mov     v1.d[1], v28.d[1]
add     v17.2d, v17.2d, v1.2d
add     v17.2d, v17.2d, v6.2d
add     v16.2d, v16.2d, v5.2d
add     v16.2d, v16.2d, v10.2d
eor     v14.16b, v14.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v14.4s, v14.4s
rev64   v4.4s, v4.4s
//mov     v0.16b, v18.16b
add     v3.2d, v3.2d, v14.2d
add     v0.2d, v18.2d, v4.2d
//mov     v11.16b, v10.16b
eor     v6.16b, v6.16b, v3.16b
eor     v11.16b, v10.16b, v0.16b
tbl     v6.16b, {v6.16b}, v15.16b
tbl     v11.16b, {v11.16b}, v15.16b
zip2    v13.2d, v25.2d, v29.2d
//mov     d8, v27.d[1]
add     v17.2d, v17.2d, v13.2d
add     v17.2d, v17.2d, v6.2d
mov     v5.16b, v24.16b
mov     v5.d[1], v27.d[1]
add     v16.2d, v16.2d, v5.2d
add     v16.2d, v16.2d, v11.2d
eor     v14.16b, v14.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v14.16b, {v14.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v3.2d, v3.2d, v14.2d
add     v0.2d, v0.2d, v4.2d
eor     v6.16b, v6.16b, v3.16b
eor     v11.16b, v11.16b, v0.16b
ushr    v18.2d, v6.2d, #63
sli     v18.2d, v6.2d, #1
ushr    v10.2d, v11.2d, #63
sli     v10.2d, v11.2d, #1
ext     v1.16b, v10.16b, v18.16b, #8
ext     v13.16b, v14.16b, v4.16b, #8
ext     v10.16b, v18.16b, v10.16b, #8
ext     v4.16b, v4.16b, v14.16b, #8
//mov     d18, v31.d[1]
zip1    v5.2d, v24.2d, v29.2d
mov     v14.16b, v25.16b
mov     v14.d[1], v31.d[1]
add     v17.2d, v17.2d, v14.2d
add     v17.2d, v17.2d, v1.2d
add     v16.2d, v16.2d, v5.2d
add     v16.2d, v16.2d, v10.2d
eor     v13.16b, v13.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v13.4s, v13.4s
rev64   v4.4s, v4.4s
//mov     v6.16b, v3.16b
add     v0.2d, v0.2d, v13.2d
add     v6.2d, v3.2d, v4.2d
//mov     v11.16b, v10.16b
eor     v1.16b, v1.16b, v0.16b
eor     v11.16b, v10.16b, v6.16b
tbl     v1.16b, {v1.16b}, v15.16b
tbl     v11.16b, {v11.16b}, v15.16b
zip2    v18.2d, v29.2d, v24.2d
add     v17.2d, v17.2d, v18.2d
add     v17.2d, v17.2d, v1.2d
ext     v5.16b, v25.16b, v26.16b, #8
add     v16.2d, v16.2d, v5.2d
add     v16.2d, v16.2d, v11.2d
eor     v13.16b, v13.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v13.16b, {v13.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v0.2d, v0.2d, v13.2d
add     v6.2d, v6.2d, v4.2d
eor     v1.16b, v1.16b, v0.16b
eor     v11.16b, v11.16b, v6.16b
ushr    v3.2d, v1.2d, #63
sli     v3.2d, v1.2d, #1
ushr    v10.2d, v11.2d, #63
sli     v10.2d, v11.2d, #1
ext     v14.16b, v3.16b, v10.16b, #8
ext     v18.16b, v4.16b, v13.16b, #8
ext     v10.16b, v10.16b, v3.16b, #8
ext     v4.16b, v13.16b, v4.16b, #8
zip1    v5.2d, v31.2d, v28.2d
add     v17.2d, v17.2d, v5.2d
add     v17.2d, v17.2d, v14.2d
ext     v13.16b, v27.16b, v27.16b, #8
add     v16.2d, v16.2d, v13.2d
add     v16.2d, v16.2d, v10.2d
eor     v18.16b, v18.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v18.4s, v18.4s
rev64   v4.4s, v4.4s
//mov     v1.16b, v0.16b
add     v6.2d, v6.2d, v18.2d
add     v1.2d, v0.2d, v4.2d
//mov     v11.16b, v10.16b
eor     v14.16b, v14.16b, v6.16b
eor     v11.16b, v10.16b, v1.16b
tbl     v14.16b, {v14.16b}, v15.16b
tbl     v11.16b, {v11.16b}, v15.16b
zip2    v3.2d, v28.2d, v30.2d
add     v17.2d, v17.2d, v3.2d
add     v17.2d, v17.2d, v14.2d
mov     v5.16b, v30.16b
mov     v5.d[1], v2.d[0]
add     v16.2d, v16.2d, v5.2d
add     v16.2d, v16.2d, v11.2d
eor     v18.16b, v18.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v18.16b, {v18.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v6.2d, v6.2d, v18.2d
add     v1.2d, v1.2d, v4.2d
eor     v14.16b, v14.16b, v6.16b
eor     v11.16b, v11.16b, v1.16b
ushr    v0.2d, v14.2d, #63
sli     v0.2d, v14.2d, #1
ushr    v10.2d, v11.2d, #63
sli     v10.2d, v11.2d, #1
ext     v13.16b, v10.16b, v0.16b, #8
ext     v3.16b, v18.16b, v4.16b, #8
ext     v10.16b, v0.16b, v10.16b, #8
ext     v4.16b, v4.16b, v18.16b, #8
zip2    v5.2d, v25.2d, v28.2d
add     v17.2d, v17.2d, v5.2d
add     v17.2d, v17.2d, v13.2d
mov     v18.16b, v25.16b
mov     v18.d[1], v30.d[1]
add     v16.2d, v16.2d, v18.2d
add     v16.2d, v16.2d, v10.2d
eor     v3.16b, v3.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v3.4s, v3.4s
rev64   v4.4s, v4.4s
//mov     v14.16b, v6.16b
add     v1.2d, v1.2d, v3.2d
add     v14.2d, v6.2d, v4.2d
//mov     v11.16b, v10.16b
eor     v13.16b, v13.16b, v1.16b
eor     v11.16b, v10.16b, v14.16b
tbl     v13.16b, {v13.16b}, v15.16b
tbl     v11.16b, {v11.16b}, v15.16b
ext     v0.16b, v26.16b, v24.16b, #8
zip2    v5.2d, v31.2d, v27.2d
add     v17.2d, v17.2d, v0.2d
add     v17.2d, v17.2d, v13.2d
add     v16.2d, v16.2d, v5.2d
add     v16.2d, v16.2d, v11.2d
eor     v3.16b, v3.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v3.16b, {v3.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v1.2d, v1.2d, v3.2d
add     v14.2d, v14.2d, v4.2d
eor     v13.16b, v13.16b, v1.16b
eor     v11.16b, v11.16b, v14.16b
ushr    v6.2d, v13.2d, #63
sli     v6.2d, v13.2d, #1
ushr    v10.2d, v11.2d, #63
sli     v10.2d, v11.2d, #1
ext     v18.16b, v6.16b, v10.16b, #8
ext     v5.16b, v4.16b, v3.16b, #8
ext     v10.16b, v10.16b, v6.16b, #8
ext     v4.16b, v3.16b, v4.16b, #8
zip2    v3.2d, v29.2d, v24.2d
zip1    v13.2d, v27.2d, v30.2d
add     v17.2d, v17.2d, v3.2d
add     v17.2d, v17.2d, v18.2d
add     v16.2d, v16.2d, v13.2d
add     v16.2d, v16.2d, v10.2d
eor     v5.16b, v5.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v5.4s, v5.4s
rev64   v4.4s, v4.4s
//mov     v11.16b, v1.16b
add     v14.2d, v14.2d, v5.2d
add     v11.2d, v1.2d, v4.2d
//mov     v6.16b, v10.16b
eor     v18.16b, v18.16b, v14.16b
eor     v6.16b, v10.16b, v11.16b
tbl     v18.16b, {v18.16b}, v15.16b
tbl     v6.16b, {v6.16b}, v15.16b
zip1    v3.2d, v31.2d, v29.2d
zip1    v13.2d, v28.2d, v26.2d
add     v17.2d, v17.2d, v3.2d
add     v17.2d, v17.2d, v18.2d
add     v16.2d, v16.2d, v13.2d
add     v16.2d, v16.2d, v6.2d
eor     v5.16b, v5.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v5.16b, {v5.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v14.2d, v14.2d, v5.2d
add     v11.2d, v11.2d, v4.2d
eor     v18.16b, v18.16b, v14.16b
eor     v6.16b, v6.16b, v11.16b
ushr    v1.2d, v18.2d, #63
sli     v1.2d, v18.2d, #1
ushr    v10.2d, v6.2d, #63
sli     v10.2d, v6.2d, #1
ext     v3.16b, v10.16b, v1.16b, #8
ext     v13.16b, v5.16b, v4.16b, #8
ext     v10.16b, v1.16b, v10.16b, #8
ext     v4.16b, v4.16b, v5.16b, #8
zip1    v5.2d, v28.2d, v24.2d
add     v17.2d, v17.2d, v5.2d
add     v17.2d, v17.2d, v3.2d
ext     v18.16b, v26.16b, v31.16b, #8
add     v16.2d, v16.2d, v18.2d
add     v16.2d, v16.2d, v10.2d
eor     v13.16b, v13.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v13.4s, v13.4s
rev64   v4.4s, v4.4s
//mov     v6.16b, v14.16b
add     v11.2d, v11.2d, v13.2d
add     v6.2d, v14.2d, v4.2d
//mov     v1.16b, v10.16b
eor     v3.16b, v3.16b, v11.16b
eor     v1.16b, v10.16b, v6.16b
tbl     v3.16b, {v3.16b}, v15.16b
tbl     v1.16b, {v1.16b}, v15.16b
zip2    v5.2d, v24.2d, v27.2d
add     v17.2d, v17.2d, v5.2d
add     v17.2d, v17.2d, v3.2d
ext     v18.16b, v30.16b, v27.16b, #8
add     v16.2d, v16.2d, v18.2d
add     v16.2d, v16.2d, v1.2d
eor     v13.16b, v13.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v13.16b, {v13.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v11.2d, v11.2d, v13.2d
add     v6.2d, v6.2d, v4.2d
eor     v3.16b, v3.16b, v11.16b
eor     v1.16b, v1.16b, v6.16b
ushr    v14.2d, v3.2d, #63
sli     v14.2d, v3.2d, #1
ushr    v10.2d, v1.2d, #63
sli     v10.2d, v1.2d, #1
ext     v5.16b, v14.16b, v10.16b, #8
ext     v18.16b, v4.16b, v13.16b, #8
ext     v10.16b, v10.16b, v14.16b, #8
ext     v4.16b, v13.16b, v4.16b, #8
add     v17.2d, v17.2d, v25.2d
add     v17.2d, v17.2d, v5.2d
ext     v13.16b, v31.16b, v26.16b, #8
add     v16.2d, v16.2d, v13.2d
add     v16.2d, v16.2d, v10.2d
eor     v18.16b, v18.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v18.4s, v18.4s
rev64   v4.4s, v4.4s
//mov     v3.16b, v11.16b
add     v6.2d, v6.2d, v18.2d
add     v3.2d, v11.2d, v4.2d
//mov     v1.16b, v10.16b
eor     v5.16b, v5.16b, v6.16b
eor     v1.16b, v10.16b, v3.16b
tbl     v5.16b, {v5.16b}, v15.16b
tbl     v1.16b, {v1.16b}, v15.16b
mov     v14.16b, v30.16b
mov     v14.d[1], v28.d[1]
add     v17.2d, v17.2d, v14.2d
add     v17.2d, v17.2d, v5.2d
add     v16.2d, v16.2d, v29.2d
add     v16.2d, v16.2d, v1.2d
eor     v18.16b, v18.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v18.16b, {v18.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v6.2d, v6.2d, v18.2d
add     v3.2d, v3.2d, v4.2d
eor     v5.16b, v5.16b, v6.16b
eor     v1.16b, v1.16b, v3.16b
ushr    v11.2d, v5.2d, #63
sli     v11.2d, v5.2d, #1
ushr    v10.2d, v1.2d, #63
sli     v10.2d, v1.2d, #1
ext     v13.16b, v10.16b, v11.16b, #8
ext     v14.16b, v18.16b, v4.16b, #8
ext     v10.16b, v11.16b, v10.16b, #8
ext     v4.16b, v4.16b, v18.16b, #8
zip1    v18.2d, v26.2d, v27.2d
zip2    v5.2d, v28.2d, v31.2d
add     v17.2d, v17.2d, v18.2d
add     v17.2d, v17.2d, v13.2d
add     v16.2d, v16.2d, v5.2d
add     v16.2d, v16.2d, v10.2d
eor     v14.16b, v14.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v14.4s, v14.4s
rev64   v4.4s, v4.4s
//mov     v1.16b, v6.16b
add     v3.2d, v3.2d, v14.2d
add     v1.2d, v6.2d, v4.2d
//mov     v11.16b, v10.16b
eor     v13.16b, v13.16b, v3.16b
eor     v11.16b, v10.16b, v1.16b
tbl     v13.16b, {v13.16b}, v15.16b
tbl     v11.16b, {v11.16b}, v15.16b
zip1    v18.2d, v30.2d, v29.2d
add     v17.2d, v17.2d, v18.2d
add     v17.2d, v17.2d, v13.2d
mov     v5.16b, v28.16b
//add     x0, sp, #0x48
//ld1     {v5.d}[1], [x0]
mov     v5.d[1],v29.d[1]
add     v16.2d, v16.2d, v5.2d
add     v16.2d, v16.2d, v11.2d
eor     v14.16b, v14.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v14.16b, {v14.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v3.2d, v3.2d, v14.2d
add     v1.2d, v1.2d, v4.2d
eor     v13.16b, v13.16b, v3.16b
eor     v11.16b, v11.16b, v1.16b
ushr    v6.2d, v13.2d, #63
sli     v6.2d, v13.2d, #1
ushr    v10.2d, v11.2d, #63
sli     v10.2d, v11.2d, #1
ext     v18.16b, v6.16b, v10.16b, #8
ext     v5.16b, v4.16b, v14.16b, #8
ext     v10.16b, v10.16b, v6.16b, #8
ext     v4.16b, v14.16b, v4.16b, #8
zip2    v14.2d, v24.2d, v27.2d
zip2    v13.2d, v30.2d, v25.2d
add     v17.2d, v17.2d, v14.2d
add     v17.2d, v17.2d, v18.2d
add     v16.2d, v16.2d, v13.2d
add     v16.2d, v16.2d, v10.2d
eor     v5.16b, v5.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v5.4s, v5.4s
rev64   v4.4s, v4.4s
//mov     v11.16b, v3.16b
add     v1.2d, v1.2d, v5.2d
add     v11.2d, v3.2d, v4.2d
//mov     v6.16b, v10.16b
eor     v18.16b, v18.16b, v1.16b
eor     v6.16b, v10.16b, v11.16b
tbl     v18.16b, {v18.16b}, v15.16b
tbl     v6.16b, {v6.16b}, v15.16b
zip1    v14.2d, v25.2d, v31.2d
add     v17.2d, v17.2d, v0.2d
add     v17.2d, v17.2d, v18.2d
add     v16.2d, v16.2d, v14.2d
add     v16.2d, v16.2d, v6.2d
eor     v5.16b, v5.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v5.16b, {v5.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v1.2d, v1.2d, v5.2d
add     v11.2d, v11.2d, v4.2d
eor     v18.16b, v18.16b, v1.16b
eor     v6.16b, v6.16b, v11.16b
ushr    v3.2d, v18.2d, #63
sli     v3.2d, v18.2d, #1
ushr    v10.2d, v6.2d, #63
sli     v10.2d, v6.2d, #1
ext     v13.16b, v10.16b, v3.16b, #8
ext     v14.16b, v5.16b, v4.16b, #8
ext     v10.16b, v3.16b, v10.16b, #8
ext     v4.16b, v4.16b, v5.16b, #8
zip1    v18.2d, v31.2d, v30.2d
zip1    v6.2d, v29.2d, v28.2d
add     v17.2d, v17.2d, v18.2d
add     v17.2d, v17.2d, v13.2d
add     v16.2d, v16.2d, v6.2d
add     v16.2d, v16.2d, v10.2d
eor     v14.16b, v14.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v14.4s, v14.4s
rev64   v4.4s, v4.4s
//mov     v3.16b, v1.16b
add     v11.2d, v11.2d, v14.2d
add     v3.2d, v1.2d, v4.2d
//mov     v18.16b, v10.16b
eor     v13.16b, v13.16b, v11.16b
eor     v18.16b, v10.16b, v3.16b
tbl     v13.16b, {v13.16b}, v15.16b
tbl     v18.16b, {v18.16b}, v15.16b
zip2    v31.2d, v31.2d, v30.2d
zip2    v6.2d, v29.2d, v28.2d
add     v17.2d, v17.2d, v31.2d
add     v17.2d, v17.2d, v13.2d
add     v16.2d, v16.2d, v6.2d
add     v16.2d, v16.2d, v18.2d
eor     v14.16b, v14.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v14.16b, {v14.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v11.2d, v11.2d, v14.2d
add     v3.2d, v3.2d, v4.2d
eor     v13.16b, v13.16b, v11.16b
eor     v18.16b, v18.16b, v3.16b
ushr    v1.2d, v13.2d, #63
sli     v1.2d, v13.2d, #1
ushr    v10.2d, v18.2d, #63
sli     v10.2d, v18.2d, #1
ext     v31.16b, v1.16b, v10.16b, #8
ext     v6.16b, v4.16b, v14.16b, #8
ext     v10.16b, v10.16b, v1.16b, #8
ext     v4.16b, v14.16b, v4.16b, #8
zip1    v14.2d, v27.2d, v26.2d
zip1    v13.2d, v25.2d, v24.2d
add     v17.2d, v17.2d, v14.2d
add     v17.2d, v17.2d, v31.2d
add     v16.2d, v16.2d, v13.2d
add     v16.2d, v16.2d, v10.2d
eor     v6.16b, v6.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v6.4s, v6.4s
rev64   v4.4s, v4.4s
//mov     v18.16b, v11.16b
add     v3.2d, v3.2d, v6.2d
add     v18.2d, v11.2d, v4.2d
//mov     v1.16b, v10.16b
eor     v31.16b, v31.16b, v3.16b
eor     v1.16b, v10.16b, v18.16b
tbl     v31.16b, {v31.16b}, v15.16b
tbl     v1.16b, {v1.16b}, v15.16b
zip2    v14.2d, v27.2d, v26.2d
zip2    v13.2d, v25.2d, v24.2d
add     v17.2d, v17.2d, v14.2d
add     v17.2d, v17.2d, v31.2d
add     v16.2d, v16.2d, v13.2d
add     v16.2d, v16.2d, v1.2d
eor     v6.16b, v6.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v6.16b, {v6.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v3.2d, v3.2d, v6.2d
add     v18.2d, v18.2d, v4.2d
eor     v31.16b, v31.16b, v3.16b
eor     v1.16b, v1.16b, v18.16b
ushr    v11.2d, v31.2d, #63
sli     v11.2d, v31.2d, #1
ushr    v10.2d, v1.2d, #63
sli     v10.2d, v1.2d, #1
ext     v31.16b, v10.16b, v11.16b, #8
ext     v1.16b, v6.16b, v4.16b, #8
ext     v10.16b, v11.16b, v10.16b, #8
ext     v4.16b, v4.16b, v6.16b, #8
zip1    v24.2d, v24.2d, v29.2d
zip2    v11.2d, v27.2d, v25.2d
add     v17.2d, v17.2d, v24.2d
add     v17.2d, v17.2d, v31.2d
add     v16.2d, v16.2d, v11.2d
add     v16.2d, v16.2d, v10.2d
eor     v1.16b, v1.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v1.4s, v1.4s
rev64   v4.4s, v4.4s
//mov     v24.16b, v3.16b
add     v18.2d, v18.2d, v1.2d
add     v24.2d, v3.2d, v4.2d
//mov     v11.16b, v10.16b
eor     v31.16b, v31.16b, v18.16b
eor     v11.16b, v10.16b, v24.16b
tbl     v31.16b, {v31.16b}, v15.16b
tbl     v11.16b, {v11.16b}, v15.16b
zip1    v27.2d, v26.2d, v27.2d
add     v17.2d, v17.2d, v27.2d
add     v17.2d, v17.2d, v31.2d
add     v16.2d, v16.2d, v19.2d
add     v16.2d, v16.2d, v11.2d
eor     v1.16b, v1.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v1.16b, {v1.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v18.2d, v18.2d, v1.2d
add     v24.2d, v24.2d, v4.2d
eor     v31.16b, v31.16b, v18.16b
eor     v11.16b, v11.16b, v24.16b
ushr    v3.2d, v31.2d, #63
sli     v3.2d, v31.2d, #1
ushr    v10.2d, v11.2d, #63
sli     v10.2d, v11.2d, #1
ext     v31.16b, v3.16b, v10.16b, #8
ext     v11.16b, v4.16b, v1.16b, #8
ext     v10.16b, v10.16b, v3.16b, #8
ext     v4.16b, v1.16b, v4.16b, #8
zip2    v26.2d, v26.2d, v29.2d
add     v17.2d, v17.2d, v7.2d
add     v17.2d, v17.2d, v31.2d
add     v16.2d, v16.2d, v26.2d
add     v16.2d, v16.2d, v10.2d
eor     v11.16b, v11.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
rev64   v11.4s, v11.4s
rev64   v4.4s, v4.4s
//mov     v3.16b, v18.16b
add     v24.2d, v24.2d, v11.2d
add     v3.2d, v18.2d, v4.2d
//mov     v26.16b, v10.16b
eor     v31.16b, v31.16b, v24.16b
eor     v26.16b, v10.16b, v3.16b
tbl     v31.16b, {v31.16b}, v15.16b
tbl     v26.16b, {v26.16b}, v15.16b
zip1    v25.2d, v25.2d, v30.2d
zip2    v28.2d, v28.2d, v30.2d
add     v17.2d, v17.2d, v25.2d
add     v17.2d, v17.2d, v31.2d
add     v16.2d, v16.2d, v28.2d
add     v16.2d, v16.2d, v26.2d
eor     v11.16b, v11.16b, v17.16b
eor     v4.16b, v4.16b, v16.16b
tbl     v11.16b, {v11.16b}, v12.16b
tbl     v4.16b, {v4.16b}, v12.16b
add     v24.2d, v24.2d, v11.2d
add     v3.2d, v3.2d, v4.2d
eor     v31.16b, v31.16b, v24.16b
eor     v26.16b, v26.16b, v3.16b
ushr    v18.2d, v31.2d, #63
sli     v18.2d, v31.2d, #1
ushr    v10.2d, v26.2d, #63
sli     v10.2d, v26.2d, #1
eor     v3.16b, v17.16b, v3.16b
eor     v24.16b, v16.16b, v24.16b
eor     v3.16b, v3.16b, v23.16b
eor     v24.16b, v24.16b, v22.16b
stp     q3, q24, [x2]
ext     v3.16b, v10.16b, v18.16b, #8
ext     v24.16b, v11.16b, v4.16b, #8
ext     v10.16b, v18.16b, v10.16b, #8
ext     v4.16b, v4.16b, v11.16b, #8
eor     v24.16b, v3.16b, v24.16b
eor     v4.16b, v10.16b, v4.16b
eor     v24.16b, v24.16b, v21.16b
eor     v4.16b, v4.16b, v20.16b
stp     q24, q4, [x2, #32]
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