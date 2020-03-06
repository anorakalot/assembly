;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 9, ex 1 & 2
; Lab section: 026
; TA: Jan-Shing Ling
; 
;=================================================

; test harness
					.orig x3000
ld r6, address_tos ;keep r6 here so because its a output value that changes in subroutines push and pop

START_OF_MAIN_CODE					
ld r4, address_base 
ld r5, address_max 



lea r0, push_or_pop_msg
PUTS
GETC 
OUT

ld r2, push_char 
NOT R2, R2
ADD R2, R2, #1

add r3, r0, #0

add r3, r2, r3
BRz PUSH_CASE


ld r2, pop_char 
NOT R2, R2
ADD R2, R2, #1

add r3, r0, #0

add r3, r2, r3
BRz POP_CASE


ERROR_MAIN
	lea r0, push_or_pop_error_msg
	PUTS
	Br START_OF_MAIN_CODE



PUSH_CASE 
	lea r0, push_case_msg_1				 
	PUTS
	ld r2, 	get_num_sub_rout
	JSRR r2
	;now the output of get num is stored in r1		 
	add r0, r1, #0 ;r0 = r1 
	ld r2, sub_stack_push_rout 
	JSRR r2
	Br START_OF_MAIN_CODE
	

POP_CASE 
	;lea r0, pop_case_msg_1				 
	;PUTS
	;ld r2, 	get_num_sub_rout
	;JSRR r2
	;now the output of get num is stored in r1		 
	;add r0, r1, #0 ;r0 = r1 
	ld r2, sub_stack_pop_rout 
	JSRR r2
	
	ld r3,pop_error_flag	
	not r3, r3
	add r3, r3, #1 ;- error flag
	add r3, r2,r3 ; if error flag set in pop subroutine
	BRz UNDERFLOW_POP
	
	add r1, r0, #0 ;r1 = r0
	
	lea r0, popped_value_msg	
	PUTS
	ld r2, print_num_sub_rout ;input is r1 to print
	JSRR r2
	
	
	ld r0, main_newline	
	OUT
	
	Br START_OF_MAIN_CODE

UNDERFLOW_POP 
	Br START_OF_MAIN_CODE
				 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
sub_stack_push_rout .FILL x3200
sub_stack_pop_rout	.FILL x3400
get_num_sub_rout	.FILL x3600
print_num_sub_rout	.FILL x3800

push_or_pop_msg .stringz "\nDo you want to push or pop to the stack: 1 to push , 2 to pop:\n"
push_or_pop_error_msg .stringz "\nError not valid choice.\n"
push_case_msg_1		.stringz "\nEnter what you want to push to the stack:\n"
;pop_case_msg_1		.stringz "\nEnter what you want to push to the stack:\n"

popped_value_msg	.stringz "\nThe popped value was: "

main_newline .FILL '\n'

push_char .FILL '1'
pop_char  .FILL '2'
pop_error_flag .FILL '/'

address_base .FILL x4000 ; first available is 4001 ;base is 1- first available
address_max	 .FILL x4005
address_tos	 .FILL x4000 ;4001
 

;===============================================================================================


; subroutines:

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3200

;HINT back up 
st r0 , backup_r0_1
st r1 , backup_r1_1  ; because its output
st r2 , backup_r2_1
st r3 , backup_r3_1
st r4 , backup_r4_1
st r5 , backup_r5_1 
;st r6 , backup_r6_1
st r7 , backup_r7_1				 
				 
;- Verify that TOS is ​ less than​ MAX (if not, print Overflow message & quit)
;- Increment TOS
;- Write the desired value to the Top Of Stack:
;Mem[TOS] <- (R0)

add r1, r5, #0 ; r1 = r5 (MAX)
add r2, r6, #0 ; r2 = r6 (TOS)

not r2, r2
add r2, r2, #1 ;two complement tos 

add r1, r1, r2 ;add max + -tos if zero or negative tos is equal to or greater than max 
				;only positive add result is ok

BRnz ERROR_PUSH




add r6, r6, #1 ;increment tos

