section .text

;; DO NOT MODIFY
global fix_lap_times


fix_lap_times:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; YOUR CODE STARTS HERE

	xor rbx, rbx
for_loop1:
	;;rbx used as for loop counter indexed from 1
	inc rbx
	;; elements in error array
	cmp byte [rsi + rbx - 1], 0
	je if_not_error
	inc qword[r8]
	;;if first element
	cmp rbx, 1
	jne skip_first_element_condition

	;;second element in lap time
	mov eax, dword [rdi + 4]
	mov dword [rcx], eax
	jmp skip_loop1

skip_first_element_condition:
	;;if last element
	cmp rbx, rdx
	jne skip_last_element_condition

	;;second to last element in lap time array
	mov eax , dword [rdi + 4 * rdx - 8]
	;;last element in rectified lap time array
	mov [rcx + 4 * rdx - 4], eax
	jmp skip_loop1

skip_last_element_condition:
	;;the element to the left in lap time array
	mov eax, dword [rdi + 4 * rbx - 8]
	;;the element in the rectified lap time array
	mov [rcx + 4 * rbx - 4], eax
	;;the element to the right in lap time array
	mov eax, dword [rdi + 4 * rbx]
	;;gets added to the element in the rectified lap time array
	add [rcx + 4 * rbx - 4], eax
	;;the element in the rectified lap time array is divided by 2
	shr dword [rcx + 4 * rbx - 4], 1
	jmp skip_loop1

if_not_error:
	;;the element in the lap time array
	mov eax, dword [rdi + 4 * rbx - 4]
	;;the element in the rectified lap time array
	mov [rcx + 4 * rbx - 4], eax

skip_loop1:
	cmp rbx, rdx
	jne for_loop1



	;; YOUR CODE ENDS HERE
	;; DO NOT MODIFY
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
	;; DO NOT MODIFY