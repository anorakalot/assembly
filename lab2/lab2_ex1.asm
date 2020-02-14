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
LD R3, DEC_65
LD R4, HEX_41
HALT
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------
DEC_65 .FILL #65
HEX_41 .FILL x41

;---------------	
;END of PROGRAM
;---------------	
.END
