;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Richard "Dylan" McGee
; Email: rmcge002@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 026
; TA: Jan-Shing Ling
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;testing subroutines code
	;ld r6 , get_machine_num_sub_rout	
	;JSRR r6

	;ld r6, print_num_sub_rout 
	;jsrr r6 
	
	;ld r6, all_mach_busy_sub_rout	
	;jsrr r6
	
	;ld r6, all_mach_free_sub_rout	
	;jsrr r6
	
	;ld r6, num_mach_busy_sub_rout
	;jsrr r6
	
	;ld r6, num_mach_free_sub_rout
	;jsrr r6
	
	;ld r6, first_free_sub_rout
	;jsrr r6
	
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
START_OF_MAIN_CODE
	;ld r1, num_ten_main 
	;ld r6, get_machine_num_sub_rout 
	;jsrr r6 
	
	;ld r6, print_num_sub_rout 
	;jsrr r6 
		
	
	ld r6, menu_sub_rout	
	JSRR r6
	
	ld r0, newline
	OUT 
	;all machines busy if statement
	add r3 , r1 , #0 ; r3 = r1
	ld r4, num_neg_one_main ; r4 = -1
	add r3, r3, r4 
	BRz ALL_MACHINES_BUSY_SUB_ROUT	
	

	;all machines free if statement
	add r3 , r1 , #0 ; r3 = r1
	ld r4, num_neg_two_main ; r4 = -2
	add r3, r3, r4 
	BRz ALL_MACHINES_FREE_SUB_ROUT	


	;all num busy machines if statement
	add r3 , r1 , #0 ; r3 = r1
	ld r4, num_neg_three_main ; r4 = -3
	add r3, r3, r4 
	BRz NUM_MACHINES_BUSY_SUB_ROUT	


	;all num free machines if statement
	add r3 , r1 , #0 ; r3 = r1
	ld r4, num_neg_four_main ; r4 = -4
	add r3, r3, r4 
	BRz NUM_MACHINES_FREE_SUB_ROUT	
	
	;machine status if statement
	add r3 , r1 , #0 ; r3 = r1
	ld r4, num_neg_five_main ; r4 = -5
	add r3, r3, r4 
	BRz MACHINE_STATUS_SUB_ROUT	
	
	;all first free machine if statement
	add r3 , r1 , #0 ; r3 = r1
	ld r4, num_neg_six_main ; r4 = -6
	add r3, r3, r4 
	BRz FIRST_FREE_SUB_ROUT	
	
	
	;goodbye / end program if statement
	add r3 , r1 , #0 ; r3 = r1
	ld r4, num_neg_seven_main ; r4 = -7
	add r3, r3, r4 
	BRz GOODBYE_ACTION	
	
	ALL_MACHINES_BUSY_SUB_ROUT
		ld r6, all_mach_busy_sub_rout	
		jsrr r6 ; go to all mach busy sub rout
		add r3, r2, #0 ; r3 = r1
		ld r4, num_neg_one_main ; r4 = -1
		add r3, r3, r4 
		BRz ALL_MACHINES_BUSY ; if zero it was 1 + -1 meaning all mach 
							  ;busy sub rout said all mach were busy
	
		NOT_ALL_MACHINES_BUSY
			lea r0, allnotbusy
			PUTS
			BR END_OF_MAIN_CODE
		ALL_MACHINES_BUSY
			lea r0, allbusy
			PUTS
			BR END_OF_MAIN_CODE
			
	ALL_MACHINES_FREE_SUB_ROUT
		ld r6, all_mach_free_sub_rout	
		jsrr r6 ; go to all mach busy sub rout
		add r3, r2, #0 ; r3 = r1
		ld r4, num_neg_one_main ; r4 = -1
		add r3, r3, r4 
		BRz ALL_MACHINES_FREE ; if zero it was 1 + -1 meaning all mach 
							  ;busy sub rout said all mach were busy
	
		NOT_ALL_MACHINES_FREE
			lea r0, allnotfree
			PUTS
			BR END_OF_MAIN_CODE
		ALL_MACHINES_FREE
			lea r0, allfree
			PUTS
			BR END_OF_MAIN_CODE
			
	NUM_MACHINES_BUSY_SUB_ROUT
		ld r6, num_mach_busy_sub_rout	
		jsrr r6 ; go to num mach busy sub rout
		add r1 , r2 , #0 ; r1 = r2 the output value of num_mach_busy_sub_rout
		lea r0,busymachine1
		PUTS
		ld r6, print_num_sub_rout ;print num of sub rout 
		jsrr r6 
		lea r0, busymachine2
		PUTS
		BR END_OF_MAIN_CODE
			

	NUM_MACHINES_FREE_SUB_ROUT
		ld r6, num_mach_free_sub_rout	
		jsrr r6 ; go to num mach busy sub rout
		add r1 , r2 , #0 ; r1 = r2 the output value of num_mach_free_sub_rout
		lea r0,busymachine1
		PUTS
		ld r6, print_num_sub_rout ;print num of sub rout 
		jsrr r6 
		lea r0, freemachine2
		PUTS
		BR END_OF_MAIN_CODE
	

	MACHINE_STATUS_SUB_ROUT
		ld r6, get_machine_num_sub_rout 
		jsrr r6 
		
		ld r6, mach_status_sub_rout 
		jsrr r6
		
		add r3, r2, #0
		
		ld r4, num_neg_one_main ; r4 = -1
		add r3, r3, r4 
		BRz MACHINE_STAT_FREE ; if zero it was 1 + -1 meaning r2 was 1
							  ; meaning r2 was free
	
		MACHINE_STAT_BUSY
			lea r0, status1
			PUTS
			;add r1,r2, #0 ; r1 = r2 for print num
			
			ld r6, print_num_sub_rout ;print num of sub rout 
		    jsrr r6 	
			
			lea r0, status2
			PUTS
			
			BR END_OF_MAIN_CODE
		MACHINE_STAT_FREE
			lea r0, status1
			PUTS
			;add r1,r2, #0 ; r1 = r2 for print num
			
			ld r6, print_num_sub_rout ;print num of sub rout 
		    jsrr r6 	
			
			lea r0, status3
			PUTS
						
			BR END_OF_MAIN_CODE	



	FIRST_FREE_SUB_ROUT
		ld r6, first_free_sub_rout	
		jsrr r6 ; go to num mach busy sub rout
		add r1 , r2 , #0 ; r1 = r2 ;bc output value of first free is r2
		ld r3, num_neg_sixteen_main ; r3 = -16
		add r1, r1, r3; if zero r1 is sixteen and thus there are no
					  ; free machines
		BRZ NO_FREE_MACHINES
		
		FIRST_FREE_MACHINE
			add r1,r2, #0 ; r1 = r2 for print num
			lea r0, firstfree1
			PUTS
			
		    ld r6, print_num_sub_rout ;print num of sub rout 
		    jsrr r6 	
		    
		    ld r0, newline 
		    OUT
		    BR END_OF_MAIN_CODE	
		
		NO_FREE_MACHINES
			lea r0, firstfree2
			PUTS
			BR END_OF_MAIN_CODE
							
		;now r1 has has the machine number for 
		;machine status
		
	GOODBYE_ACTION
		lea r0, goodbye 
		PUTS
		BR END_PROGRAM ;ends the program
	
	END_OF_MAIN_CODE
	
	BR START_OF_MAIN_CODE

