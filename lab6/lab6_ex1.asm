;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 6, ex 1
; Lab section: 026
; TA: Jan-Shing Ling
; 
;=================================================


.orig x3000

;-------------
;Instructions: CODE GOES HERE
;------------- 
ld r6, get_string_sub_rout
JSRR r6

;LD r0, char_newline
LEA r0, completed_sub_1_msg
PUTS 


HALT
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------
get_string_sub_rout .FILL x3200

completed_sub_1_msg .stringz "get string sub routine done !!! \n"
;char_newline		.FILL '\n'
.END


;----------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
;terminated by the [ENTER] key (the "sentinel"), and has stored
;the received characters in an array of characters starting at (R1).
;the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value (R5): The number of ​ non-sentinel​ characters read from the user.
;R1 contains the starting address of the array unchanged.
;-----------------------------------------------------------------------------------------------------------------

.orig x3200
;-------------
;Instructions for Subroutine BINARY READING
;-------------

;store all the backup register memories especially r7 always to be able to jump back
st r0 , backup_r0_1
;st r1 , backup_r1_1 ;because its input
st r2 , backup_r2_1
st r3 , backup_r3_1
st r4 , backup_r4_1
;st r5 , backup_r5_1 ; because its output
st r6 , backup_r6_1
st r7 , backup_r7_1

ld r1, array ;load inital array start location


ld r5, num_zero

GET_INPUT
	GETC ;GET INPUT 
	OUT 
	ADD R2, R0, #0 ;r2 = r0
	ld r3, char_newline
	NOT r3, r3
	add r3, r3 ,#1 ;get twos complement of newline char to check
	ADD r2, r2, r3 
	BRz END_OF_INPUT
	
	;if not newline get input
	ADD R2, R0, #0 ;r2 = r0
	STR R2, r1 ,#0  ; r2-> r1
	ADD r1, r1, #1 ;move up addres by 1 ; r1+1
	add r5 ,r5, #1
	BR GET_INPUT
	
END_OF_INPUT

;ld r0, char_newline
;OUT

ld r0, array
PUTS

ld r0, char_newline
OUT

;BACKUP all registers except Input and Output back to pre-subroutine values
ld r0 , backup_r0_1
;ld r1 , backup_r1_1 ;input
ld r2 , backup_r2_1
ld r3 , backup_r3_1
ld r4 , backup_r4_1
;ld r5 , backup_r5_1 ;output
ld r6 , backup_r6_1
ld r7 , backup_r7_1



RET

;---------------	
;Data For Subroutine BINARY READING
;---------------
;array .FILL x4000 
;backup register values
backup_r0_1 .blkw #1
;backup_r1_1	.blkw #1
backup_r2_1 .blkw #1
backup_r3_1 .blkw #1
backup_r4_1 .blkw #1
;backup_r5_1 .blkw #1  ;because its output for this subroutine 
backup_r6_1 .blkw #1
backup_r7_1 .blkw #1

array 		.FILL x4000
char_newline .FILL '\n'
num_zero 	.FILL #0

.orig x4000
array_space .BLKW #100

