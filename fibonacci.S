// fibonacci.S
    .text
    .globl _main
    .align 2
_main:
    // fpとlrをスタックへ退避
    stp fp, lr, [sp, -16]!

    // 適当な数字を出力
    mov x0, 4649
    bl print_int

    // fpとlrをスタックから復元
    ldp fp, lr, [sp], 16 // pop {fp, lr}

    // exit
    mov x0, 0  // return code
    mov x16, 1 // terminate = 1
    svc 0x80

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
