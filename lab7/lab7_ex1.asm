;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 7, ex 1
; Lab section: 026
; TA: Jan-Shing Ling
; 
;=================================================


.orig x3000

;-------------
;Instructions: CODE GOES HERE
;------------- 
START_OF_MAIN_CODE
	ld r6, char_to_dec_num_sub_rout	;first subroutinge
	JSRR r6

	;LD r0, char_newline
	LEA r0, completed_sub_1_msg 
	PUTS 
	
	ADD R2, R2, #1 ; R2 = R2 + 1
	
	LEA r0, add_one_to_r2_msg
	PUTS 
	
	ld r6, dec_num_to_char_sub_rout ;second subroutine	
	JSRR r6

	;LD r0, char_newline
	LEA r0, completed_sub_2_msg
	PUTS 
	
	BR START_OF_MAIN_CODE
	

HALT
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------
char_to_dec_num_sub_rout .FILL x3200

dec_num_to_char_sub_rout .FILL x3400


completed_sub_1_msg .stringz "char to dec num sub routine done !!! \n"
add_one_to_r2_msg .stringz "add one to r2 \n"
completed_sub_2_msg .stringz "\ndec num to char sub routine done !!! \n"

;char_newline		.FILL '\n'
.END



;----------------------------------------------------------------------------------------------------------------
; Subroutine: TURN_CHAR_INPUT_TO_DEC
; Parameter (): Input from R0 
; Postcondition: Char input from r0 is turned into a decimal value which is stored in 
;R2
; Return Value (R2): the decimal number of the char input is stored here
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

START_OF_CODE
; output intro prompt
ld R0, introPromptPtr
PUTS

						
; Set up flags, counters, accumulators as needed

ld r1 ,num_counter ;r2 = 5
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
					BRz END_OF_CODE	      ;if zero go to end of code
					
					; is it = '+'? if so, ignore it, go get digits
					ADD R4, R0, #0 ; R4 = R0
					LD R5, char_pos
					NOT R5, R5
					ADD R5, R5, #1;get twos complement of pos sign
					ADD R4, R4, R5 
					BRz GET_DIGITS_BEFORE	 ;if zero go to GET DIGITS
					; is it = '-'? if so, set neg flag, go get digits
					ADD R4, R0, #0 ; R4 = R0
					LD R5, char_neg
					NOT R5, R5
					ADD R5, R5, #1;get twos complement of neg sign
					ADD R4, R4, R5 
					BRz IF_NEG	;if zero go to IF_NEG				
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
					LD R5, ascii_offset
					NOT R5, R5
					ADD R5, R5, #1	;get two's complement of ascii offset
					ADD R4, R4, R5 ;add r4 with ascii offset to get num of char
					ADD r2, R4, #0; put r4 num into r2
					ADD r1, r1, #-1 ;r1 has num counter do num counter -1 
					BR GET_DIGITS 	;afterwards go get rest of digits
					
					IF_NEG 
						LD R6, num_neg_one ;give r6 the neg flag
					BR GET_DIGITS_BEFORE
					
					ERROR
						ld r0, char_newline
						OUT
						ld r0, errorMessagePtr 
						PUTS
						;ld r0, char_newline
						;OUT
					BR START_OF_CODE
					
					ERROR_OTHER
						ld r0, errorMessagePtr 
						PUTS
						
					BR START_OF_CODE
					
					GET_DIGITS_BEFORE
						ld r2, num_zero
					
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
						LD R5, ascii_offset
						NOT R5, R5
						ADD R5, R5, #1	;get two's complement of ascii offset
						ADD R4, R4, R5 ;add r4 with ascii offset to get num of char
						
						ADD r5, r2, #0 ;r5 equals r2 orignal value
						MULT_10
							add r2, r2, r5
							add r3, r3, #-1 ; if r3 > 0 since it start at 10
											;keep adding r2 wth r2 
							BRp MULT_10
							
						
						ADD r2, R2, r4; add r2 and r4 
						ADD r1, r1, #-1 ;r1 has num counter do num counter -1 
						Brp GET_DIGITS
						
							;need two neg flag statements because of two newline cases
							;if neg flag was set 
							ADD R6, R6, #0  ; sets r6 = r6  because neg flag already set earlier
							Brn IS_NEG_1
							IS_POS_1
								Br END_OF_IF_NEG_1
							IS_NEG_1
								NOT R2, R2
								ADD R2, R2, #1
								BR END_OF_IF_NEG_1														
							END_OF_IF_NEG_1
							
							;do newline 
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
								NOT R2, R2
								ADD R2, R2, #1
								BR END_OF_IF_NEG_2														
							END_OF_IF_NEG_2
							
							
							ld r5, num_counter ;need to check if nothing entered after initial sign
							NOT r5, r5
							ADD R5, R5, #1
							
							ADD R1, r1,r5
							BRz ERROR_OTHER
							
							
						; remember to end with a newline!
						
					END_OF_CODE
					
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
; Program Data for subroutine char input to num value
;---------------

introPromptPtr		.FILL xA100
errorMessagePtr		.FILL xA200

num_counter .FILL #5
num_ten 	.FILL #9 ;because of mult 10 loop going until its zero 
num_neg_one .FILL #-1
num_zero 	.FILL #0
char_newline .FILL '\n'
char_pos	.FILL '+'
char_neg	.FILL '-'
char_zero	.FILL '0'
char_nine	.FILL '9'
ascii_offset .FILL x30

;backup register values
backup_r0_1 .blkw #1
backup_r1_1	.blkw #1
;backup_r2_1 .blkw #1 ;because its output for this subroutine
backup_r3_1 .blkw #1
backup_r4_1 .blkw #1
backup_r5_1 .blkw #1   
backup_r6_1 .blkw #1
backup_r7_1 .blkw #1

