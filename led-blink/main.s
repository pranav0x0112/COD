.text
.globl _start

_start:
    li t0, 0x10000000     # LED address
    li t1, 1              # ON value
    li t2, 0              # OFF value

loop:
    # turn LED on
    sb t1, 0(t0)

    # delay 1
    li t3, 2000000
delay1:
    addi t3, t3, -1
    beq t3, x0, done_delay1
    j delay1
done_delay1:

    # turn LED off
    sb t2, 0(t0)

    # delay 2
    li t3, 2000000
delay2:
    addi t3, t3, -1
    beq t3, x0, done_delay2
    j delay2
done_delay2:

    j loop