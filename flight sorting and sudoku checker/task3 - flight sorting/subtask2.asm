; write the structures
struc flight
	destination: resb 32
	departingTime.day: resb 1
	departingTime.hour: resb 1
	departingTime.minutes: resb 1
	arrivingTime.day: resb 1
	arrivingTime.hour: resb 1
	arrivingTime.minutes: resb 1
	bag_weight: resw 1
	delayMinutes: resb 1
	delayHours: resb 1
endstruc


section .text

;; DO NOT MODIFY
global filter_flights

; void filter_flights(struct flight* origFlights, struct flight* finalFlights
;						 int* nrFlights, int min_bag_weight)
; rdi = struct flight *origFlights
; rsi = struct flight *finalFlights
; rdx = int *nrFlights
; rcx = int min_bag_weight
filter_flights:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here


	;; I stayed 2 hours just debugging because
	;; the mul changed rdx even if the product
	;; could fit in rax
	;; I didn't know since in task 4 I used it
	;; and didn't have any problems
	;; It just so happens that in task 4
	;; if the sudoku board was not good
	;; it always had a mistake in either row 0 or col 0
	;; and because I was always checking row and col 0
	;; instead of all the rows and columns
	;; I got full marks (now I changed it)

	;; r9 = final number of flights
	xor r9, r9

	xor rbx, rbx
	;; rbx = for loop counter
for_loop1:
	;; rax = rbx * 42 (offset for each element in array)
	mov rax, 42
	push rdx
	mul rbx
	pop rdx
	;; r8 = pointer to the "rbx"-th original flight
	lea r8, [rdi + rax]
	cmp word [r8 + bag_weight], cx
	jl continue1

	;; rax = pointer to next struct in final flights
	mov rax, 42
	push rdx
	mul r9
	pop rdx
	add rax, rsi
	xor r11, r11
	;; r11 copy struct loop counter
	;; copy_struct copies the struct in groups of 2 bytes
	;; for 21 times (2 * 21 = size of struct)
copy_struct:
	;; the bytes of the original flight
	mov r10w, [r8 + 2 * r11]
	;; the bytes of the final flight
	mov [rax + 2 * r11], r10w

	inc r11
	;; 21 * 2 = 42
	cmp r11, 21
	jne copy_struct

	inc r9

continue1:
	inc rbx
	cmp ebx, dword [rdx]
	jne for_loop1

	mov [rdx], r9d

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

	leave
	ret