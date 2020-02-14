;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 5, ex 1
; Lab section: 026
; TA: Jan-Shing Ling
; 
;=================================================

.ORIG x3000
;-------------
;Instructions: CODE GOES HERE
;------------- 
;LEA R5, ARRAY
LD R5, ARRAY
LD R4, COUNTER
LD R3, VALUE

FILL_ARRAY
	STR R3, R5, #0 ;Store value into r5 
	ADD R5, R5, #1 ; move r5/array up one
	ADD R3, R3 , R3 ; add value to make it 2^(n+1)
	ADD R4, R4, #-1 ; counter - 1
	BRP FILL_ARRAY ; if positive go back to beginning

;LEA R5, ARRAY	
LD R5,ARRAY
LD R4, SEVEN_COUNTER 

GO_TO_SEVEN
	ADD R5, R5, #1 ; move r5/array up one
	ADD R4, R4, #-1 ; counter - 1
	BRP GO_TO_SEVEN ; if positive go back until at right memory 
	
	
LDR R2, R5, #0;
	
;LD R6, ascii_offset
;LEA R5, ARRAY
LD R5, ARRAY
LD R4, COUNTER

OUTPUT_ARRAY
;;	LDR R0, R5, #0 ; store memory into r0 
;	ADD R0, R0, R6 ; add ascii_offset to turn num to char
;;	OUT				; OUTPUT
;;	ADD R5, R5, #1 ; move r5/array up one

	ld R6, display_num_in_binary_sub ; load subroutine
	JSRR r6 ;jumps to subroutine to do it
	 
	ADD R5, R5, #1 ; move r5/array up one	
	ADD R4, R4, #-1 ; counter - 1
	
	BRP OUTPUT_ARRAY
	
	
HALT
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------

COUNTER .FILL #10
SEVEN_COUNTER .FILL #6
VALUE .FILL #1
ascii_offset .FILL x30

display_num_in_binary_sub .FILL x3200


ARRAY .FILL x4000 ;load array memory address

.ORIG x4000
ARRAY_SPACE .BLKW #10  ;set aside space for array at x4000
;---------------	
;END of PROGRAM
;---------------	
.END


;Subroutine: DISPLAY NUMBER IN BINARY
;Input (R5): register has the address of array / number to be converted to binary 
;Postcondition: Display number as binary in output display terminal
;Return Value (Display): Return Value is just binary num display

.orig x3200
;-------------
;Instructions for Subroutine
;-------------

;store all the backup register memories
st r0 , backup_r0_1
st r1 , backup_r1_1
st r2 , backup_r2_1
st r3 , backup_r3_1
st r4 , backup_r4_1
st r5 , backup_r5_1
st r6 , backup_r6_1
st r7 , backup_r7_1


;LD R6, R5, #0				; R6 <-- pointer to value to be displayed as binary
ADD R6, R5, #0 ;puts memory location to be displayed as binary in R6

LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD R5, shift_counter

LD R6, space_counter

;LD R7, pack_of_fours_counter
;LD R7, shift_counter
LD R7, pack_of_fours_counter
MAIN_LOOP

	ADD R2, R1,#0 ;copy r1 into r2

	LD R4, msb 	;load x800 into r4

	AND R2, R2 , R4 ;mask r2 all except the first bit should be visible in R2

	LD R3, check_if_one ;load x800 

	NOT R3, R3      

	ADD R3, R3, #1 ;get two's complement opposite of x800 


	ADD R2, R2, R3 ;add r2 and r3 and if zero there's a one 
				   ; and if its negative its a zero


	BRz OUTPUT_1 


		
		
	OUTPUT_0
		LD R0, zero_char 
		OUT
		BR MOVE_OUTSIDE_OUTPUT_1 ; added this here in case it goes to output 0
								 ; it doesn't output 1 as well
	OUTPUT_1
		LD R0, one_char 
		OUT
		
	MOVE_OUTSIDE_OUTPUT_1	
	ADD R1, R1, R1 ;add r1 with r1 to left shift the bits
	
	;ADD R7, R7, #-1
	;BRnz OUTSIDE_MAIN_LOOP
	
	ADD R5, R5, #-1 ;minus R5 if zero get stop computing bits else 
					;go back to main loop
	BRz OUTSIDE_MAIN_LOOP
	
	ADD R6, R6, #-1 ; if space counter = o go to output space
	BRz OUTPUT_SPACE
		
	NOT_OUTPUT_SPACE
		BR MOVE_OUTSIDE_OUTPUT_SPACE
	OUTPUT_SPACE
		ADD R7, R7, #-1
		BRz MOVE_OUTSIDE_OUTPUT_SPACE
		LD R0, space_char
		OUT
		LD R6, space_counter
		
	MOVE_OUTSIDE_OUTPUT_SPACE
	
	BR MAIN_LOOP
	

OUTSIDE_MAIN_LOOP
LD R0, newline_char
OUT

;BACKUP all registers except Input and Output back to pre-subroutine values
ld r0 , backup_r0_1
ld r1 , backup_r1_1
ld r2 , backup_r2_1
ld r3 , backup_r3_1
ld r4 , backup_r4_1
ld r5 , backup_r5_1
ld r6 , backup_r6_1
ld r7 , backup_r7_1

RET


;---------------	
;Data For Subroutine
;---------------	
Value_addr	.FILL xB800	; The address where value to be displayed is stored

;msb .FILL x800
;check_if_one .FILL x800
msb  .FILL x8000
check_if_one .FILL x8000

one_char .FILL '1'
zero_char .FILL '0'
space_char .FILL ' '
newline_char .FILL '\n'
test_char 	.FILL 'a'

;pack_of_fours_counter .FILL #1
pack_of_fours_counter  .FILL #1
space_counter 		  .FILL #4
shift_counter 		  .FILL #16

backup_r0_1 .blkw #1
backup_r1_1	.blkw #1
backup_r2_1 .blkw #1
backup_r3_1 .blkw #1
backup_r4_1 .blkw #1
backup_r5_1 .blkw #1
backup_r6_1 .blkw #1
backup_r7_1 .blkw #1

;.ORIG xB800					; Remote data
;Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.

;---------------	
;END of Subroutine
;---------------	