END_PROGRAM
HALT
;---------------	
;Data
;---------------
;Subroutine pointers
menu_sub_rout .FILL x3200
all_mach_busy_sub_rout .FILL x3400
all_mach_free_sub_rout .FILL x3600

num_mach_busy_sub_rout .FILL x3800
num_mach_free_sub_rout .FILL x4000

mach_status_sub_rout 	.FILL x4200
first_free_sub_rout		.FILL x4400

get_machine_num_sub_rout .FILL x4600
print_num_sub_rout		.FILL x4800



;Other data 
newline 		.fill '\n'
num_zero_main   .FILL #0
;num_one_main    .FILL #1
;num_two_main    .FILL #2
;num_three_main  .FILL #3
;num_four_main   .FILL #4
;num_five_main   .FILL #5
;num_six_main   .FILL #6
;num_seven_main .FILL #7

;num_ten_main 	.FILL #0

num_neg_one_main    .FILL #-1
num_neg_two_main    .FILL #-2
num_neg_three_main  .FILL #-3
num_neg_four_main   .FILL #-4
num_neg_five_main   .FILL #-5
num_neg_six_main   .FILL #-6
num_neg_seven_main .FILL #-7
num_neg_sixteen_main .FILL #-16

; Strings for reports from menu subroutines:
goodbye         .stringz "Goodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
;freemachine1    .stringz "There are " ; got rid of it since its same as busy machine 1
freemachine2    .stringz " free machines\n"
status1         .stringz "Machine "
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
firstfree1      .stringz "The first available machine is number "
firstfree2      .stringz "No machines are free\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
.orig x3200
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------

;HINT back up 
st r0 , backup_r0_1
;st r1 , backup_r1_1  ; because its output
st r2 , backup_r2_1
st r3 , backup_r3_1
st r4 , backup_r4_1
st r5 , backup_r5_1 
st r6 , backup_r6_1
st r7 , backup_r7_1


MENU_LOOP

	LD R0, Menu_string_addr
	PUTS ;output menu
	NEWLINE_START
	GETC  ;get char
	add r2 , r0, #0 ; r2 = r0 
	ld r1 , menu_newline ; 
	not r1, r1
	add r1, r1, #1
	add r2,r1,r2 ;
	BRz NEWLINE_START
	OUT	  ;output char
	
	
	ADD R1, R0, #0 ;put char into r1
	
	
	ADD R3, R1, #0 ;r3 = r1 
	
	ld r4, char_low_end ; r4 = '1'
	
	NOT R4, R4
	ADD R4, R4, #1 ; get negative of ascii '1'
	
	ADD R3, R3, R4 ;if zero or positive then inputted char is not lower than low end char
	BRn ERROR_MENU
	ADD R3, R1, #0 ;r3 = r1 
	
	ld r4, char_high_end ; r4 = '7'
	
	NOT R4, R4
	ADD R4, R4, #1 ; get negative of ascii '7'
	
	ADD R3, R3, R4 ;if zero or negative then inputted char is not higher than high end char
	Brp ERROR_MENU
	
	;if neither of the break commands above run then we know that the input is indeed valid	
	
	
	ld r2, ascii_offset; load ascii offset

	NOT R2, R2
	ADD R2, r2, #1 ; get negative of ascii to add to r1 to get num not char 

	ADD R1, r1, r2 ;add r1 and -x30 to get num value 
				   ;num value now stored in r1
	
	;ld r0, menu_newline
	;OUT
	BR END_MENU_LOOP
	

