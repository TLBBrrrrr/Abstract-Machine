.globl _start
.type _start, @function

_start:
  li $sp, 0x0001fffc
  jal main

.globl _qemu
_qemu:
  nop
  jal main
