#Program Name: ExamLoop.s
#Author: Johnnie Massart
#Date: 12/7/2023
#Purpose: Display Loop understanding for Exam
.text
.global main
main:
	#push the stack
	SUB sp, sp, #4
	STR lr, [sp]

	#user prompt
	LDR r0, =prompt1
	BL printf

	#scan user input
	LDR r0, =formatInput1
	LDR r1, =input1
	BL scanf

	#store user input1 val
	LDR r5, =input1
	LDR r5, [r5]

	#user prompt2
	LDR r0, =prompt2
	BL printf

	#scan user input 2
	LDR r0, =formatInput2
	LDR r1, =input2
	BL scanf

	#store user input2
	LDR r0, =input2
	LDR r0, [r0]

	#move end/cont program to r1, r6
	MOV r1, r5
	MOV r6, r5

	#call function
	BL mul

	#output - occurences, sum
	MOV r2, r6
	MOV r9, r0

	#calc and output avg.
	#MOV r0, r1
	MOV r1, r6
	BL __aeabi_idiv
	MOV r3, r0
	MOV r2, r6
	MOV r1, r9

	LDR r0, =tempOutput
	BL printf

	#pop the stack
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
	#prompt1: .asciz "Enter -1 to end program, 1 to continue: "
	prompt1: .asciz "Enter occurences: "
	formatInput1: .asciz "%d"
	input1: .word 0
	prompt2: .asciz "Enter value: "
	formatInput2: .asciz "%d"
	input2: .word 0
	tempOutput: .asciz "The sum is %d, the number of occurences is %d, the avg. is %d\n"
	#output: .asciz "Num. values entered is %d, total is %d, avg. is %d\n"


#end main


.text
mul:
	#push the stack
	SUB sp, sp, #8
	STR lr, [sp]
	STR r4, [sp, #4]

	#val entered by user - r4, cont/end program - r5
	MOV r4, r0
	MOV r5, r1

	#if -1, end program, else continue
	CMP r5, #1
	BNE Else
		#equal to -1
		MOV r0, r4
		B Return
	Else:
		#not equal to -1
		SUB r1, r5, #1
		BL mul
		ADD r0, r4, r0
		B Return
	EndIf:

	#pop the stack
	Return:
	LDR lr, [sp]
	LDR r4, [sp, #4]
	ADD sp, sp, #8
	MOV pc, lr

.data


