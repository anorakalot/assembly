;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 1, ex 0
; Lab section: Friday 8am
; TA: Jan-Shing Ling
; 
;=================================================
.ORIG x3000

	LEA R0, MSG_TO_PRINT ; Loads Address of String 
	PUTS				 ; Prints MSG
	
	HALT				 ;Stops Code
	
;Local data
	MSG_TO_PRINT .STRINGZ "Hello World!!!\n" ;Msg Data
	
.END
