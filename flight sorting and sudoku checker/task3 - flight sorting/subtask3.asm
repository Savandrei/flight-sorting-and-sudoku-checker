; write the structure
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
global sort_and_return

; int sort_and_return(struct flight* flights, int nrFlights, 
;                      struct flight* bestFlight, char destination[32])
; rdi = flights (pointer)
; rsi = nrFlights (value)
; rdx = bestFlight (pointer to pre-allocated struct)
; rcx = destination (pointer to 32-byte string)
sort_and_return:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	mov rbx, 1 ;; first loop counter
	xor r8, r8 ;; second loop counter
	xor r9, r9 ;; best flight index

;; selection sort
sort_for_loop:
	mov r9, rbx
	dec r9
	mov r8, rbx

sort_nested_loop:
	push rdx
	;; size of struct = 42
	mov rax, 42
	mul r8
	mov r13, rax ;; r13 = flights[r8]
	;; size of struct = 42
	mov rax, 42
	mul r9 ;; rax = flights[r9]
	pop rdx
	;; if conditions
	mov r10b, [rdi + rax + arrivingTime.day]
	cmp [rdi + r13 + arrivingTime.day], r10b
	jl modify_best_flight_index
	jg end_nested_loop

	mov r10b, [rdi + rax + arrivingTime.hour]
	cmp [rdi + r13 + arrivingTime.hour], r10b
	jl modify_best_flight_index
	jg end_nested_loop

	mov r10b, [rdi + rax + arrivingTime.minutes]
	cmp [rdi + r13 + arrivingTime.minutes], r10b
	jl modify_best_flight_index
	jg end_nested_loop

	mov r10w, [rdi + rax + bag_weight]
	cmp [rdi + r13 + bag_weight], r10w
	jg modify_best_flight_index

	jmp end_nested_loop

modify_best_flight_index:
	mov r9, r8

end_nested_loop:
	inc r8
	cmp r8, rsi
	jne sort_nested_loop

	jmp makeshift_swap

end_sort_for_loop:
	inc rbx
	cmp rbx, rsi
	jne sort_for_loop
	jmp end_sort

;; swaps struct at position r8 with the one on position r9
;; 3 buckets method, rdx is the 3rd bucket
makeshift_swap:
	push rdx
	xor r10, r10 ;; for loop counter
	;; size of struct = 42
	mov rax, 42
	mul rbx
	;; rbx is indexed from 1 instead of 0
	sub rax, 42
	add rax, rdi
	mov r12, rax ;; r12 pointer to rbx struct
	;; size of struct = 42
	mov rax, 42
	mul r9
	add rax, rdi ;; rax pointer to r9 struct
	pop rdx

;; r9 struct copied in rdx
swap_for_loop1:
	;; the bytes of flights[r9]
	mov r11w, [rax + 2 * r10]
	;; the bytes of the flight in rdx
	mov [rdx + 2 * r10], r11w
	inc r10
	;; size of struct = 2 * 21 = 42
	cmp r10, 21
	jne swap_for_loop1

	xor r10, r10
;; moves rbx struct into r9 struct
swap_for_loop2:
	;; the bytes of flights[rbx]
	mov r11w, [r12 + 2 * r10]
	;; the bytes of flights[r9]
	mov [rax + 2 * r10], r11w
	inc r10
	;; size of struct = 2 * 21 = 42
	cmp r10, 21
	jne swap_for_loop2

	xor r10, r10
;; rdx struct copied onto rbx struct
swap_for_loop3:
	;; the bytes of the flight in rdx
	mov r11w, [rdx + 2 * r10]
	;; the bytes of flights[rbx]
	mov [r12 + 2 * r10], r11w
	inc r10
	;; size of struct = 2 * 21 = 42
	cmp r10, 21
	jne swap_for_loop3


	jmp end_sort_for_loop

end_sort:

	xor rbx, rbx ;; rbx for loop counter
flight_name_loop:

	push rdx
	;; size of struct = 42
	mov rax, 42
	mul rbx
	add rax, rdi ;; rax pointer to struct (flights[rbx])
	pop rdx

makeshift_strcmp:
	xor r8, r8 ;; r8 strcmp for loop counter
strcmp_for_loop:
	mov r9b, [rax + r8+ destination]
	cmp [rcx + r8], r9b
	jne strings_not_equal

	;; if character is null terminator
	cmp r9b, 0
	je flight_found

	inc r8
	;; string size = 32
	cmp r8, 32
	jne strcmp_for_loop
	jmp flight_found

strings_not_equal:
	inc rbx
	cmp rbx, rsi
	jne flight_name_loop
	jmp flight_not_found




flight_found:
	xor r9, r9

loop_copy_struct_to_rdx:
	;; the bytes of the best flight
	mov r11w, [rax + r9 * 2]
	;; the bytes of the flight in rdx
	mov [rdx + r9 * 2], r11w
	inc r9
	;; size of struct = 2 * 21 = 42
	cmp r9, 21
	jne loop_copy_struct_to_rdx
	;; rax = 1 , flight found
	mov rax, 1
	jmp end_subtask3

flight_not_found:
	;; rax = 0 (self explanaory from function name)
	mov rax, 0

end_subtask3:

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