str r0, r6, #0 ; r0 -> mem[r6] 
BR END_OF_PUSH_SUB_ROUT
				
				

ERROR_PUSH
	lea r0, overflow_msg
	PUTS 
	

END_OF_PUSH_SUB_ROUT				 
				 
;HINT Restore
ld r0 , backup_r0_1
ld r1 , backup_r1_1 ;output
ld r2 , backup_r2_1
ld r3 , backup_r3_1
ld r4 , backup_r4_1
ld r5 , backup_r5_1 
;ld r6 , backup_r6_1
ld r7 , backup_r7_1

					
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data

;backup register values
backup_r0_1 .blkw #1
backup_r1_1	.blkw #1 
backup_r2_1 .blkw #1
backup_r3_1 .blkw #1
backup_r4_1 .blkw #1
backup_r5_1 .blkw #1   
;backup_r6_1 .blkw #1
backup_r7_1 .blkw #1

overflow_msg .stringz "\n Cannot push or else there would be overflow\n"


;===============================================================================================


;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off the stack
;		   R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3400
;HINT back up 
;st r0 , backup_r0_2
st r1 , backup_r1_2  
st r2 , backup_r2_2 
st r3 , backup_r3_2
st r4 , backup_r4_2
st r5 , backup_r5_2 
;st r6 , backup_r6_2
st r7 , backup_r7_2

;- Verify that TOS is ​ greater than​ BASE (if not, print Underflow message & quit)
;- Copy the value at the Top Of Stack to the destination register: R0 <- Mem[TOS]
;- Decrement TOS			 
				 
add r1, r4 , #0 ; r1 = base
add r2, r6, #0 ; r2 = TOS

not r2, r2
add r2, r2, #1 ; -tos

add r1, r1, r2 ; base + - tos , 0 and + are wrong , - is right 
			   ; ex Tos = 2 Base = 1 -2 + 1 = -1  right
			   ;ex Tos = 1 Base = 1 -1 + 1 = 0 wrong
			   ; ex Tos = -1 Base = 1 1 + 1 = 2 wrong
BRzp ERROR_POP			   

ldr r0, r6, #0 ; mem[r6] -> r0

ld r2, clear_pop_num

str r2, r6, #0 ; r2 -> mem[r6]  (make current tos position zero)

add r6, r6, #-1 ;decrement tos

BR END_OF_POP_SUB_ROUT	


ERROR_POP				 
	lea r0, underflow_msg
	PUTS 				 
	ld r2, error_flag

END_OF_POP_SUB_ROUT


;HINT Restore
;ld r0 , backup_r0_2
ld r1 , backup_r1_2 
;ld r2 , backup_r2_2
ld r3 , backup_r3_2
ld r4 , backup_r4_2
ld r5 , backup_r5_2 
;ld r6 , backup_r6_2
ld r7 , backup_r7_2
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data

;backup register values
;backup_r0_2 .blkw #1
backup_r1_2	.blkw #1 
backup_r2_2 .blkw #1
backup_r3_2 .blkw #1
backup_r4_2 .blkw #1
backup_r5_2 .blkw #1   
;backup_r6_2 .blkw #1
backup_r7_2 .blkw #1

clear_pop_num .FILL #0
underflow_msg .stringz "\n Cannot pop or else there would be underflow\n"
error_flag	  .FILL '/'

;===============================================================================================


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
;HINT back up 
.ORIG x3600

;HINT back up 
st r0 , backup_r0_8
;st r1 , backup_r1_8  ; because its output
st r2 , backup_r2_8
st r3 , backup_r3_8
st r4 , backup_r4_8
st r5 , backup_r5_8 
st r6 , backup_r6_8
st r7 , backup_r7_8

;-------------
;Instructions SUBROUTINE 1
;-------------
START_OF_CODE
; output intro prompt
lea R0, prompt
PUTS

						
; Set up flags, counters, accumulators as needed

ld r2 ,num_counter ;r2 = 5 ;change to num counter = 2
ld r3 , num_ten    ;r3 = 10
;r6 will have neg flag
;r2 will hold the sum

