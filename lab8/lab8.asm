;=================================================
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Lab: lab 8, ex 1 & 2
; Lab section: 026
; TA: Jan-Shing Ling
; 
;=================================================

; test harness
					.orig x3000
					ld r6, sub_print_opcodes_sub_rout
					JSRR r6
					
					lea r0 ,sub_print_opcodes_msg 
					PUTS
					;;;;;;;;;;;;;;;;;;;;;;
				 
					ld r6, sub_find_opcode_sub_rout
					JSRR r6
					
					lea r0 ,sub_find_opcode_msg
					PUTS
				 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:

sub_print_opcodes_sub_rout .FILL x3200
sub_print_opcodes_msg .stringz "sub_print opcode sub rout done!!!\n"


sub_find_opcode_sub_rout .FILL x3600
sub_find_opcode_msg .stringz "sub_find opcode sub rout done!!!\n"



;===============================================================================================


; subroutines:
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODES
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;		 		 and corresponding opcode in the following format:
;		 		 ADD = 0001
;		  		 AND = 0101
;		  		 BR = 0000
;		  		 …
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3200
					;HINT back up 
st r0 , backup_r0_1
st r1 , backup_r1_1  ; because its output
st r2 , backup_r2_1
st r3 , backup_r3_1
st r4 , backup_r4_1
st r5 , backup_r5_1 
st r6 , backup_r6_1
st r7 , backup_r7_1
	
	ld r5, num_of_prints	
	ld r1, instructions_po_ptr 
	ld r4, opcodes_po_ptr ; r4 = opcodes_ptr
	PRINT_LOOP 
	;don'd use r2 because it will be used for the next 
		
		
		OUTPUT_INSTRUCTION_LOOP
			ldr r3, r1,#0 ; r3= mem[r1]
			add r3, r3, #0 ; r3 = r3
			Brz END_OF_STRING ; if zero go to end of string 
			ADD R0, R3, #0 ; r0 = r3
			OUT
			add r1, r1, #1 ;instr_ptr = instr_ptr + 1
			BR OUTPUT_INSTRUCTION_LOOP
			
			
		END_OF_STRING
			;print out equal string and opcode
			lea r0, equal_sign_string 
			PUTS
			
		;now the opcode part
		
		ldr r2, r4, #0 	;r2 = mem[r4] ;this is for the subroutine print opcode input
		ld r6 , print_opcode_sub_rout 
		JSRR r6 
		
		ld r0, print_opcodes_newline 
		OUT 
		
		;add the two pointers 
		add r1 , r1, #1 ; r1 = r1 
		add r4 , r4, #1
		
		;counter - 1 if positive go back to loop else get out of loop
		add r5, r5, #-1
		BRp PRINT_LOOP 
			
				 
		;THEN LOOP BACK FOR THE NUMBER OF TIMES		 
		;HINT Restore
ld r0 , backup_r0_1
ld r1 , backup_r1_1 ;output
ld r2 , backup_r2_1
ld r3 , backup_r3_1
ld r4 , backup_r4_1
ld r5 , backup_r5_1 
ld r6 , backup_r6_1
ld r7 , backup_r7_1		 
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODES local data
opcodes_po_ptr		.fill x4000
instructions_po_ptr	.fill x4100
print_opcode_sub_rout .FILL x3400

equal_sign_string .stringz " = "
print_opcodes_newline .FILL '\n' 
num_of_prints	.FILL #17

;backup register values
backup_r0_1 .blkw #1
backup_r1_1	.blkw #1 ;because its output for this subroutine
backup_r2_1 .blkw #1
backup_r3_1 .blkw #1
backup_r4_1 .blkw #1
backup_r5_1 .blkw #1   
backup_r6_1 .blkw #1
backup_r7_1 .blkw #1


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3400
st r0 , backup_r0_2
st r1 , backup_r1_2  ; because its output
st r2 , backup_r2_2
st r3 , backup_r3_2
st r4 , backup_r4_2
st r5 , backup_r5_2 
st r6 , backup_r6_2
st r7 , backup_r7_2
			
