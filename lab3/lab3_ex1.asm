;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 3, ex 1
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
LD R5, DATA_PTR
LD R6, DATA_PTR
ADD R6, R6, #1

LDR R3, R5,#0
LDR R4, R6,#0
ADD R3, R3, #1
ADD R4, R4, #1
STR R3, R5 ,#0
STR R4, R6 ,#0

HALT
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------
;DEC_65_PTR .FILL x4000
;HEX_41_PTR .FILL x4001
DATA_PTR .FILL x4000

.orig x4000
.FILL #65
.FILL x41
;---------------	
;END of PROGRAM
;---------------	
.END
