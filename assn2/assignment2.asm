;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Richard "Dylan" Mcgee
; Email: rmcge002@ucr.edu
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string




;-------------------------------
;INSERT YOUR CODE here
;--------------------------------

;LD R0, newline
;OUT
GETC  ;Gets first number 
OUT	  ;Outputs first number
ADD R2, R0, #0 ;Save first number
LD R0, newline
OUT
GETC  ;Gets Second number
OUT   ;Outputs second number
ADD R3, R0, #0 ;Save second number
LD R0, newline
OUT

ADD R0,R2,#0 ;Output First number
OUT
LD R0, space ;Load space character
OUT

LD R0, neg_sign ; subtract sign
OUT
LD R0, space ;Load space character
OUT

ADD R0,R3,#0 ;Output Second number
OUT
LD R0, space ;Load space character
OUT

LD R0, equal_sign ; subtract sign
OUT
LD R0, space ;Load space character
OUT

LD R6 ,ascii_offset
NOT R6, R6 
ADD R6,R6 ,#1 ;get neg offset to turn ascii char to num
ADD R2, R2 , R6 ; turn first ascii to num

ADD R3, R3 , R6; turn sec ascii to num

NOT R3, R3
ADD R3, R3 , #1 ; turn sec num to negative for subtraction

ADD R4, R2, R3  ; add the numbers


BRzp is_pos
BRn  is_neg

is_pos
	ADD R0, R4 ,#0
	LD R6, ascii_offset
	ADD R0, R0 , R6  ;get R4 sum to R0 and convert to ascii
	OUT
	LD R0, newline
	OUT
	HALT

is_neg
	NOT R4, R4
	ADD R4, R4, #1 ; convert back to positive for ascii conversion
	LD R0, neg_sign ; output neg sign
	OUT
	ADD R0, R4,#0
	LD R6, ascii_offset
	ADD R0, R0 , R6  ;get R4 sum to R0 and convert to ascii
	OUT
	LD R0, newline
	OUT
	HALT


HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL '\n'	; newline character - use with LD followed by OUT
neg_sign .FILL '-' ;negative sign character
space    .FILL ' ' ;space character 
equal_sign .FILL '=' ;equal sign char
ascii_offset .FILL x30

;---------------	
;END of PROGRAM
;---------------	
.END

