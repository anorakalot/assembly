;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 2, ex 2
; Lab section: Friday 8am
; TA: Jan-Shing Ling
; 
;=================================================

.ORIG x3000
;-------------
;Instructions: CODE GOES HERE
;------------- 
LDI R3, DEC_65_PTR
LDI R4, HEX_41_PTR
ADD R3, R3, #1
ADD R4, R4, #1
STI R3, DEC_65_PTR
STI R4, HEX_41_PTR
HALT
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------

DEC_65_PTR .FILL x4000
HEX_41_PTR .FILL x4001
.orig x4000
.FILL #65
.FILL x41
;---------------	
;END of PROGRAM
;---------------	
.END
