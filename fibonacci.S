// fibonacci.S
    .text
    .globl _main
    .align 2
_main:
    // fpとlrをスタックへ退避
    stp fp, lr, [sp, -16]!

    // 適当な数字を printf で出力
    // 可変長引数はスタックに積む
    adr x0, printf_fmt
    mov x2, 4649
    str x2, [SP, -16]!
    bl _printf
    add SP, SP, 16

    // fpとlrをスタックから復元
    ldp fp, lr, [sp], 16 // pop {fp, lr}

    // exit
    mov x0, 0  // return code
    mov x16, 1 // terminate = 1
    svc 0x80

printf_fmt: .asciz "%d\n"
