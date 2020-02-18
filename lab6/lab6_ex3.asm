;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 6, ex 2
; Lab section: 026
; TA: Jan-Shing Ling
; 
;=================================================


.orig x3000

;-------------
;Instructions: CODE GOES HERE
;------------- 
START_OF_MAIN_CODE
	ld r6, clear_memory_sub_rout
	JSRR r6
	
	ld r6, get_string_sub_rout
	JSRR r6

	;LD r0, char_newline
	LEA r0, completed_sub_1_msg
	PUTS 

	ld r6 ,upper_case_sub_rout
	JSRR r6

	lea r0, compl_upper_case_msg
	PUTS

	ld r6, palindrome_test_sub_rout
	JSRR r6

	;LD r0, char_newline

	LEA r0, the_str_msg	
	PUTS 

	ADD R0, r1, #0
	PUTS

	ADD R4, R4, #0
	BRp is_pali 

	not_pali ;pali if statement
		lea r0, not_pali_msg
		PUTS 
		Br end_pali
	is_pali
		lea r0, is_pali_msg
		PUTS
		Br end_pali
		
	end_pali
	
	ld r0, char_newline_main
	OUT

Br START_OF_MAIN_CODE 


HALT
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------
get_string_sub_rout .FILL x3200
palindrome_test_sub_rout .FILL x3600
upper_case_sub_rout	.FILL x4000
clear_memory_sub_rout .FILL x4400

compl_upper_case_msg 	.stringz "\nupper case sub done \n"
completed_sub_1_msg .stringz "get string sub routine done !!! \n"
is_pali_msg			.stringz " is a palindrome \n"
not_pali_msg		.stringz " is not a palindrome \n"
the_str_msg			.stringz "the string "
;completed_sub_2_msg .stringz "palindrome test sub routine done !!! \n"
char_newline_main		.FILL '\n'
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

ld r1,array ;reload array starting location

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
;array .FILL x5000 
;backup register values
backup_r0_1 .blkw #1
;backup_r1_1	.blkw #1
backup_r2_1 .blkw #1
backup_r3_1 .blkw #1
backup_r4_1 .blkw #1
;backup_r5_1 .blkw #1  ;because its output for this subroutine 
backup_r6_1 .blkw #1
backup_r7_1 .blkw #1

array 		.FILL x5000
char_newline .FILL '\n'
num_zero 	.FILL #0

.orig x5000
array_space .BLKW #100


;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_IS_A_PALINDROME
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1) is
;a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;------------------------------------------------------------------------------------------------------------------

.orig x3600
;-------------
;Instructions for Subroutine PALINDROME TEST
;-------------

;store all the backup register memories especially r7 always to be able to jump back
st r0 , backup_r0_2
st r1 , backup_r1_2 ;because its input
st r2 , backup_r2_2
st r3 , backup_r3_2
;st r4 , backup_r4_1 ;output
st r5 , backup_r5_2 ; because its input
st r6 , backup_r6_2
st r7 , backup_r7_2

;ld r2 ,num_zero_2 ;r2 = 0 will be index starting at 0
ld r7 ,num_zero_2 

PALINDROME_LOOP
	;checks if parts (0 ,n-1) (1,n-2) are equal
	;ADD r6, r1, #0 ;r6 = r1
	ld r6, array_2
	
	ADD R3, R5 ,#0 ;r3 = r5
	ADD r3, r3, #-1 ;r3 = r3-1
	
	ADD r6 , r6, r3 ;r6 = r6 + r3 = array[n-1]
	ldr r3, r6 ,#0 ;mem[r6] -> r3 (actual value of mem[r6] )
	ldr r2, r1, #0 ;mem[r1]  -> r2
	
	NOT R3, R3
	ADD R3, R3 ,#1 ;twos complement of r3
	
	ADD r2, r2, r3 ;if zero then its correct anything else and its not equal
	BRnp NOT_PALINDROME
	
	
	; checks if need to get out of loop 
	ADD R3, R5 ,#0 ;r3 = r5
	ADD r3, r3, #-1 ;r3 = r3-1
	
	
	ADD R2, R7, #0 ;r2 = r7
	NOT R2, R2
	ADD R2, R2, #1 ;two's complement
	ADD r2 , r2, r3 
	BRnz IS_PALINDROME ;can assume is palindrome if not palindrome is not triggered
					   ;n too because it should run when starting location index 
					   ;is >= the end location index
	
	ADD r1, r1, #1 ;r1 += 1 move up memory location
	
	ADD r5, r5, #-1 ;index of end location - 1
	ADD R7 , R7 ,#1 ;index of starting location + 1
	
	BR PALINDROME_LOOP
	
	
	
	
	
	
		

IS_PALINDROME
	ld r4, num_one_2
	BR END_IF_PALINDROME	


NOT_PALINDROME
	ld r4 , num_zero_2
	BR END_IF_PALINDROME	

END_IF_PALINDROME

