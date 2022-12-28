BITS 64

SECTION .text
    GLOBAL memmove:function

memmove:
    push rcx
    push r8
    mov rax, rdi
    mov r8, rdi
    sub r8, rsi
    cmp r8, 0
    jge memmove_right
memmove_left:
    xor rcx, rcx
memmove_loop_left:
    cmp rcx, rdx
    je memmove_return
    mov r8b, [rsi]
    mov [rdi], r8b
    inc rsi
    inc rdi
    inc rcx
    jmp memmove_loop_left
memmove_right:
    dec rdx
    add rdi, rdx
    add rsi, rdx
memmove_loop_right:
    cmp rdx, 0
    jl memmove_return
    mov r8b, [rsi]
    mov [rdi], r8b
    dec rsi
    dec rdi
    dec rdx
    jmp memmove_loop_right
memmove_return:
    pop r8
    pop rcx
    ret