LD R5, shift_counter


MAIN_LOOP

	ADD R1, R2,#0 ;copy r2 into r1

	LD R4, msb 	;load x008 into r4

	AND R1, R1 , R4 ;mask r2 all except the first bit should be visible in R2

	LD R3, check_if_one ;load x008 

	NOT R3, R3      

	ADD R3, R3, #1 ;get two's complement opposite of x008


	ADD R1, R1, R3 ;add r2 and r3 and if zero there's a one 
				   ; and if its negative its a zero


	BRz OUTPUT_1 


		
		
	OUTPUT_0
		LD R0, zero_char 
		OUT
		BR MOVE_OUTSIDE_OUTPUT_1 ; added this here in case it goes to output 0
								 ; it doesn't output 1 as well
	OUTPUT_1
		LD R0, one_char 
		OUT
		
	MOVE_OUTSIDE_OUTPUT_1	
	ADD R2, R2, R2 ;add r2 with r2 to left shift the bits
	
	;ADD R7, R7, #-1
	;BRnz OUTSIDE_MAIN_LOOP
	
	ADD R5, R5, #-1 ;minus R5 if zero get stop computing bits else 
					;go back to main loop
	BRp MAIN_LOOP 
				 
				 
				 
ld r0 , backup_r0_2
ld r1 , backup_r1_2 ;output
ld r2 , backup_r2_2
ld r3 , backup_r3_2
ld r4 , backup_r4_2
ld r5 , backup_r5_2 
ld r6 , backup_r6_2
ld r7 , backup_r7_2						 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE local data


zero_char .FILL '0'
one_char .FILL '1'
msb 	.FILL x008
check_if_one .FILL x008


shift_counter .FILL #4

backup_r0_2 .blkw #1
backup_r1_2	.blkw #1 ;because its output for this subroutine
backup_r2_2 .blkw #1
backup_r3_2 .blkw #1
backup_r4_2.blkw #1
backup_r5_2.blkw #1   
backup_r6_2 .blkw #1
backup_r7_2 .blkw #1



;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 				as local data; it has searched the AL instruction list for that string, and reported
;				either the instruction/opcode pair, OR "Invalid instruction"
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3600
st r0 , backup_r0_3
st r1 , backup_r1_3 
st r2 , backup_r2_3
st r3 , backup_r3_3
st r4 , backup_r4_3
st r5 , backup_r5_3 
st r6 , backup_r6_3
st r7 , backup_r7_3			 
				 
	ld r2, string_ptr 
	ld r6, get_string_sub_rout	
	JSRR r6
	
	
	
;	ld r6, get_string_sub_rout	
;	JSRR r6
	ld r1, instructions_fo_ptr
	ld r2, string_ptr 
	
	
	ldr r3, r1, #0 ; r3 = mem [r1]
	ldr r4, r2, #0 ; r4 = mem [r2] 
	
;	ADD r3, r3 ,#0 ; r3 = r3 
;	BRz FAIL
	
;	ADD R4, R4, #0 ; r4 = r4
;	BRz FAIL 
	
	not r4, r4
	add r4, r4, #1 ; two's complement of r4
	
	add r3, r3, r4 ; if zero go to  sucess if not equal go to fail
	
	BRnp FAIL ;FAIL
	
	FAIL 
		
		
	
	
				 
				 
ld r0 , backup_r0_3
ld r1 , backup_r1_3 
ld r2 , backup_r2_3
ld r3 , backup_r3_3
ld r4 , backup_r4_3
ld r5 , backup_r5_3 
ld r6 , backup_r6_3
ld r7 , backup_r7_3						 
				 
				 ret
;-----------------------------------------------------------------------------------------------
; SUB_FIND_OPCODE local data
opcodes_fo_ptr			.fill x4000
instructions_fo_ptr		.fill x4100

