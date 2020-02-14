;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 026
; TA: Jan-Shing Ling
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R2
;=================================================================================

					.ORIG x3000		
;-------------
;Instructions
;-------------

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
					HALT

;---------------	
; Program Data
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
;------------
; Remote data
;------------
					.ORIG xA100			; intro prompt
					.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
					.ORIG xA200			; error message
					.STRINGZ	"ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
					.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
