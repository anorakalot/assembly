;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 4, ex 4
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
	LDR R0, R5, #0 ; store memory into r0 
;	ADD R0, R0, R6 ; add ascii_offset to turn num to char
	OUT				; OUTPUT
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


ARRAY .FILL x4000 ;load array memory address

.ORIG x4000
ARRAY_SPACE .BLKW #10  ;set aside space for array at x4000
;---------------	
;END of PROGRAM
;---------------	
.END