; Get first character, test for '\n', '+', '-', digit/non-digit 	
					GETC 
					OUT
					; is very first character = '\n'? if so, just quit (no message)!
					ADD R4, R0, #0 ; R4 = R0
					LD R5, char_newline
					NOT R5, R5
					ADD R5, R5, #1;get twos complement of newline
					ADD R4, R4, R5 
					;BRz END_OF_CODE	      ;if zero go to end of code
					BRz ERROR
					
					; is it = '+'? if so, ignore it, go get digits
					ADD R4, R0, #0 ; R4 = R0
					LD R5, char_pos
					NOT R5, R5
					ADD R5, R5, #1;get twos complement of pos sign
					ADD R4, R4, R5 
					BRz GET_DIGITS_BEFORE	 ;if zero go to GET DIGITS
					; is it = '-'? if so, set neg flag, go get digits ;ACTUALLY NOW TREAT IT LIKE AN ERROR
					ADD R4, R0, #0 ; R4 = R0
					LD R5, char_neg
					NOT R5, R5
					ADD R5, R5, #1;get twos complement of neg sign
					ADD R4, R4, R5 
					;BRz IF_NEG	;if zero go to IF_NEG				
					Brz ERROR ; if zero go to errror since '-' no valid in this program
					; is it < '0'? if so, it is not a digit	- o/p error message, start over
					ADD R4, R0, #0 ; R4 = R0
					LD R5, char_zero
					NOT R5, R5
					ADD R5, R5, #1;get twos complement of zero char
					ADD R4, R4, R5  
					BRn ERROR ;if negative go then char zero is bigger than 
									;char inputted there is error
					
					; is it > '9'? if so, it is not a digit	- o/p error message, start over
					ADD R4, R0, #0 ; R4 = R0
					LD R5, char_nine
					NOT R5, R5
					ADD R5, R5, #1;get twos complement of nine char
					ADD R4, R4, R5  
					BRp ERROR ;if negative go then char zero is bigger than 
					
					
					; if none of the above, first character is first numeric digit - convert it to number & store in target register!
					ADD R4, R0, #0
					LD R5, ascii_offset_get_num
					NOT R5, R5
					ADD R5, R5, #1	;get two's complement of ascii offset
					ADD R4, R4, R5 ;add r4 with ascii offset to get num of char
					ADD r1, R4, #0; put r4 num into r2
					ADD r2, r2, #-1 ;r1 has num counter do num counter -1 
					BR GET_DIGITS 	;afterwards go get rest of digits
					
					IF_NEG 
						LD R6, num_neg_one ;give r6 the neg flag
					BR GET_DIGITS_BEFORE
					
					ERROR
						ld r0, char_newline
						OUT
						lea r0, Error_msg_2 
						PUTS
						;ld r0, char_newline
						;OUT
					BR START_OF_CODE
					
					ERROR_OTHER
						lea r0, Error_msg_2 
						PUTS
						
					BR START_OF_CODE
					
					GET_DIGITS_BEFORE
						ld r1, num_zero
					
