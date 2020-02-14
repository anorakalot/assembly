;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 1, ex 0
; Lab section: Friday 8am
; TA: Jan-Shing Ling
; 
;=================================================
.ORIG x3000 ;Starts code at this memory block

	;Instructions
	;LD R1, DEC_0	;R1 <-- #0
	AND R1,R1,x0	; R1 = R1 & 0 and anything and by 0 becomes 0
	LD R2, DEC_12	;R2 <-- #12
	LD R3, DEC_6	;R3 <-- $6
	
	DO_WHILE_LOOP
		ADD R1,R1,R2	;R1 = R1+R2
		ADD R3,R3,#-1	;R3 = R3-1
		BRp DO_WHILE_LOOP ; if R3 > 0 goto DO_WHILE_LOOP
	;END_DO_WHILE_LOOP
	
	HALT
	
	;Local Data
	;DEC_0   .FILL #0  ;put #0 into memory 
	DEC_12  .FILL #12 ;put #12 into memory
	DEC_6   .FILL #6  ;put #6 into memory 

	
.end