;BACKUP all registers except Input and Output back to pre-subroutine values
ld r0 , backup_r0_2
ld r1 , backup_r1_2 ;input
ld r2 , backup_r2_2
ld r3 , backup_r3_2
;ld r4 , backup_r4_2 ;ouput
ld r5 , backup_r5_2 ;input
ld r6 , backup_r6_2
ld r7 , backup_r7_2



RET

;---------------	
;Data For Subroutine PALINDROME TES
;---------------
num_one_2		.FILL #1
num_zero_2	.FILL #0

array_2 	.FILL x5000
;backup register values
backup_r0_2 .blkw #1
backup_r1_2	.blkw #1 ;input
backup_r2_2 .blkw #1
backup_r3_2 .blkw #1
;backup_r4_2 .blkw #1  ;output
backup_r5_2 .blkw #1  ;input  
backup_r6_2 .blkw #1
backup_r7_2 .blkw #1



;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_TO_UPPER
; Parameter (R1): Starting address of a null-terminated string
; Postcondition: The subroutine has converted the string to upper-case ​ in-place
;i.e. the upper-case string has replaced the original string
; No return value, no output (but R1 still contains the array address, unchanged).
;------------------------------------------------------------------------------------------------------------------

.orig x4000
;-------------
;Instructions for Subroutine UPPER_CASE_SUB
;-------------

;store all the backup register memories especially r7 always to be able to jump back
st r0 , backup_r0_3
st r1 , backup_r1_3 ;because its input
st r2 , backup_r2_3
st r3 , backup_r3_3
st r4 , backup_r4_3 ;output
st r5 , backup_r5_3 ; because its input
st r6 , backup_r6_3
st r7 , backup_r7_3

ADD R6, R1, #0


ld r2, bit_mask_value

UPPER_CASE_LOOP

	ldr r3, r1,#0 ;r3 <- mem[r1]

	AND r3,r3,r2

	str r3, r1,#0; r3 -> mem[r1]
	
	ADD R1, R1, #1
	ADD r5, r5, #-1
	BRp UPPER_CASE_LOOP
	
	ADD R0, R6, #0
	PUTS
	


;BACKUP all registers except Input and Output back to pre-subroutine values
ld r0 , backup_r0_3
ld r1 , backup_r1_3 ;input
ld r2 , backup_r2_3
ld r3 , backup_r3_3
ld r4 , backup_r4_3 ;ouput
ld r5 , backup_r5_3 ;input
ld r6 , backup_r6_3
ld r7 , backup_r7_3




RET

;---------------	
;Data For Subroutine UPPER_CASE_SUB
;---------------

bit_mask_value 	.FILL x5f
;backup register values
backup_r0_3 .blkw #1
backup_r1_3	.blkw #1 ;input
backup_r2_3 .blkw #1
backup_r3_3 .blkw #1
backup_r4_3 .blkw #1  ;output
backup_r5_3 .blkw #1  ;input  
backup_r6_3 .blkw #1
backup_r7_3 .blkw #1


;------------------------------------------------------------------------------------------------------------------
; Subroutine: Clear Memory
; Parameter (R1): Starting address of a null-terminated string
; Postcondition: clear memory so the program can be rerun seamlessly
; No return value, no output all that happens is that the array space is now all zero
;------------------------------------------------------------------------------------------------------------------

.orig x4400
;-------------
;Instructions for Subroutine Clear Memory
;-------------

;store all the backup register memories especially r7 always to be able to jump back
st r0 , backup_r0_4
st r1 , backup_r1_4 
st r2 , backup_r2_4
st r3 , backup_r3_4
st r4 , backup_r4_4 
st r5 , backup_r5_4 
st r6 , backup_r6_4
st r7 , backup_r7_4

ld r1, array_clear
ld r2, num_100_counter	

CLEAR_LOOP
	ldr r3, r1,#0 ;r3 <- mem[r1]

	ld r3, num_zero_clear ;r3 <- 0
	
	str r3, r1,#0; r3 -> mem[r1]
	
	ADD R1, R1, #1
	
	ADD R2, R2, #-1
	BRp CLEAR_LOOP
	


;BACKUP all registers except Input and Output back to pre-subroutine values
ld r0 , backup_r0_4
ld r1 , backup_r1_4 
ld r2 , backup_r2_4
ld r3 , backup_r3_4
ld r4 , backup_r4_4 
ld r5 , backup_r5_4 
ld r6 , backup_r6_4
ld r7 , backup_r7_4




RET

;---------------	
;Data For Subroutine UPPER_CASE_SUB
;---------------

array_clear 	.FILL x5000
num_zero_clear	.FILL #0
num_100_counter .FILL #100
;backup register values
backup_r0_4 .blkw #1
backup_r1_4	.blkw #1 
backup_r2_4 .blkw #1
backup_r3_4 .blkw #1
backup_r4_4 .blkw #1  
backup_r5_4 .blkw #1    
backup_r6_4 .blkw #1
backup_r7_4 .blkw #1