ERROR_MENU	
	LEA R0, Error_msg_1
	PUTS
	BR MENU_LOOP

END_MENU_LOOP


;HINT Restore
ld r0 , backup_r0_1
;ld r1 , backup_r1_1 ;output
ld r2 , backup_r2_1
ld r3 , backup_r3_1
ld r4 , backup_r4_1
ld r5 , backup_r5_1 
ld r6 , backup_r6_1
ld r7 , backup_r7_1

RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
;backup register values
backup_r0_1 .blkw #1
;backup_r1_1	.blkw #1 ;because its output for this subroutine
backup_r2_1 .blkw #1
backup_r3_1 .blkw #1
backup_r4_1 .blkw #1
backup_r5_1 .blkw #1   
backup_r6_1 .blkw #1
backup_r7_1 .blkw #1

Error_msg_1	      .STRINGZ "\nINVALID INPUT\n" ;changed this string to have \n at the front
Menu_string_addr  .FILL x6A00
ascii_offset	  .FILL x30
menu_newline	  .FILL '\n'
char_high_end 	  .FILL '7'
char_low_end 	  .FILL '1'




;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.orig x3400
;HINT back up 
st r0 , backup_r0_2
st r1 , backup_r1_2  
;st r2 , backup_r2_2 ; because its output
st r3 , backup_r3_2
st r4 , backup_r4_2
st r5 , backup_r5_2 
st r6 , backup_r6_2
st r7 , backup_r7_2


ld r3 , compare_bit_all_mach_busy		;r3 = 0x01
ld r4 , counter_all_mach_busy			;r4 = 15
ldi r5 , BUSYNESS_ADDR_ALL_MACHINES_BUSY ;r5 = busyness vector

ld r6 , num_zero_all_mach_busy; r6 = 0
ld r1, num_zero_all_mach_busy ; r1 = 0
COMPARE_LOOP_ALL_MACH_BUSY
	AND R6, R5, r3 ;
	Brz IS_BUSY ; if and compare bit and r5 come out to zero then busyness vector was 0 (busy)
				; at that point
	
	IS_FREE ;one means free
		ld r1, not_all_busy_flag	
		BR END_OF_IS_FREE_OR_IS_BUSY
		
	IS_BUSY ; zero means busy
		;nothing since not need 
	
	END_OF_IS_FREE_OR_IS_BUSY	
	
	add r3, r3, r3 ;left shift r3 to go to next comparator bit
	add r4, r4, #-1 ; minus counter 
		
	BRp COMPARE_LOOP_ALL_MACH_BUSY
	
	ADD R1, R1, #0 
	BRz ALL_MACH_ARE_BUSY
	
	ALL_MACH_ARE_NOT_BUSY
		ld r2, r2_not_all_mach_busy; r2 = 0
		Br END_IF_ALL_MACH_BUSY
		
	ALL_MACH_ARE_BUSY
		ld r2 ,r2_all_mach_busy ; r2 = 1
		
	END_IF_ALL_MACH_BUSY
			
			
;HINT Restore
ld r0 , backup_r0_2
ld r1 , backup_r1_2 ;output
;ld r2 , backup_r2_2
ld r3 , backup_r3_2
ld r4 , backup_r4_2
ld r5 , backup_r5_2 
ld r6 , backup_r6_2
ld r7 , backup_r7_2
	RET
	
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xBA00

compare_bit_all_mach_busy .FILL x0001
counter_all_mach_busy	.FILL #16
num_zero_all_mach_busy	.FILL #0
not_all_busy_flag		.FILL #1

r2_all_mach_busy		.FILL #1
r2_not_all_mach_busy	.FILL #0

;backup register values
backup_r0_2 .blkw #1
backup_r1_2	.blkw #1 ;because its output for this subroutine
;backup_r2_2 .blkw #1
backup_r3_2 .blkw #1
backup_r4_2 .blkw #1
backup_r5_2 .blkw #1   
backup_r6_2 .blkw #1
backup_r7_2 .blkw #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
.orig x3600
;HINT back up 
;HINT back up 
st r0 , backup_r0_3
st r1 , backup_r1_3  
;st r2 , backup_r2_3 ; because its output
st r3 , backup_r3_3
st r4 , backup_r4_3
st r5 , backup_r5_3 
st r6 , backup_r6_3
st r7 , backup_r7_3


ld r3 , compare_bit_all_mach_free		;r3 = 0x01
ld r4 , counter_all_mach_free			;r4 = 15
ldi r5 , BUSYNESS_ADDR_ALL_MACHINES_FREE ;r5 = busyness vector

