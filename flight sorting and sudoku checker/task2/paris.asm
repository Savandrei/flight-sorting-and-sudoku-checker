; you can declare any helper variables in .data or .bss

section .text

;; DO NOT MODIFY
global solve_labyrinth

solve_labyrinth:
	push    rbp
	mov     rbp, rsp
	push    rbx
	push    r12
	push    r13
	push    r14
	push    r15

	mov     r12, rdi
	mov     r13, rsi
	mov     r14, rdx
	mov     r15, rcx
	mov     rbx, r8
	;; DO NOT MODIFY
	;; YOUR CODE STARTS HERE

	xor rdi, rdi
	xor rsi, rsi

check_exit:
	mov rax, rdi
	inc rax
	cmp rax, rdx
	je finish

	mov rax, rsi
	inc rax
	cmp rax, rcx
	je finish

check_right:
	;;maze[i]
	mov rax, [r8 + rdi * 8]
	;;maze[i][j + 1]
	cmp byte [rax + rsi + 1], 0x31
	je check_down
	;;maze[i][j + 1] = 1
	mov byte [rax + rsi + 1], 0x31
	inc rsi
	jmp check_exit

check_down:
	;;maze[i + 1]
	mov rax, [r8 + rdi * 8 + 8]
	;;maze[i + 1][j]
	cmp byte [rax + rsi], 0x31
	je check_left
	;;maze[i + 1][j] = 1
	mov byte [rax + rsi], 0x31
	inc rdi
	jmp check_exit

check_left:
	;;maze[i]
	mov rax, [r8 + rdi * 8]
	;;maze[i][j - 1]
	cmp byte [rax + rsi - 1], 0x31
	je check_up
	;;maze[i][j - 1] = 1
	mov byte [rax + rsi - 1], 0x31
	dec rsi
	jmp check_exit

check_up:
	;;maze[i - 1]
	mov rax, [r8 + rdi * 8 - 8]
	;;maze[i - 1][j] = 1
	mov byte [rax + rsi], 0x31

	dec rdi
	jmp check_exit

finish:
	mov [r12], edi
	mov [r13], esi

	;; YOUR CODE ENDS HERE
	;; DO NOT MODIFY
	pop     r15
	pop     r14
	pop     r13
	pop     r12
	pop     rbx
	pop     rbp
	ret
	;; DO NOT MODIFY