// fibonacci.S

    .text
    .globl _main
    .align 2
_main:
    // fpとlrをスタックへ退避
    stp fp, lr, [sp, -16]!

    // fib(10) を求める
    mov x0, 10
    bl fibonacci
    bl print_int

    // fpとlrをスタックから復元
    ldp fp, lr, [sp], 16 // pop {fp, lr}

    // exit
    mov x0, 0  // return code
    mov x16, 1 // terminate = 1
    svc 0x80

fibonacci:
    stp fp, lr, [sp, -16]! // fpとlrをスタックへ退避
    str x19, [sp, -16]! // x19をスタックへ退避
    str x20, [sp, -16]! // x20をスタックへ退避
    str x21, [sp, -16]! // x21をスタックへ退避

    mov x19, x0 // nの値をx19へ退避

    mov x1, 1
    cmp x0, x1
    bgt greater_than_1
    beq eq_1
smaller_than_1: // x < 1
    mov x0, 0
    b fibonacci_fin
eq_1: // x = 1
    mov x0, 1
    b fibonacci_fin
greater_than_1: // x > 1
    mov x20, 0
    mov x21, 0

    // x20 = fib(n-1)
    sub x0, x19, 1
    bl fibonacci
    mov x20, x0

    // x21 = fib(n-2)
    sub x0, x19, 2
    bl fibonacci
    mov x21, x0

    // result(x0) = x20 + x21
    add x0, xzr, x20
    add x0, x0, x21
fibonacci_fin:
    ldr x21, [sp], 16 // x21をスタックから復元
    ldr x20, [sp], 16 // x20をスタックから復元
    ldr x19, [sp], 16 // x19をスタックから復元
    ldp fp, lr, [sp], 16 // fpとlrをスタックから復元
    ret

print_int:
    stp fp, lr, [sp, -16]! // fpとlrをスタックへ退避
    mov x2, x0
    str x2, [SP, -16]!     // 出力する数値をスタックへ積む
    adr x0, printf_fmt     // フォーマット文字列
    bl _printf
    add SP, SP, 16         // スタックをクリア
    ldp fp, lr, [sp], 16   // fpとlrをスタックから復元
    ret

printf_fmt: .asciz "%d\n"
