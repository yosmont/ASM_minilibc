BITS 64

SECTION .text
    GLOBAL memset:function

memset:
    push rcx
    xor rcx, rcx
    push rdi
memset_loop:
    cmp rcx, rdx
    jge memset_return
    mov [rdi], sil
    inc rcx
    inc rdi
    jmp memset_loop
memset_return:
    pop rdi
    mov rax, rdi
    pop rcx
    ret