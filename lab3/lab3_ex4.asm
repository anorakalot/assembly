;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 3, ex 4
; Lab section: 026
; TA: Jan-Shing Ling
; 
;=================================================
.ORIG x3000
;-------------
;Instructions: CODE GOES HERE
;------------- 
;LD R5, DEC_65_PTR
;LD R6, HEX_41_PTR
;LD R5, DATA_PTR
;LD R6, DATA_PTR
;ADD R6, R6, #1

;LDR R3, R5,#0
;LDR R4, R6,#0
;ADD R3, R3, #1
;ADD R4, R4, #1
;STR R3, R5 ,#0
;STR R4, R6 ,#0

LD R5, ARRAY ;get starting address of array into R5
;LD R6, COUNTER ; Load COUNTER var


WHILE_LOOP_STORE
	GETC ; get R0 input
	OUT ; OUTPUT R0 char
	ADD R4, R0 ,#0 ; put char into R4 
	STR R4, R5 , #0 ;Store whats in r4 in r5 array location
	LD R3, newline ;get newline char 
	NOT R3,R3      
	ADD R3, R3 , #1 ;get negative of newline char to check for equality
	ADD R3, R3 ,R4	; if zero then get out of loop
	BRZ GET_OUT_WHILE_LOOP_STORE 
	
	
	;LD R4 , ascii_offset
	;NOT R4, R4
	;ADD R4, R4, #1
	;ADD R6, R6, #-1 ;Counter - 1 
	ADD R5, R5, #1 ; Move up the R5 array location
	
	BRp WHILE_LOOP_STORE

GET_OUT_WHILE_LOOP_STORE


LD R5, ARRAY ;get starting address of array into R5
;LD R6, COUNTER ; Load COUNTER var
 	
WHILE_LOOP_OUTPUT
	LDR R4, R5, #0 ; LOAD data from array location in r5
	LD R3, newline ;get newline char 
	NOT R3,R3      
	ADD R3, R3 , #1 ;get negative of newline char to check for equality
	ADD R3, R3 ,R4	; if zero then get out of loop
	BRZ GET_OUT_WHILE_LOOP_OUTPUT
	
	ADD R0, R4, #0 ; put data into R0
	OUT		   	   ; OUTPUT R0 char
	LD R0, newline ; Load newline char
	OUT			   ; OUTPUT newline char
	
	ADD R5, R5, #1 ; Move up the R5 array location
	;ADD R6, R6, #-1 ;Counter - 1 
	BRP WHILE_LOOP_OUTPUT
	
GET_OUT_WHILE_LOOP_OUTPUT	
	
HALT
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------
;DEC_65_PTR .FILL x4000
;HEX_41_PTR .FILL x4001

COUNTER .FILL #10
newline .FILL '\n'
ascii_offset .FILL x30

ARRAY .FILL x4000

.ORIG x4000
;ARRAY .BLKW #10

;DATA_PTR .FILL ARRAY

;.orig x4000
;.FILL #65
;.FILL x41

;---------------	
;END of PROGRAM
;---------------	
.END