get_string_sub_rout 	.FILL x3800
print_opcode_sub_rout_for_rout_2 	.FILL x3400 
string_ptr				.FILL x4200


backup_r0_3 .blkw #1
backup_r1_3	.blkw #1 
backup_r2_3 .blkw #1
backup_r3_3 .blkw #1
backup_r4_3.blkw #1
backup_r5_3.blkw #1   
backup_r6_3 .blkw #1
backup_r7_3 .blkw #1


.orig x4200
string_ptr_space .BLKW #50






;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 				by [ENTER]. That string has been stored as a null-terminated character array 
; 				at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;-----------------------------------------------------------------------------------------------
	.orig x3800
	
st r0 , backup_r0_4
st r1 , backup_r1_4  ; because its output
;st r2 , backup_r2_4
st r3 , backup_r3_4
st r4 , backup_r4_4
st r5 , backup_r5_4 
st r6 , backup_r6_4
st r7 , backup_r7_4			 
				 
	GET_INPUT
		GETC ; get characters 
		OUT ;  output character
		add r3, r0, #0 ;r3 = r0
		
		ld r1 , get_string_newline	
		NOT R1, R1 
		ADD R1, r1, #1 ;twos complement of r1 (newline)
		add r3, r3, r1 ;add r3 and r1 and if its zero get out of loop
		
		BRz IS_NEWLINE
		STR r0, r2, #0  ;mem[r2] <- r0
		ADD r2, R2, #1 ; r2 = r2 + 1
		BR GET_INPUT 
		
		
	IS_NEWLINE 
		ld r1, null_num  ; r1 = 0
		str r1, r2, #0 ;mem[r2] <- r1
		
		;add r2 , r2, #1
		
				 
ld r0 , backup_r0_4
ld r1 , backup_r1_4 ;output
;ld r2 , backup_r2_4
ld r3 , backup_r3_4
ld r4 , backup_r4_4
ld r5 , backup_r5_4 
ld r6 , backup_r6_4
ld r7 , backup_r7_4					 
				 
				 
				 
				 
	ret
;-----------------------------------------------------------------------------------------------
; SUB_GET_STRING local data
backup_r0_4 .blkw #1
backup_r1_4	.blkw #1 
backup_r2_4 .blkw #1
backup_r3_4 .blkw #1
backup_r4_4.blkw #1
backup_r5_4.blkw #1   
backup_r6_4 .blkw #1
backup_r7_4 .blkw #1

null_num		   .FILL #0
get_string_newline .FILL '\n'
;===============================================================================================


;-----------------------------------------------------------------------------------------------
; REMOTE DATA
					.ORIG x4000			; list opcodes as numbers, e.g. .fill #12 or .fill xC
opcodes
add_num .FILL #1
and_num .FILL #5
br_num	.FILL #0
jmp_num	.FILL #12
jsr_num .FILL #4
jsrr_num.FILL #4
ld_num 	.FILL #2
ldi_num	.FILL #10
ldr_num .FILL #6
lea_num .FILL #14
not_num .FILL #9
ret_num .FILL #12
rti_num .FILL #8
st_num  .FILL #3
sti_num .FILL #11
str_num .FILL #7
trap_num.FILL #15

 
					.ORIG x4100			; list AL instructions as null-terminated character strings, e.g. .stringz "JMP"
instructions				 			; - be sure to follow same order in opcode & instruction arrays!
add_msg .stringz "ADD"
and_msg .stringz "AND"
br_msg .stringz "BR"
jmp_msg .stringz "JMP"
jsr_msg .stringz "JSR"
jsrr_msg .stringz "JSRR"
ld_msg .stringz "LD"
ldi_msg .stringz "LDI"
ldr_msg .stringz "LDR"
lea_msg .stringz "LEA"
not_msg .stringz "NOT"
ret_msg .stringz "RET"
rti_msg .stringz "RTI"
st_msg .stringz "ST"
sti_msg .stringz "STI"
str_msg .stringz "STR"
trap_msg .stringz "TRAP"

;===============================================================================================
