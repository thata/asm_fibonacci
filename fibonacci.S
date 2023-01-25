// fibonacci.S

    .text
    .globl _main
    .align 2
_main:
    mov x0, 0  // return 0
    mov x16, 1 // 1 = terminate
    svc 0x80