ld r6 , num_zero_all_mach_free; r6 = 0
ld r1, num_zero_all_mach_free ; r1 = 0
COMPARE_LOOP_ALL_MACH_FREE
	AND R6, R5, r3 ;
	Brz IS_BUSY_ALL_MACH_FREE ; if and compare bit and r5 come out to zero then busyness vector was 0 (busy)
				; at that point
	
	IS_FREE_ALL_MACH_FREE ;one means free
		;ld r1, not_all_busy_flag	
		BR END_OF_IS_FREE_OR_IS_BUSY_FOR_ALL_MACH_FREE
		
	IS_BUSY_ALL_MACH_FREE ; zero means busy
		ld r1, not_all_free_flag
		;nothing since not need 
	
	END_OF_IS_FREE_OR_IS_BUSY_FOR_ALL_MACH_FREE	
	
	add r3, r3, r3 ;left shift r3 to go to next comparator bit
	add r4, r4, #-1 ; minus counter 
		
	BRp COMPARE_LOOP_ALL_MACH_FREE
	
	ADD R1, R1, #0 
	BRz ALL_MACH_ARE_FREE
	
	ALL_MACH_ARE_NOT_FREE
		ld r2, r2_not_all_mach_free; r2 = 0
		Br END_IF_ALL_MACH_FREE
		
	ALL_MACH_ARE_FREE
		ld r2 ,r2_all_mach_free ; r2 = 1
		
	END_IF_ALL_MACH_FREE
			
			
;HINT Restore
ld r0 , backup_r0_3
ld r1 , backup_r1_3 
;ld r2 , backup_r2_3 ;output
ld r3 , backup_r3_3
ld r4 , backup_r4_3
ld r5 , backup_r5_3 
ld r6 , backup_r6_3
ld r7 , backup_r7_3
	RET

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xBA00

compare_bit_all_mach_free .FILL x0001
counter_all_mach_free	.FILL #16
num_zero_all_mach_free	.FILL #0
not_all_free_flag		.FILL #1

r2_all_mach_free		.FILL #1
r2_not_all_mach_free	.FILL #0

;backup register values
backup_r0_3 .blkw #1
backup_r1_3	.blkw #1 ;because its output for this subroutine
;backup_r2_3 .blkw #1
backup_r3_3 .blkw #1
backup_r4_3 .blkw #1
backup_r5_3 .blkw #1   
backup_r6_3 .blkw #1
backup_r7_3 .blkw #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
.orig x3800
;HINT back up 
st r0 , backup_r0_4
st r1 , backup_r1_4  
;st r2 , backup_r2_4 ; because its output
st r3 , backup_r3_4
st r4 , backup_r4_4
st r5 , backup_r5_4 
st r6 , backup_r6_4
st r7 , backup_r7_4


ld r3 , compare_bit_num_mach_busy		;r3 = 0x01
ld r4 , count_down_num_mach_busy			;r4 = 16
ldi r5 , BUSYNESS_ADDR_NUM_BUSY_MACHINES  ;r5 = busyness vector

ld r6 , num_zero_num_mach_busy; r6 = 0
;ld r1, num_zero_num_mach_busy ; r1 = 0

ld r2, num_zero_num_mach_busy ; r1 = 0


COMPARE_LOOP_NUM_MACH_BUSY
	AND R6, R5, r3 ;
	Brz IS_BUSY_NUM_MACH_BUSY ; if and compare bit and r5 come out to zero then busyness vector was 0 (busy)
				; at that point
	
	IS_FREE_NUM_MACH_BUSY ;one means free
		;nothing since just counting num mach busy	
		BR END_OF_IS_FREE_OR_IS_BUSY_FOR_NUM_MACH_BUSY
		
	IS_BUSY_NUM_MACH_BUSY ; zero means busy
		add r2, r2, #1
		;nothing since not need 
	
	END_OF_IS_FREE_OR_IS_BUSY_FOR_NUM_MACH_BUSY	
	
	add r3, r3, r3 ;left shift r3 to go to next comparator bit
	add r4, r4, #-1 ; minus counter 
		
	BRp COMPARE_LOOP_NUM_MACH_BUSY
	
	;should just have in r2 the num of busy machines		
			
;HINT Restore
ld r0 , backup_r0_4
ld r1 , backup_r1_4 ;output
;ld r2 , backup_r2_4
ld r3 , backup_r3_4
ld r4 , backup_r4_4
ld r5 , backup_r5_4 
ld r6 , backup_r6_4
ld r7 , backup_r7_4
	RET

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xBA00

compare_bit_num_mach_busy .FILL x0001
count_down_num_mach_busy	.FILL #16
num_zero_num_mach_busy	.FILL #0
;not_all_free_flag		.FILL #1

counter_num_mach_busy	.FILL #0

;r2_all_mach_free		.FILL #1
;r2_not_all_mach_free	.FILL #0

;backup register values
backup_r0_4 .blkw #1
backup_r1_4	.blkw #1 ;because its output for this subroutine
;backup_r2_4 .blkw #1
backup_r3_4 .blkw #1
backup_r4_4 .blkw #1
backup_r5_4 .blkw #1   
backup_r6_4 .blkw #1
backup_r7_4 .blkw #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
.orig x4000
;HINT back up 
st r0 , backup_r0_5 
st r1 , backup_r1_5  
;st r2 , backup_r2_5 ; because its output
st r3 , backup_r3_5
st r4 , backup_r4_5
st r5 , backup_r5_5 
st r6 , backup_r6_5
st r7 , backup_r7_5