; Now get remaining digits (max 5) from user, testing each to see if it is a digit, and build up number in accumulator
					GET_DIGITS
						ld r3, num_ten ;r3 = 10
					
						GETC  
						OUT
						; is very first character = '\n'? if so, just quit (no message)!
						ADD R4, R0, #0 ; R4 = R0
						LD R5, char_newline
						NOT R5, R5
						ADD R5, R5, #1;get twos complement of newline
						ADD R4, R4, R5 
						BRz NEAR_END_OF_CODE	      ;if zero go to end of code						
						
						; is it < '0'? if so, it is not a digit	- o/p error message, start over
						ADD R4, R0, #0 ; R4 = R0
						LD R5, char_zero
						NOT R5, R5
						ADD R5, R5, #1;get twos complement of zero char
						ADD R4, R4, R5  
						BRn ERROR ;if negative go then char zero is bigger than 
										;char inputted there is error
						
						; is it > '9'? if so, it is not a digit	- o/p error message, start over
						ADD R4, R0, #0 ; R4 = R0
						LD R5, char_nine
						NOT R5, R5
						ADD R5, R5, #1;get twos complement of nine char
						ADD R4, R4, R5  
						BRp ERROR ;if negative go then char zero is bigger than 
						
						
						;if previous breaks did not happen we know now that it is a number
						ADD R4, R0, #0
						LD R5, ascii_offset_get_num
						NOT R5, R5
						ADD R5, R5, #1	;get two's complement of ascii offset
						ADD R4, R4, R5 ;add r4 with ascii offset to get num of char
						
						ADD r5, r1, #0 ;r5 equals r2 orignal value
						MULT_10
							add r1, r1, r5
							add r3, r3, #-1 ; if r3 > 0 since it start at 10
											;keep adding r2 wth r2 
							BRp MULT_10
							
						
						ADD r1, R1, r4; add r2 and r4 
						;ADD r2, r2, #-1 ;r1 has num counter do num counter -1 
						;Brp GET_DIGITS
						Br GET_DIGITS
						
							;need two neg flag statements because of two newline cases
							;if neg flag was set 
							ADD R6, R6, #0  ; sets r6 = r6  because neg flag already set earlier
							Brn IS_NEG_1
							IS_POS_1
								Br END_OF_IF_NEG_1
							IS_NEG_1
								NOT R1, R1
								ADD R1, R1, #1
								BR END_OF_IF_NEG_1														
							END_OF_IF_NEG_1
							
							;do newline 

							;is it > 15? if so, it is to big	- o/p error message, start over
							;ADD R4, R1, #0 ; R4 = R1
							;LD R5, num_fifteen 
							;NOT R5, R5
							;ADD R5, R5, #1;get twos complement of num fifteen
							;ADD R4, R4, R5  
							;BRp ERROR ;if positive then r1 value is bigger than 15 which is an error
							
							ld r0 , char_newline
							OUT
							BR END_OF_CODE 
							
						NEAR_END_OF_CODE
							;if neg flag was set 
							ADD R6, R6, #0  ; sets r6 = r6  because neg flag already set earlier
							Brn IS_NEG_2
							IS_POS_2
								Br END_OF_IF_NEG_2
							IS_NEG_2
								NOT R1, R1
								ADD R1, R1, #1
								BR END_OF_IF_NEG_2														
							END_OF_IF_NEG_2
							
							;is it > 15? if so, it is to big	- o/p error message, start over
							;ADD R4, R1, #0 ; R4 = R1
							;LD R5, num_fifteen 
							;NOT R5, R5
							;ADD R5, R5, #1;get twos complement of num fifteen
							;ADD R4, R4, R5  
							;BRp ERROR ;if positive then r1 value is bigger than 15 which is an error
							
							ld r5, num_counter ;need to check if nothing entered after initial sign
							NOT r5, r5
							ADD R5, R5, #1
							
							ADD R2, r2,r5
							BRz ERROR_OTHER
							
							
						; remember to end with a newline!
						
					END_OF_CODE
					
					
					;HINT Restore
					ld r0 , backup_r0_8
					;ld r1 , backup_r1_8 ;output
					ld r2 , backup_r2_8
					ld r3 , backup_r3_8
					ld r4 , backup_r4_8
					ld r5 , backup_r5_8 
					ld r6 , backup_r6_8
					ld r7 , backup_r7_8
					RET

;---------------	
; Program Data
;---------------

;introPromptPtr		.FILL xA100
;errorMessagePtr		.FILL xA200

num_counter .FILL #2 ;changed from 5 to 2 since it must be between 0 and 15
num_ten 	.FILL #9 ;because of mult 10 loop going until its zero 
num_fifteen .FILL #15 ;num fifteen to check for upper bound
num_neg_one .FILL #-1
num_zero 	.FILL #0
char_newline .FILL '\n'
char_pos	.FILL '+'
char_neg	.FILL '-'
char_zero	.FILL '0'
char_nine	.FILL '9'
ascii_offset_get_num .FILL x30

