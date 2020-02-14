;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 5, ex 2
; Lab section: 026
; TA: Jan-Shing Ling
; 
;=================================================


.ORIG x3000

;-------------
;Instructions: CODE GOES HERE
;------------- 

ld R6, binary_reading_sub_rout
JSRR R6

LEA R0, completed_sub_1_msg
PUTS

ld R6 , binary_output_sub_rout
JSRR  R6

LEA R0, completed_sub_2_msg
PUTS 


HALT

;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------

completed_sub_1_msg 	.stringz "Binary Reading Subroutine Done \n"
completed_sub_2_msg 	.stringz "Binary OUTPUT Subroutine Done \n"
binary_reading_sub_rout .FILL x3200
binary_output_sub_rout  .FILL x3600

;---------------	
;END of PROGRAM
;---------------	
.END




;Subroutine: Binary Reading 
;Input (): nothing all input comes from keyboard input inside the subroutine  
;Postcondition: keyboard input of a 16 bit binary number will be converter to a numerical value
				;and stored in R2
;Return Value (R2): the number value of the binary value inputted 
.orig x3200 

;-------------
;Instructions for Subroutine BINARY READING
;-------------

;store all the backup register memories
st r0 , backup_r0_1
st r1 , backup_r1_1
;st r2 , backup_r2_1
st r3 , backup_r3_1
st r4 , backup_r4_1
st r5 , backup_r5_1
st r6 , backup_r6_1
st r7 , backup_r7_1
 
 
START_OF_SUB_BINARY_READING

	ld r0,char_newline
	OUT

	ld r2 , zero_value 	; to make sure r2 is zero 
	ld r1, counter_binary_input  ;load r1 as the counter 

	ld r3, char_b; char b for comparison

	NOT R3, R3
	ADD R3, R3, #1 ;get two's complement of b 


	GETC ;Get first b input

	ADD R5, R0, R3 ; add and if not zero go back to start
	BRnp ERROR_NOT_B
	
	IS_B 
		OUT;else output the b in r0 and continue on
		BR END_IF_B
	
	ERROR_NOT_B
		LEA R0, error_msg_no_b
		PUTS 
		BR START_OF_SUB_BINARY_READING
		
		
	END_IF_B	 
	



	BINARY_READING_LOOP
		ld r3, char_zero; for use in comparison 
		ld r4, char_one ; for use in comparison
		ld r6, char_space ; for use in comparison
		
		
		
		
		GETC ;get input and store it in R0
		
		ADD R5, R0, #0 ;make a copy of R0 in r5
		
		NOT R3, R3 
		ADD r3, r3, #1 ;get twos complement of zero char for comparison
		
		ADD r5, r5, r3 ;if equal to zero go to else_if_zero
		BRz ELSE_IF_ZERO
		
		
		ADD R5, R0, #0 ;make a copy of R0 in r5
		
		NOT R4, R4 
		ADD r4, r4, #1 ;get twos complement of one char for comparison
		
		ADD r5, r5, r4 ;if equal to zero go to else_if_one
		BRz ELSE_IF_ONE
		 
		 
		ADD R5, R0, #0 ;make a copy of R0 in r5
		NOT R6, R6 
		ADD r6, r6, #1 ;get twos complement of space char for comparison
		
		ADD r5, r5, r6 ;if equal to zero go to else_if_zero
		BRz ELSE_IF_SPACE
		
		
		IF_ERROR ;outputs error message
			LEA R0, error_msg
			PUTS
			ld r0, char_newline
			OUT
			BR END_IF
			
		ELSE_IF_ZERO ;output 0 because don't add 1 if there's no 1
			ADD r2, r2,r2 ; add r2 to itself to left shift
			OUT
			add r1,r1, #-1 ;minus one because its a binary input
			BR END_IF
		
		ELSE_IF_ONE ;adds one to the end because a one was detected 
			ADD r2, r2,r2 ; add r2 to itself to left shift
			ADD R2, R2, #1
			OUT
			add r1,r1, #-1 ;minus one because its a binary input
			BR END_IF
		
		ELSE_IF_SPACE ;Does nothing except output space
			OUT
		
		END_IF
		
		
		add r1, r1,#0 ;already did minus one in the if zero and if one this is just for the BRp command below
		BRp BINARY_READING_LOOP 

	ld r0, char_newline 
	OUT


;BACKUP all registers except Input and Output back to pre-subroutine values
ld r0 , backup_r0_1
ld r1 , backup_r1_1
;st r2 , backup_r2_1
ld r3 , backup_r3_1
ld r4 , backup_r4_1
ld r5 , backup_r5_1
ld r6 , backup_r6_1
ld r7 , backup_r7_1

RET

;---------------	
;Data For Subroutine BINARY READING
;---------------	
counter_binary_input .FILL #16
bit_value .FILL #32768
zero_value .FILL #0

char_zero .FILL '0'
char_one  .FILL '1'
char_space .FILL ' '
char_b 	   .FILL 'b'
char_newline .FILL '\n'

error_msg 	.stringz "Only accept 0,1, or Space"
error_msg_no_b .stringz "Only accept b for first input"


;backup register values
backup_r0_1 .blkw #1
backup_r1_1	.blkw #1
;backup_r2_1 .blkw #1 ;because its output for this subroutine 
backup_r3_1 .blkw #1
backup_r4_1 .blkw #1
backup_r5_1 .blkw #1
backup_r6_1 .blkw #1
backup_r7_1 .blkw #1






;Subroutine: DISPLAY NUMBER IN BINARY
;Input (R2): register has the address of array / number to be converted to binary ; may have to change it to R2 since
										;thats what the output of the other subroutine is 
;Postcondition: Display number as binary in output display terminal
;Return Value (Display): Return Value is just binary num display

.orig x3600
;-------------
;Instructions for Subroutine BINARY OUTPUT
;-------------

;store all the backup register memories
st r0 , backup_r0_2
st r1 , backup_r1_2
st r2 , backup_r2_2
st r3 , backup_r3_2
st r4 , backup_r4_2
st r5 , backup_r5_2
st r6 , backup_r6_2
st r7 , backup_r7_2

;may have to change this part to work with other subroutine 
;LD R6, R5, #0				; R6 <-- pointer to value to be displayed as binary
;ADD R6, R5, #0 ;puts memory location to be displayed as binary in R6

;LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
ADD R1, R2, #0

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
ld r0 , backup_r0_2
ld r1 , backup_r1_2
ld r2 , backup_r2_2
ld r3 , backup_r3_2
ld r4 , backup_r4_2
ld r5 , backup_r5_2
ld r6 , backup_r6_2
ld r7 , backup_r7_2

RET


;---------------	
;Data For Subroutine BINARY OUTPUT
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

backup_r0_2 .blkw #1
backup_r1_2	.blkw #1
backup_r2_2 .blkw #1
backup_r3_2 .blkw #1
backup_r4_2 .blkw #1
backup_r5_2 .blkw #1
backup_r6_2 .blkw #1
backup_r7_2 .blkw #1

;.ORIG xB800					; Remote data
;Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.

;---------------	
;END of Subroutine Binary OUTPUT
;---------------	