ld r3 , compare_bit_num_mach_free		;r3 = 0x01
ld r4 , count_down_num_mach_free			;r4 = 16
ldi r5 , BUSYNESS_ADDR_NUM_FREE_MACHINES  ;r5 = busyness vector

ld r6 , num_zero_num_mach_free; r6 = 0
;ld r1, num_zero_num_mach_busy ; r1 = 0

ld r2, num_zero_num_mach_free ; r1 = 0


COMPARE_LOOP_NUM_MACH_FREE
	AND R6, R5, r3 ;
	Brz IS_BUSY_NUM_MACH_FREE ; if and compare bit and r5 come out to zero then busyness vector was 0 (busy)
				; at that point
	
	IS_FREE_NUM_MACH_FREE ;one means free
		add r2, r2, #1 ; r2 += 1 (counter of free machines)
		BR END_OF_IS_FREE_OR_IS_BUSY_FOR_NUM_MACH_FREE
		
	IS_BUSY_NUM_MACH_FREE ; zero means busy
		;nothing since just counting num mach free	
		
	
	END_OF_IS_FREE_OR_IS_BUSY_FOR_NUM_MACH_FREE
	
	add r3, r3, r3 ;left shift r3 to go to next comparator bit
	add r4, r4, #-1 ; minus counter 
		
	BRp COMPARE_LOOP_NUM_MACH_FREE
	
	;should just have in r2 the num of busy machines		
			
;HINT Restore
ld r0 , backup_r0_5
ld r1 , backup_r1_5 ;output
;ld r2 , backup_r2_5
ld r3 , backup_r3_5
ld r4 , backup_r4_5
ld r5 , backup_r5_5 
ld r6 , backup_r6_5
ld r7 , backup_r7_5
	RET


;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xBA00

compare_bit_num_mach_free .FILL x0001
count_down_num_mach_free	.FILL #16
num_zero_num_mach_free	.FILL #0
;not_all_free_flag		.FILL #1

counter_num_mach_free	.FILL #0

;r2_all_mach_free		.FILL #1
;r2_not_all_mach_free	.FILL #0

;backup register values
backup_r0_5 .blkw #1
backup_r1_5	.blkw #1 ;because its output for this subroutine
;backup_r2_5 .blkw #1
backup_r3_5 .blkw #1
backup_r4_5 .blkw #1
backup_r5_5 .blkw #1   
backup_r6_5 .blkw #1
backup_r7_5 .blkw #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
.orig x4200
;HINT back up 
st r0 , backup_r0_6 
st r1 , backup_r1_6 
;st r2 , backup_r2_6 ; because its output
st r3 , backup_r3_6
st r4 , backup_r4_6
st r5 , backup_r5_6 
st r6 , backup_r6_6
st r7 , backup_r7_6

add r3, r1, #0 ; r3 = 0
ld r4, compare_bit_mach_stat ; r4 = 0x0001
ldi r5, BUSYNESS_ADDR_MACHINE_STATUS ; r5= busyness vector


COMPARE_LOOP_MACH_STAT
	add r3,r3, #0; r3 = r3 
	BRz OUTSIDE_COMPARE_LOOP_MACH_STAT
	
	add r4, r4, r4; r4 = 0x0002 ;left shifts comparator bit
	add r3, r3, #-1 ;if positive go back to loop 
	BRp COMPARE_LOOP_MACH_STAT

OUTSIDE_COMPARE_LOOP_MACH_STAT
	and r5, r5,r4; and busyness and comparator mask and if zero machine is busy
				; and if one machine is free
	Brz IS_BUSY_MACH_STAT ; if and compare bit and r5 come out to zero then busyness vector was 0 (busy)
				; at that point
	
	IS_FREE_MACH_STAT ;one means free
		ld r2, num_one_mach_stat
		BR END_OF_IS_FREE_OR_IS_BUSY_FOR_MACH_STAT
		
	IS_BUSY_MACH_STAT ; zero means busy
		ld r2, num_zero_mach_stat
		;nothing since just counting num mach free	
		
END_OF_IS_FREE_OR_IS_BUSY_FOR_MACH_STAT

;HINT Restore
ld r0 , backup_r0_6
ld r1 , backup_r1_6 ;output
;ld r2 , backup_r2_6
ld r3 , backup_r3_6
ld r4 , backup_r4_6
ld r5 , backup_r5_6 
ld r6 , backup_r6_6
ld r7 , backup_r7_6
	RET
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xBA00

compare_bit_mach_stat .FILL x0001

num_one_mach_stat		.FILL #1
num_zero_mach_stat 		.FILL #0



;backup register values
backup_r0_6 .blkw #1
backup_r1_6	.blkw #1 ;because its output for this subroutine
;backup_r2_6 .blkw #1
backup_r3_6 .blkw #1
backup_r4_6 .blkw #1
backup_r5_6 .blkw #1   
backup_r6_6 .blkw #1
backup_r7_6 .blkw #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
.orig x4400
;HINT back up 
st r0 , backup_r0_7 
st r1 , backup_r1_7 
;st r2 , backup_r2_7 ; because its output
st r3 , backup_r3_7
st r4 , backup_r4_7
st r5 , backup_r5_7 
st r6 , backup_r6_7
st r7 , backup_r7_7