;------------
; Remote data for subroutine 1
;------------
					.ORIG xA100			; intro prompt
					.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
					.ORIG xA200			; error message
					.STRINGZ	"ERROR: invalid input\n"



;----------------------------------------------------------------------------------------------------------------
; Subroutine: TURN_DEC_TO_CHAR_OUTPUT
; Parameter (R2): Input from R2 (decimal value) 
; Postcondition: R2 numerical value is outputted as a number in chars 
; Return Value (): the decimal number stored in R2 is outputted with R0
;-----------------------------------------------------------------------------------------------------------------
.orig x3400

;-------------
;Instructions for Subroutine TURN_DEC_TO_CHAR_OUTPUT
;-------------

;store all the backup register memories especially r7 always to be able to jump back
st r0 , backup_r0_2
st r1 , backup_r1_2 
st r2 , backup_r2_2 
st r3 , backup_r3_2
st r4 , backup_r4_2
st r5 , backup_r5_2 
st r6 , backup_r6_2
st r7 , backup_r7_2


ADD R1 , R2, #0 ; R1 = R2 (original value) 
;;;;;;;;;;;;;;;;;;;;; TEN THOUSAND SECTION

ld r3, num_neg_10000 ; r3 = -10000

ld r4, counter		;r4 = 0

TEN_THOUSAND_LOOP
	ADD R4, R4, #1  ; counter + 1
	add r1 , r1, r3 ; r1 = r1 + -10000
	
	Brp TEN_THOUSAND_LOOP
	
;if it's negative add back 10000 and minus one to the counter since the negative subtraction shouldn't count
ld r3, num_10000 ; r3 = 10000
add r1, r1, r3   ;r1 = r1 +10000
add r4, r4, #-1  ;-1 to counter

ld r3, ascii_offset_2 
add r0, r4, r3 ;r0 = char of counter (r4 + x30)
OUT

;;;;;;;;;;;;;;;;;;;; THOUSAND SECTION
ld r3, num_neg_1000 ; r3 = -1000

ld r4, counter		;r4 = 0

THOUSAND_LOOP
	ADD R4, R4, #1  ; counter + 1
	add r1 , r1, r3 ; r1 = r1 + -1000
	
	Brp THOUSAND_LOOP 
	
;if it's negative add back 1000 and minus one to the counter since the negative subtraction shouldn't count
ld r3, num_1000 ; r3 = 1000
add r1, r1, r3   ;r1 = r1 +1000
add r4, r4, #-1  ;-1 to counter

ld r3, ascii_offset_2 
add r0, r4, r3 ;r0 = char of counter (r4 + x30)
OUT

;;;;;;;;;;;;;;;;;;;; HUNDRED SECTION
ld r3, num_neg_100 ; r3 = -100

ld r4, counter		;r4 = 0

HUNDRED_LOOP
	ADD R4, R4, #1  ; counter + 1
	add r1 , r1, r3 ; r1 = r1 + -100
	
	Brp HUNDRED_LOOP 
	
;if it's negative add back 100 and minus one to the counter since the negative subtraction shouldn't count
ld r3, num_100 ; r3 = 100
add r1, r1, r3   ;r1 = r1 +100
add r4, r4, #-1  ;-1 to counter

ld r3, ascii_offset_2 
add r0, r4, r3 ;r0 = char of counter (r4 + x30)
OUT

;;;;;;;;;;;;;;;;;;;; TENS SECTION
ld r3, num_neg_10 ; r3 = -10

ld r4, counter		;r4 = 0

TENS_LOOP
	ADD R4, R4, #1  ; counter + 1
	add r1 , r1, r3 ; r1 = r1 + -10
	
	Brp TENS_LOOP 
	
;if it's negative add back 10 and minus one to the counter since the negative subtraction shouldn't count
ld r3, num_10 ; r3 = 10
add r1, r1, r3   ;r1 = r1 +10
add r4, r4, #-1  ;-1 to counter

ld r3, ascii_offset_2 
add r0, r4, r3 ;r0 = char of counter (r4 + x30)
OUT

;;;;;;;;;;;;;;;;;;;; ONES SECTION
ld r3, num_neg_1 ; r3 = -10

ld r4, counter		;r4 = 0

ONES_LOOP
	ADD R4, R4, #1  ; counter + 1
	add r1 , r1, r3 ; r1 = r1 + -10
	
	Brp ONES_LOOP 
	
;if it's negative add back 10 and minus one to the counter since the negative subtraction shouldn't count
ld r3, num_1 ; r3 = 10
add r1, r1, r3   ;r1 = r1 +10
;add r4, r4, #-1  ;-1 to counter ;don't minus on the last one

ld r3, ascii_offset_2 
add r0, r4, r3 ;r0 = char of counter (r4 + x30)
OUT






;BACKUP all registers except Output back to pre-subroutine values
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
; Program Data for subroutine num value to char output
;---------------

;array .FILL x4000 ;array for numbers
ascii_offset_2 .FILL x30
num_neg_10000 	   .FILL #-10000
num_neg_1000	   .FILL #-1000
num_neg_100		   .FILL #-100
num_neg_10         .FILL #-10
num_neg_1     	   .FILL #-1

num_10000 	   .FILL #10000
num_1000	   .FILL #1000
num_100		   .FILL #100
num_10         .FILL #10
num_1     	   .FILL #1


counter		.FILL #0

;backup register values
backup_r0_2 .blkw #1
backup_r1_2	.blkw #1
backup_r2_2 .blkw #1 
backup_r3_2 .blkw #1
backup_r4_2 .blkw #1
backup_r5_2 .blkw #1   
backup_r6_2 .blkw #1
backup_r7_2 .blkw #1
 
;.orig x4000
;array_space .BLKW #5

