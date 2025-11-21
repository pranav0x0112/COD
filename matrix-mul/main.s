.data
mat1: .byte 1,1,1,2,2,2,3,3,3      # 3x3 matrix 1 (row-major)
mat2: .byte 4,4,4,5,5,5,6,6,6      # 3x3 matrix 2 (row-major)
mat3: .zero 9                      # 3x3 result matrix (9 bytes)

.text
.globl _start
_start:
    la x10, mat1       # x10 = base address of mat1
    la x11, mat2       # x11 = base address of mat2
    la x12, mat3       # x12 = base address of mat3

    li x19, 3          # N = 3 (matrix size)
    li x20, 0          # i = 0 (row index)

# ------------------------------------
# outer_row loop: iterate over rows (i)
# ------------------------------------
outer_row:
    li x21, 0          # j = 0 (column index)

# --------------------------------------
# outer_col loop: iterate over columns (j)
# --------------------------------------
outer_col:
    li x18, 0          # accumulator = 0 (for C[i][j])
    li x22, 0          # k = 0 (inner index)

# ------------------------------------------
# inner loop: compute sum(mat1[i][k] * mat2[k][j])
# ------------------------------------------
inner:
    # load mat1[i][k]
    mul x14, x20, x19              # i * N
    add x14, x14, x22              # i*N + k
    add x13, x13, x14              # mat1 + (i*N + k)
    lb x15, 0(x13)                 # x15 = mat1[i][k]

    # load mat2[k][j]
    mul x14, x22, x19              # k * N
    add x14, x14, x21              # k*N + j
    add x13, x13, x14              # mat2 + (k*N + j)
    lb x16, 0(x13)                 # x16 = mat2[k][j]

    # accumulator += mat1 * mat2
    mul x17, x15, x16
    add x18, x18, x17

    # k++
    addi x22, x22, 1
    blt x22, x19, inner            # repeat while k < N

    # store C[i][j]
    mul x14, x20, x19              # i * N
    add x14, x14, x21              # i*N + j
    add x13, x13, x14              # &mat3[i][j]
    sb x18, 0(x13)                 # store result byte

    # j++
    addi x21, x21, 1
    blt x21, x19, outer_col        # continue cols

    # i++
    addi x20, x20, 1
    blt x20, x19, outer_row        # continue rows

done:
    nop