ld r3 , compare_bit_first_free		;r3 = 0x01
ld r4 , count_down_first_free			;r4 = 16
ldi r5 , BUSYNESS_ADDR_FIRST_FREE  ;r5 = busyness vector

ld r6 , num_zero_first_free; r6 = 0
;ld r1, num_zero_num_mach_busy ; r1 = 0

ld r2, num_zero_first_free ; r1 = 0


COMPARE_LOOP_FIRST_FREE
	AND R6, R5, r3 ;
	Brz IS_BUSY_FIRST_FREE ; if and compare bit and r5 come out to zero then busyness vector was 0 (busy)
				; at that point
	
	IS_FREE_FIRST_FREE ;one means free
		BR GET_OUT_FOUND_FIRST_FREE
		
	IS_BUSY_FIRST_FREE ; zero means busy
		add r2, r2, #1 ; r2 += 1 (counter of machines to get to first free)
		;nothing since just counting num mach free	
		
	
	END_OF_IS_FREE_OR_IS_BUSY_FOR_FIRST_FREE
	
	add r3, r3, r3 ;left shift r3 to go to next comparator bit
	add r4, r4, #-1 ; minus counter 
		
	BRp COMPARE_LOOP_FIRST_FREE
	
	GET_OUT_FOUND_FIRST_FREE
		
			
;HINT Restore
ld r0 , backup_r0_7
ld r1 , backup_r1_7 ;output
;ld r2 , backup_r2_7
ld r3 , backup_r3_7
ld r4 , backup_r4_7
ld r5 , backup_r5_7 
ld r6 , backup_r6_7
ld r7 , backup_r7_7
	RET
	
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xBA00

compare_bit_first_free .FILL x0001
count_down_first_free	.FILL #16
num_zero_first_free	.FILL #0
;not_all_free_flag		.FILL #1

counter_first_free	.FILL #0

;r2_all_mach_free		.FILL #1
;r2_not_all_mach_free	.FILL #0

;backup register values
backup_r0_7 .blkw #1
backup_r1_7	.blkw #1 ;because its output for this subroutine
;backup_r2_7 .blkw #1
backup_r3_7 .blkw #1
backup_r4_7 .blkw #1
backup_r5_7 .blkw #1   
backup_r6_7 .blkw #1
backup_r7_7 .blkw #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
;HINT back up 
.ORIG x4600

;HINT back up 
st r0 , backup_r0_8
;st r1 , backup_r1_8  ; because its output
st r2 , backup_r2_8
st r3 , backup_r3_8
st r4 , backup_r4_8
st r5 , backup_r5_8 
st r6 , backup_r6_8
st r7 , backup_r7_8

;-------------
;Instructions SUBROUTINE 1
;-------------
START_OF_CODE
; output intro prompt
lea R0, prompt
PUTS

						
; Set up flags, counters, accumulators as needed

ld r2 ,num_counter ;r2 = 5 ;change to num counter = 2
ld r3 , num_ten    ;r3 = 10
;r6 will have neg flag
;r2 will hold the sum

; Get first character, test for '\n', '+', '-', digit/non-digit 	
					GETC 
					OUT
					; is very first character = '\n'? if so, just quit (no message)!
					ADD R4, R0, #0 ; R4 = R0
					LD R5, char_newline
					NOT R5, R5
					ADD R5, R5, #1;get twos complement of newline
					ADD R4, R4, R5 
					;BRz END_OF_CODE	      ;if zero go to end of code
					BRz ERROR
					
					; is it = '+'? if so, ignore it, go get digits
					ADD R4, R0, #0 ; R4 = R0
					LD R5, char_pos
					NOT R5, R5
					ADD R5, R5, #1;get twos complement of pos sign
					ADD R4, R4, R5 
					BRz GET_DIGITS_BEFORE	 ;if zero go to GET DIGITS
					; is it = '-'? if so, set neg flag, go get digits ;ACTUALLY NOW TREAT IT LIKE AN ERROR
					ADD R4, R0, #0 ; R4 = R0
					LD R5, char_neg
					NOT R5, R5
					ADD R5, R5, #1;get twos complement of neg sign
					ADD R4, R4, R5 
					;BRz IF_NEG	;if zero go to IF_NEG				
					Brz ERROR ; if zero go to errror since '-' no valid in this program
					; is it < '0'? if so, it is not a digit	- o/p error message, start over
					ADD R4, R0, #0 ; R4 = R0
					LD R5, char_zero
					NOT R5, R5
					ADD R5, R5, #1;get twos complement of zero char
					ADD R4, R4, R5  
					BRn ERROR ;if negative go then char zero is bigger than 
									;char inputted there is error
					
					; is it > '9'? if so, it is not a digit	- o/p error message, start over
					ADD R4, R0, #0 ; R4 = R0
					LD R5, char_nine
					NOT R5, R5
					ADD R5, R5, #1;get twos complement of nine char
					ADD R4, R4, R5  
					BRp ERROR ;if negative go then char zero is bigger than 
					
					
					; if none of the above, first character is first numeric digit - convert it to number & store in target register!
					ADD R4, R0, #0
					LD R5, ascii_offset_get_num
					NOT R5, R5
					ADD R5, R5, #1	;get two's complement of ascii offset
					ADD R4, R4, R5 ;add r4 with ascii offset to get num of char
					ADD r1, R4, #0; put r4 num into r2
					ADD r2, r2, #-1 ;r1 has num counter do num counter -1 
					BR GET_DIGITS 	;afterwards go get rest of digits
					
					IF_NEG 
						LD R6, num_neg_one ;give r6 the neg flag
					BR GET_DIGITS_BEFORE
					
					ERROR
						ld r0, char_newline
						OUT
						lea r0, Error_msg_2 
						PUTS
						;ld r0, char_newline
						;OUT
					BR START_OF_CODE
					
					ERROR_OTHER
						lea r0, Error_msg_2 
						PUTS
						
					BR START_OF_CODE
					
					GET_DIGITS_BEFORE
						ld r1, num_zero
					
