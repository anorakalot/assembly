;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 7, ex 2
; Lab section: 026
; TA: Jan-Shing Ling
; 
;=================================================



.orig x3000

;-------------
;Instructions: CODE GOES HERE
;------------- 
START_OF_MAIN_CODE
	lea r0, input_char_msg
	PUTS

	GETC 
	OUT

	ADD R1, R0, #0 ;R1 = R0


	ld r6, parity_check_sub_rout
	JSRR r6

	;LD r0, char_newline
	LEA r0, completed_sub_1_msg
	PUTS 

	ld r4 , ascii_offset_main ;r4 = x30
	ADD R3, R2, #0 ;R3 = R2

	ADD R3, R3, R4 ;now r3 equals char equivalent of number 

	lea r0, parity_msg_1	
	PUTS

	ADD R0, R1, #0 ; R0 = r1 (because r1 holds original char)

	OUT ; this outs the original char 

	lea r0, parity_msg_2	
	PUTS

	ADD R0, R3, #0 ; R0 = r1 (because r1 holds char of number of 1)

	OUT ;this outputs the char of number of ones

	ld r0, char_newline_main
	OUT
	
	BR START_OF_MAIN_CODE	



HALT
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------
parity_check_sub_rout .FILL x3200

input_char_msg 		.stringz "\n input a single char \n" 
completed_sub_1_msg .stringz "\n parity check sub routine done !!! \n"
parity_msg_1 		.stringz "The number of 1’s in "
parity_msg_2 		.stringz " is: "

ascii_offset_main		.FILL x30
char_newline_main		.FILL '\n'
.END



;----------------------------------------------------------------------------------------------------------------
; Subroutine: Parity Check
; Parameter (R1): contains the char to do parity check on 
; Postcondition: Char input from r0 is turned into a decimal value which is stored in 
;R2
; Return Value (R2): number of 1's in the char
;-----------------------------------------------------------------------------------------------------------------

.ORIG x3200		
;-------------
;Instructions SUBROUTINE 1
;-------------

;store all the backup register memories especially r7 always to be able to jump back
st r0 , backup_r0_1
st r1 , backup_r1_1 
;st r2 , backup_r2_1 ;because its output
st r3 , backup_r3_1
st r4 , backup_r4_1
st r5 , backup_r5_1 
st r6 , backup_r6_1
st r7 , backup_r7_1

ld r2, num_zero ; R2 = 0 (to make sure it starts counting at 0)
ld R3, compare_bit_mask ; R3 = x01
ld r4, compare_counter ;R4 = #8


COMPARE_LOOP
	AND R5, R1, R3 ;and r1 and r3 and if its zero ten r1 is zero at that point and if 
				   ;its one r1 is one at that point
	
	BRz IF_ZERO
	
	
	IF_ONE 	  
		ADD R2, R2, #1 ;count goes up by 1
		BR END_IF_ZERO_OR_ONE
	IF_ZERO
		BR END_IF_ZERO_OR_ONE ;nothing bc count doesn't go up by 1
		
	END_IF_ZERO_OR_ONE
	
	ADD R3, R3, R3 ;left shift r3 to get next compare bit
	
	ADD R4, R4, #-1 ;compare counter - 1
	
	BRp COMPARE_LOOP
	
	
	




;BACKUP all registers except Output back to pre-subroutine values
ld r0 , backup_r0_1
ld r1 , backup_r1_1 
;ld r2 , backup_r2_1 ;output
ld r3 , backup_r3_1
ld r4 , backup_r4_1
ld r5 , backup_r5_1 
ld r6 , backup_r6_1
ld r7 , backup_r7_1


RET

;---------------	
; Program Data for subroutine parity check
;---------------
compare_bit_mask .FILL x01 ; 0000 0001 
compare_counter  .FILL #8 
num_zero 		.FILL #0

;backup register values
backup_r0_1 .blkw #1
backup_r1_1	.blkw #1
;backup_r2_1 .blkw #1 ;because its output for this subroutine
backup_r3_1 .blkw #1
backup_r4_1 .blkw #1
backup_r5_1 .blkw #1   
backup_r6_1 .blkw #1
backup_r7_1 .blkw #1


