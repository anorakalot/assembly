;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 5, subroutine_example
; Lab section: 026
; TA: Jan-Shing Ling
; 
;=================================================

.orig x3000

	ld r1, const

	ld r6, sub_twos_comp_ptr

	jsrr  r6
	lea r0, completed_msg
	puts

	halt
	
; Local data (Main);
const	.fill #29
sub_twos_comp_ptr  .fill x3200
completed_msg 	.stringz "the 2's comp. of the value in R1 is now available n R2 \n"

;Subroutine
;Input (R1):
;Postcondition: twos complement of val in r1 store in r2
;Return Value (R2):

.orig x3200
	;store affected registers
	st r3, backup_r3_1
	st r7, backup_r7_1
	
	;subroutine algorithm
	not r3, r1
	add r3, r3, #1
	add r2, r3, #0
	
	;backup affected registers
	ld r3, backup_r3_1
	ld r7, backup_r7_1
	;return to r7 point 
	ret
	
;local data for subroutine
backup_r3_1		.blkw #1
backup_r7_1		.blkw #1
