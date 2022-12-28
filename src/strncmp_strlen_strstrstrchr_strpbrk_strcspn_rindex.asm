BITS 64

SECTION .text
    GLOBAL strncmp:function
    GLOBAL strlen:function
    GLOBAL strstr:function
    GLOBAL strchr:function
    GLOBAL strpbrk:function
    GLOBAL strcspn:function
    GLOBAL rindex:function

strncmp:
    push rcx
    xor rcx, rcx
    inc rcx
    push r11
    xor r11, r11
    push rdi
    push rsi
    push r15
strncmp_loop:
    mov r15b, [rsi]
    cmp [rdi], r15b
    jne strncmp_nomatch
    cmp [rdi], byte 0
    je strncmp_return
    cmp [rsi], byte 0
    je strncmp_return
    cmp rcx, rdx
    je strncmp_return
    inc rdi
    inc rsi
    inc rcx
    jmp strncmp_loop
strncmp_nomatch:
    mov al, [rdi]
    sub al, [rsi]
    movsx rax, al
strncmp_return:
    pop r15
    pop rsi
    pop rdi
    pop r11
    pop rcx
    ret
strncmp_prereturn:
    mov rax, r11
    jmp strncmp_return

strlen:
    push rcx
    xor rcx, rcx
    push rdi
strlen_loop:
    cmp [rdi], byte 0
    jz strlen_end
    inc rcx
    inc rdi
    jmp strlen_loop
strlen_end:
    pop rdi
    mov rax, rcx
    pop rcx
    ret

strstr:
    push rdi
    push r11
strstr_loop:
    push rdx
    xor rax, rax
    mov r11, rdi
    mov rdi, rsi
    call strlen
    mov rdi, r11
    mov rdx, rax
    call strncmp
    pop rdx
    cmp rax, 0
    je strstr_return
    inc rdi
    cmp [rdi], byte 0
    jne strstr_loop
strstr_notfound:
    mov rdi, 0
strstr_return:
    pop r11
    mov rax, rdi
    pop rdi
    ret

strchr:
    push rdi
strchr_loop:
    cmp [rdi], sil
    je strchr_return
    inc rdi
    cmp [rdi], byte 0
    jne strchr_loop
strchr_notfound:
    mov [rdi], byte 0
strchr_return:
    mov rax, rdi
    pop rdi
    ret

strpbrk:
    push rdi
    push r11
    push rsi
    mov r11, rdi
    mov rdi, rsi
    mov rsi, r11
    mov r11, rsi
strpbrk_loop:
    mov rsi, [r11]
    call strchr
    cmp rax, 0
    jne strpbrk_return
    inc r11
    cmp r11, byte 0
    jne strpbrk_loop
strpbrk_notfound:
    mov r11, 0
strpbrk_return:
    mov rax, r11
    pop rsi
    pop r11
    pop rdi
    ret

strcspn:
    cmp rdi, 0
    je strcspn_null
    cmp rsi, 0
    je strcspn_null
    cmp [rdi], byte 0
    je strcspn_empty
    cmp [rsi], byte 0
    je strcspn_empty
    push r11
    push rdi
    push rsi
    mov r11, rdi
    mov rdi, rsi
    mov rsi, r11
    mov r11, rsi
strcspn_loop:
    mov rsi, [r11]
    call strchr
    cmp rax, 0
    jne strcspn_return
    inc r11
    cmp r11, byte 0
    jne strcspn_loop
strcspn_notfound:
    mov r11, 0
strcspn_return:
    pop rsi
    pop rdi
    push rcx
    mov rcx, [r11]
    mov [r11], byte 0
    call strlen
    mov [r11], rcx
    pop rcx
    pop r11
    ret
strcspn_null:
    mov rax, 0
    ret
strcspn_empty:
    call strlen
    ret

rindex:
    push rdi
    push rcx
    call strlen
    dec rax
    add rdi, rax
rindex_loop:
    cmp [rdi], sil
    je rindex_return
    dec rdi
    inc rcx
    cmp rcx, rdx
    jne rindex_loop
rindex_notfound:
    mov rdi, 0
rindex_return:
    pop rcx
    mov rax, rdi
    pop rdi
    ret