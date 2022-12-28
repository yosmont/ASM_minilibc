BITS 64

SECTION .text
    GLOBAL memcpy:function

memcpy:
    push rcx
    xor rcx, rcx
    push r11
    xor r11, r11
    push rdi
    push rsi
memcpy_loop:
    cmp rcx, rdx
    jge memcpy_return
    mov r11b, [rsi]
    mov [rdi], r11b
    inc rcx
    inc rdi
    inc rsi
    jmp memcpy_loop
memcpy_return:
    pop rsi
    pop rdi
    mov rax, rdi
    pop r11
    pop rcx
    ret