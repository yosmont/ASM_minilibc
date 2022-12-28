BITS 64

SECTION .text
    GLOBAL strcmp:function

strcmp:
    push rcx
    xor rcx, rcx
    push rdi
    push rsi
    push r15
strcmp_loop:
    mov r15b, [rsi]
    cmp [rdi], r15b
    jne strcmp_nomatch
    cmp [rdi], byte 0
    je strcmp_prereturn
    cmp [rsi], byte 0
    je strcmp_prereturn
    inc rdi
    inc rsi
    jmp strcmp_loop
strcmp_nomatch:
    mov al, [rdi]
    sub al, [rsi]
    movsx rax, al
strcmp_return:
    pop r15
    pop rsi
    pop rdi
    pop rcx
    ret
strcmp_prereturn:
    mov rax, rcx
    jmp strcmp_return