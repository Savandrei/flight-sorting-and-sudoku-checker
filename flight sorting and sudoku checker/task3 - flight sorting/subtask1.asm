; write the structures. make sure it fits the layour in the README
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
global apply_delay

; void apply_delay(struct flight* flights, int nrFlights)
; rdi = struct flight *flightss
; rsi = int nrFlights
apply_delay:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	;; rcx = for loop counter starting from 0
	xor rcx, rcx
for_loop1:
	;; rax = stuct offset in array (42 * rcx)
	mov rax, 42
	mul rcx

	xor r8, r8
	xor r9, r9
	xor r10, r10
	xor r11, r11
	xor rbx, rbx
	xor rdx, rdx

	mov r8b, [rdi + rax + departingTime.day]
	mov r9b, [rdi + rax + departingTime.hour]
	mov r10b, [rdi + rax + departingTime.minutes]
	mov r11b, [rdi + rax + arrivingTime.day]
	mov bl, [rdi + rax + arrivingTime.hour]
	mov dl, [rdi + rax + arrivingTime.minutes]

	add r9b, [rdi + rax + delayHours]
	add r10b, [rdi + rax + delayMinutes]
	add bl, [rdi + rax + delayHours]
	add dl, [rdi + rax + delayMinutes]

fix_depparting_minutes:
	;; if minutes >= 60
	cmp r10, 60
	jl fix_departing_hours
	;; minutes -= 60
	sub r10, 60
	inc r9
	jmp fix_depparting_minutes

fix_departing_hours:
	;; if hours >= 24
	cmp r9, 24
	jl fix_arrival_minutes
	;; hours -= 24
	sub r9, 24
	inc r8
	jmp fix_departing_hours

fix_arrival_minutes:
	;; if minutes >= 60
	cmp dl, 60
	jl fix_arrival_hours
	;; minutes -= 60
	sub dl, 60
	inc bl
	jmp fix_arrival_minutes

fix_arrival_hours:
	;; if hours >= 24
	cmp bl, 24
	jl restore_departing_and_arrival_times
	;; hours -= 24
	sub bl, 24
	inc r11
	jmp fix_arrival_hours

restore_departing_and_arrival_times:
	mov [rdi + rax + departingTime.day], r8b
	mov [rdi + rax + departingTime.hour], r9b
	mov [rdi + rax + departingTime.minutes], r10b
	mov [rdi + rax + arrivingTime.day], r11b
	mov [rdi + rax + arrivingTime.hour], bl
	mov [rdi + rax + arrivingTime.minutes], dl

	inc rcx
	cmp rcx, rsi
	jne for_loop1


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