; Now get remaining digits (max 5) from user, testing each to see if it is a digit, and build up number in accumulator
					GET_DIGITS
						ld r3, num_ten ;r3 = 10
					
						GETC  
						OUT
						; is very first character = '\n'? if so, just quit (no message)!
						ADD R4, R0, #0 ; R4 = R0
						LD R5, char_newline
						NOT R5, R5
						ADD R5, R5, #1;get twos complement of newline
						ADD R4, R4, R5 
						BRz NEAR_END_OF_CODE	      ;if zero go to end of code						
						
						; is it < '0'? if so, it is not a digit	- o/p error message, start over
						ADD R4, R0, #0 ; R4 = R0
						LD R5, char_zero
						NOT R5, R5
						ADD R5, R5, #1;get twos complement of zero char
						ADD R4, R4, R5  
						BRn ERROR ;if negative go then char zero is bigger than 
										;char inputted there is error
						
						; is it > '9'? if so, it is not a digit	- o/p error message, start over
						ADD R4, R0, #0 ; R4 = R0
						LD R5, char_nine
						NOT R5, R5
						ADD R5, R5, #1;get twos complement of nine char
						ADD R4, R4, R5  
						BRp ERROR ;if negative go then char zero is bigger than 
						
						
						;if previous breaks did not happen we know now that it is a number
						ADD R4, R0, #0
						LD R5, ascii_offset_get_num
						NOT R5, R5
						ADD R5, R5, #1	;get two's complement of ascii offset
						ADD R4, R4, R5 ;add r4 with ascii offset to get num of char
						
						ADD r5, r1, #0 ;r5 equals r2 orignal value
						MULT_10
							add r1, r1, r5
							add r3, r3, #-1 ; if r3 > 0 since it start at 10
											;keep adding r2 wth r2 
							BRp MULT_10
							
						
						ADD r1, R1, r4; add r2 and r4 
						;ADD r2, r2, #-1 ;r1 has num counter do num counter -1 
						;Brp GET_DIGITS
						Br GET_DIGITS
						
							;need two neg flag statements because of two newline cases
							;if neg flag was set 
							ADD R6, R6, #0  ; sets r6 = r6  because neg flag already set earlier
							Brn IS_NEG_1
							IS_POS_1
								Br END_OF_IF_NEG_1
							IS_NEG_1
								NOT R1, R1
								ADD R1, R1, #1
								BR END_OF_IF_NEG_1														
							END_OF_IF_NEG_1
							
							;do newline 

							;is it > 15? if so, it is to big	- o/p error message, start over
							ADD R4, R1, #0 ; R4 = R1
							LD R5, num_fifteen 
							NOT R5, R5
							ADD R5, R5, #1;get twos complement of num fifteen
							ADD R4, R4, R5  
							BRp ERROR ;if positive then r1 value is bigger than 15 which is an error
							
							ld r0 , char_newline
							OUT
							BR END_OF_CODE 
							
						NEAR_END_OF_CODE
							;if neg flag was set 
							;ADD R6, R6, #0  ; sets r6 = r6  because neg flag already set earlier
							;Brn IS_NEG_2
							;IS_POS_2
							;	Br END_OF_IF_NEG_2
							;IS_NEG_2
							;	NOT R1, R1
						;		ADD R1, R1, #1
						;		BR END_OF_IF_NEG_2														
						;	END_OF_IF_NEG_2
							
							;is it > 15? if so, it is to big	- o/p error message, start over
							ADD R4, R1, #0 ; R4 = R1
							LD R5, num_fifteen 
							NOT R5, R5
							ADD R5, R5, #1;get twos complement of num fifteen
							ADD R4, R4, R5  
							BRp ERROR ;if positive then r1 value is bigger than 15 which is an error
							
							ld r5, num_counter ;need to check if nothing entered after initial sign
							NOT r5, r5
							ADD R5, R5, #1
							
							ADD R2, r2,r5
							BRz ERROR_OTHER
							
							
						; remember to end with a newline!
						
					END_OF_CODE
					
					
					;HINT Restore
					ld r0 , backup_r0_8
					;ld r1 , backup_r1_8 ;output
					ld r2 , backup_r2_8
					ld r3 , backup_r3_8
					ld r4 , backup_r4_8
					ld r5 , backup_r5_8 
					ld r6 , backup_r6_8
					ld r7 , backup_r7_8
					RET

