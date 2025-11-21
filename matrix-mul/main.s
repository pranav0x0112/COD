.data
mat1: .byte 1,1,1,2,2,2,3,3,3
mat2: .byte 4,4,4,5,5,5,6,6,6
mat3: .zero 9

.text
.globl _start
_start:
    la x10, mat1          # mat1 base
    la x11, mat2          # mat2 base
    la x12, mat3          # mat3 base

    li x19, 3             # N = 3
    li x20, 0             # i = 0

outer_row:
    li x21, 0             # j = 0

outer_col:
    li x18, 0             # accumulator = 0
    li x22, 0             # k = 0

inner:
    # mat1[i][k]
    mul x14, x20, x19     # i*N
    add x14, x14, x22     # i*N + k
    add x13, x10, x14     # mat1 + (i*N + k)
    lb x15, 0(x13)

    # mat2[k][j]
    mul x14, x22, x19     # k*N
    add x14, x14, x21     # k*N + j
    add x13, x11, x14     # mat2 + (k*N + j)
    lb x16, 0(x13)

    mul x17, x15, x16
    add x18, x18, x17

    addi x22, x22, 1
    blt x22, x19, inner

    # store result at mat3[i][j]
    mul x14, x20, x19
    add x14, x14, x21
    add x13, x12, x14
    sb x18, 0(x13)

    addi x21, x21, 1
    blt x21, x19, outer_col

    addi x20, x20, 1
    blt x20, x19, outer_row

done:
    nop