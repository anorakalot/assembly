;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Richard "Dylan" Mcgee
; Email: rmcge002@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 026
; TA: Lin, Jang-Shing
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_addr		; R6 <-- pointer to value to be displayed as binary
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


HALT
;---------------	
;Data
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


.ORIG xB800					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