;---------------	
; Program Data
;---------------

;introPromptPtr		.FILL xA100
;errorMessagePtr		.FILL xA200

num_counter .FILL #2 ;changed from 5 to 2 since it must be between 0 and 15
num_ten 	.FILL #9 ;because of mult 10 loop going until its zero 
num_fifteen .FILL #15 ;num fifteen to check for upper bound
num_neg_one .FILL #-1
num_zero 	.FILL #0
char_newline .FILL '\n'
char_pos	.FILL '+'
char_neg	.FILL '-'
char_zero	.FILL '0'
char_nine	.FILL '9'
ascii_offset_get_num .FILL x30

;backup register values
backup_r0_8 .blkw #1
;backup_r1_8	.blkw #1 ;because its output for this subroutine
backup_r2_8 .blkw #1
backup_r3_8 .blkw #1
backup_r4_8 .blkw #1
backup_r5_8 .blkw #1   
backup_r6_8 .blkw #1
backup_r7_8 .blkw #1

;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,15}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
; WITHOUT leading 0's, a leading sign, or a trailing newline.
;      Note: that number is guaranteed to be in the range {#0, #15}, 
;            i.e. either a single digit, or '1' followed by a single digit.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.orig x4800

;HINT back up 
st r0 , backup_r0_9
st r1 , backup_r1_9 
st r2 , backup_r2_9 
st r3 , backup_r3_9
st r4 , backup_r4_9
st r5 , backup_r5_9 
st r6 , backup_r6_9
st r7 , backup_r7_9



; do ten test 
add r2, r1, #0
ld r3, num_neg_10
add r3, r3,r2

Brz OUTPUT_TEN

;switch r2 and r1 


ADD R2 , R1, #0 ; R2 = R1 (original value) 


;;;;;;;;;;;;;;;;;;;; TENS SECTION
ld r3, num_neg_10 ; r3 = -10

ld r4, counter		;r4 = 0

TENS_LOOP
	ADD R4, R4, #1  ; counter + 1
	add r2 , r2, r3 ; r1 = r1 + -10
	
	Brp TENS_LOOP 
	
;if it's negative add back 10 and minus one to the counter since the negative subtraction shouldn't count
ld r3, num_10 ; r3 = 10
add r2, r2, r3   ;r1 = r1 +10
add r4, r4, #-1  ;-1 to counter

add r4, r4,#0 ;r4 = r4 
BRz ONES_SECTION ;if zero go to ones section

ld r3, ascii_offset_print 
add r0, r4, r3 ;r0 = char of counter (r4 + x30)
OUT

ONES_SECTION
;;;;;;;;;;;;;;;;;;;; ONES SECTION
ld r3, num_neg_1 ; r3 = -1

ld r4, counter		;r4 = 0

ONES_LOOP
	ADD R4, R4, #1  ; counter + 1
	add r2 , r2, r3 ; r1 = r1 + -1
	
	Brp ONES_LOOP 


	
;if it's negative add back 10 and minus one to the counter since the negative subtraction shouldn't count
ld r3, num_1 ; r3 = 10
add r2, r2, r3   ;r1 = r1 +10
BRz OUTPUT_ZERO 
;add r4, r4, #-1  ;-1 to counter ;don't minus on the last one

OUTPUT
	ld r3, ascii_offset_print
	add r0, r4, r3 ;r0 = char of counter (r4 + x30)
	OUT
BR OUTSIDE_OUTPUT

OUTPUT_ZERO 
	ld r3, ascii_offset_print
	add r0, r2, r3 ;r0 = char of counter (r4 + x30)
	OUT
	Br OUTSIDE_OUTPUT

OUTPUT_TEN 
	ld r0, char_one_print_num	
	OUT
	ld r0, char_zero_print_num
	OUT
	
OUTSIDE_OUTPUT
;HINT Restore
ld r0 , backup_r0_9
ld r1 , backup_r1_9 
ld r2 , backup_r2_9 
ld r3 , backup_r3_9
ld r4 , backup_r4_9
ld r5 , backup_r5_9 
ld r6 , backup_r6_9
ld r7 , backup_r7_9

RET
;--------------------------------
;Data for subroutine print number
;--------------------------------
;backup register values
backup_r0_9 .blkw #1
backup_r1_9	.blkw #1
backup_r2_9 .blkw #1 
backup_r3_9 .blkw #1
backup_r4_9 .blkw #1
backup_r5_9 .blkw #1   
backup_r6_9 .blkw #1
backup_r7_9 .blkw #1

ascii_offset_print .FILL x30
num_neg_10         .FILL #-10
num_neg_1     	   .FILL #-1

char_one_print_num		.FILL '1'
char_zero_print_num		.FILL '0'
num_10         .FILL #10
num_1     	   .FILL #1

num_0 		   .FILL #0

counter		.FILL #0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.ORIG x6A00
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xBA00			; Remote data
BUSYNESS .FILL  x8000		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.
				;xABCD
;---------------	
;END of PROGRAM
;---------------	
.END
