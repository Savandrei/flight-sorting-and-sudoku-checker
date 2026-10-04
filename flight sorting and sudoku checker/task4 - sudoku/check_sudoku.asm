section .text

;; DO NOT MODIFY
global check_column
global check_row
global check_box

; int check_row(int **array, int size, int rowNr)
; rdi = int **array
; rsi = int size
; rdx = int rowNr
check_row:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	mov rcx, rsi
	;; rax = 1 (for product)
	mov rax, 1
	push rdx
factorial1:
	mul rcx
	loop factorial1
	mov rbx, rax
	pop rdx

	mov rcx, rsi
	;; rax = 1 (for product)
	mov rax, 1
	;; pointer to the row
	mov r8, [rdi + 8 * rdx]
	xor r9, r9
	push rdx
multiply_and_sum_row:
	;; rax = product of each element in the row
	mul dword [r8 + rcx * 4 - 4]
	;; r9 = sum of each element in the row
	add r9d, [r8 + rcx * 4 - 4]
	loop multiply_and_sum_row
	pop rdx

	cmp  rbx, rax
	jne row_not_ok

gauss:
	mov rax, rsi
	mov rbx, rsi
	inc rbx
	mul rbx
	;; division by 2
	shr rax, 1

	cmp rax, r9
	jne row_not_ok

row_ok:
	;; rax = 1 (output)
	mov rax, 1
	jmp finish_row_check


row_not_ok:
	xor rax, rax

finish_row_check:

	;; Your code ends here
	;; DO NOT MODIFY
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
	;; DO NOT MODIFY

;; DO NOT MODIFY
; int check_column(int **array, int size, int columnNr)
; rdi = int **array
; rsi = int size
; rdx = int columnNr
check_column:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	mov rcx, rsi
	;; rax = 1 (for product)
	mov rax, 1
	push rdx
factorial2:
	mul rcx
	loop factorial2
	mov rbx, rax
	pop rdx

	mov rcx, rsi
	;; rax = 1 (for product)
	mov rax, 1
	xor r9, r9

multiply_and_sum_column:
	;; pointer to the row
	mov r8, [rdi + 8 * rcx - 8]
	push rdx
	;; rax = product of each element in the row
	mul dword [r8 + rdx * 4]
	pop rdx
	;; r9 = sum of each element in the row
	add r9d, [r8 + rdx * 4]
	loop multiply_and_sum_column

	cmp  rbx, rax
	jne column_not_ok

gauss2:
	mov rax, rsi
	mov rbx, rsi
	inc rbx
	mul rbx
	;; division by 2
	shr rax, 1

	cmp rax, r9
	jne column_not_ok

column_ok:
	;; rax = 1 (output)
	mov rax, 1
	jmp finish_column_check


column_not_ok:
	xor rax, rax

finish_column_check:

	;; Your code ends here
	;; DO NOT MODIFY
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
	;; DO NOT MODIFY

;; DO NOT MODIFY
; int check_box(int **array, int size, int boxNr)
; rdi = int **array
; rsi = int size
; rdx = int boxNr
check_box:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	;; rbx = box size
	cmp rsi, 4
	jne compare_9
	;; box size = 2
	mov rbx, 2
	jmp end_board_size
compare_9:
	;; if board size = 9
	cmp rsi, 9
	jne compare_16
	;; box size = 3
	mov rbx, 3
	jmp end_board_size

compare_16:
	;; box size = 4
	mov rbx, 4

end_board_size:
	xor r8, r8
	xor r9, r9

	;; r8 = starting row of box
	;; r9 = starting column of box
row_of_box:
	cmp rdx, rbx
	jle col_of_box
	sub rdx, rbx
	inc r8
	jmp row_of_box

col_of_box:
	mov rax, rdx
	dec rax
	push rdx
	mul rbx
	pop rdx
	mov r9, rax

sum_and_product_of_box:
	;; r10 is 'i' in for loop(rows)
	;; r11 is 'j' in for loop(colums)
	xor r10, r10
	xor r11, r11
	xor r12, r12
	;; rax = 1 (for product)
	mov rax, 1

for_loop_rows:
	;; rcx = pointer to the row
	mov rcx, [rdi + r10 * 8]

for_loop_columns:
	;; r12 = sum of box
	add r12d, [rcx + r11 * 4]
	;; rax = product of box
	mul dword [rcx + r11 * 4]

	inc r11
	cmp r11, rbx
	jne for_loop_columns

	xor r11, r11
	inc r10
	cmp r10, rbx
	jne for_loop_rows

	;; r8 = sum
	;; r9 = product
	mov r8, r12
	mov r9, rax


	mov rcx, rsi
	;; rax = 1 (for product)
	mov rax, 1
factorial3:
	mul rcx
	loop factorial3
	mov rbx, rax

	cmp  rbx, r9
	jne box_not_okay

gauss3:
	mov rax, rsi
	mov rbx, rsi
	inc rbx
	mul rbx
	;; division by 2
	shr rax, 1

	cmp rax, r8
	jne column_not_ok

box_okay:
	;; rax = 1 (output)
	mov rax, 1
	jmp finish_box_check

box_not_okay:
	xor rax, rax


finish_box_check:

	;; Your code ends here
	;; DO NOT MODIFY
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
