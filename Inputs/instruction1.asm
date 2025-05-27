addi x1, x0, 11
addi x2, x0, 14
add  x3, x1, x2
sll  x4, x1, x2
bne  x1, x2, loop
loop:
sb   x1, 0(x0)
lb   x8, 0(x0)
addi x5, x0, 31
and  x7, x1, x2
ori  x6, x1, 15
bne  x0, x0, Exit
Exit:
