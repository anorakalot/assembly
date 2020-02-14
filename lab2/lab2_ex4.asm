;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 2, ex 1
; Lab section: Friday 8am
; TA: Jan-Shing Ling
; 
;=================================================
.ORIG x3000
;-------------
;Instructions: CODE GOES HERE
;-------------
LD R0, HEX_61
LD R1, HEX_1a

WHILE_LOOP
	OUT
	ADD R0, R0,#1
	ADD R1, R1,#-1
BRp WHILE_LOOP

HALT
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------
HEX_61 .FILL x61
HEX_1a .FILL x1a
;---------------	
;END of PROGRAM
;---------------	
.END