;backup register values
backup_r0_8 .blkw #1
;backup_r1_8	.blkw #1 ;because its output for this subroutine
backup_r2_8 .blkw #1
backup_r3_8 .blkw #1
backup_r4_8 .blkw #1
backup_r5_8 .blkw #1   
backup_r6_8 .blkw #1
backup_r7_8 .blkw #1

;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter number followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"
	

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,15}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
; WITHOUT leading 0's, a leading sign, or a trailing newline.
;      Note: that number is guaranteed to be in the range {#0, #15}, 
;            i.e. either a single digit, or '1' followed by a single digit.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.orig x3800

;HINT back up 
st r0 , backup_r0_9
st r1 , backup_r1_9 
st r2 , backup_r2_9 
st r3 , backup_r3_9
st r4 , backup_r4_9
st r5 , backup_r5_9 
st r6 , backup_r6_9
st r7 , backup_r7_9



; do ten test 
add r2, r1, #0
ld r3, num_neg_10
add r3, r3,r2

Brz OUTPUT_TEN

;switch r2 and r1 


ADD R2 , R1, #0 ; R2 = R1 (original value) 


;;;;;;;;;;;;;;;;;;;; TENS SECTION
ld r3, num_neg_10 ; r3 = -10

ld r4, counter		;r4 = 0

TENS_LOOP
	ADD R4, R4, #1  ; counter + 1
	add r2 , r2, r3 ; r1 = r1 + -10
	
	Brp TENS_LOOP 
	
;if it's negative add back 10 and minus one to the counter since the negative subtraction shouldn't count
ld r3, num_10 ; r3 = 10
add r2, r2, r3   ;r1 = r1 +10
add r4, r4, #-1  ;-1 to counter

add r4, r4,#0 ;r4 = r4 
BRz ONES_SECTION ;if zero go to ones section

ld r3, ascii_offset_print 
add r0, r4, r3 ;r0 = char of counter (r4 + x30)
OUT

ONES_SECTION
;;;;;;;;;;;;;;;;;;;; ONES SECTION
ld r3, num_neg_1 ; r3 = -1

ld r4, counter		;r4 = 0

ONES_LOOP
	ADD R4, R4, #1  ; counter + 1
	add r2 , r2, r3 ; r1 = r1 + -1
	
	Brp ONES_LOOP 


	
;if it's negative add back 10 and minus one to the counter since the negative subtraction shouldn't count
ld r3, num_1 ; r3 = 10
add r2, r2, r3   ;r1 = r1 +10
BRz OUTPUT_ZERO 
;add r4, r4, #-1  ;-1 to counter ;don't minus on the last one

OUTPUT
	ld r3, ascii_offset_print
	add r0, r4, r3 ;r0 = char of counter (r4 + x30)
	OUT
BR OUTSIDE_OUTPUT

OUTPUT_ZERO 
	ld r3, ascii_offset_print
	add r0, r2, r3 ;r0 = char of counter (r4 + x30)
	OUT
	Br OUTSIDE_OUTPUT

OUTPUT_TEN 
	ld r0, char_one_print_num	
	OUT
	ld r0, char_zero_print_num
	OUT
	
OUTSIDE_OUTPUT
;HINT Restore
ld r0 , backup_r0_9
ld r1 , backup_r1_9 
ld r2 , backup_r2_9 
ld r3 , backup_r3_9
ld r4 , backup_r4_9
ld r5 , backup_r5_9 
ld r6 , backup_r6_9
ld r7 , backup_r7_9

RET
;--------------------------------
;Data for subroutine print number
;--------------------------------
;backup register values
backup_r0_9 .blkw #1
backup_r1_9	.blkw #1
backup_r2_9 .blkw #1 
backup_r3_9 .blkw #1
backup_r4_9 .blkw #1
backup_r5_9 .blkw #1   
backup_r6_9 .blkw #1
backup_r7_9 .blkw #1

ascii_offset_print .FILL x30
num_neg_10         .FILL #-10
num_neg_1     	   .FILL #-1

char_one_print_num		.FILL '1'
char_zero_print_num		.FILL '0'
num_10         .FILL #10
num_1     	   .FILL #1

num_0 		   .FILL #0

counter		.FILL #0
