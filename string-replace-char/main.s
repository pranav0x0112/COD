.data
str:    .asciz "hello world"
target: .asciz 'o'
repl:   .asciz 'a'

.text
.globl _start
_start:
    la t0, str          # pointer to the string
    la t1, target
    lb t2, 0(t1)        # target character
    la t1, repl
    lb t3, 0(t1)        # replacement character

loop:
    lb t4, 0(t0)        # t4 = current character
    beq t4, x0, done    # stop at null terminator

    bne t4, t2, skip    # if not equal, continue
    sb t3, 0(t0)        # overwrite with replacement

skip:
    addi t0, t0, 1      # move to next byte
    j loop

done:
    nop