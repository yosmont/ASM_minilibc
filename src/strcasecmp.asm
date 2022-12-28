BITS 64

SECTION .text
    GLOBAL strcasecmp:function

strcasecmp:
    push rcx
    xor rcx, rcx
    push rdi
    push rsi
    push r15
strcasecmp_loop:
    mov r15b, [rsi]
    cmp [rdi], r15b
    jne strcasecmp_cmpcase
strcasecmp_loop_continu:
    cmp [rdi], byte 0
    je strcasecmp_return
    cmp [rsi], byte 0
    je strcasecmp_return
    inc rdi
    inc rsi
    jmp strcasecmp_loop
strcasecmp_nomatch:
    mov al, [rdi]
    sub al, [rsi]
    movsx rax, al
strcasecmp_return:
    pop r15
    pop rsi
    pop rdi
    pop rcx
    ret
strcasecmp_prereturn:
    mov rax, rcx
    jmp strcasecmp_return

strcasecmp_cmpcase:
    mov r15b, [rsi]
    sub r15b, byte 32
    cmp [rdi], r15b
    je strcasecmp_loop_continu
    mov r15b, [rsi]
    cmp r15b, byte 90
    jg strcasecmp_nomatch
    add r15b, byte 32
    cmp [rdi], r15b
    je strcasecmp_loop_continu
    jmp strcasecmp_nomatch
