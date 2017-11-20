#This Program prints the result of two integers with a specified operation that is imputed by the user


.data 
	num1prompt: .asciiz "Enter the first integer: "
	num2prompt: .asciiz "Enter the second integer: "
	op_prompt: .asciiz "Enter one of the 4 operations ( +,-,*,/ ) : "
	outputprompt: .asciiz "\nThe Answer is = "
	remainderprompt: .asciiz "\nWith a remainder of : "
	
	addition: .asciiz   "+"
	minus: .asciiz "-"
	multiply: .asciiz "*"
	divide: .asciiz "/"
	
	buffer: .space 9
	
.text 
	#prompt user for first integer
	li $v0, 4 
	la $a0, num1prompt
	syscall
	
	
	#Store the input
	li $v0, 5
	syscall
	move $t0, $v0
	
	#Prompt user for second integer
	li $v0, 4
	la $a0, num2prompt
	syscall
	
	#Store the input	
	li $v0, 5
	syscall 
	move $t1, $v0
	
	#Prompt the user for an operation
	li $v0, 4
	la $a0, op_prompt
	syscall
	
	#Store the input operation
	li $v0, 12
        syscall 
        move $t2, $v0
     
	#store specifiiers in temprorary registers
	la $t3, addition
	lb $t3, ($t3)
	la $t4, minus
	lbu $t4, ($t4)
	la $t5, multiply
	lbu $t5, ($t5)
	la $t6, divide
	lbu $t6, ($t6)
	
	#branch to specified operation
	
	beq $t2, $t3, additionb
	beq $t2, $t4, minusb
	beq $t2, $t5, multiplyb
	beq $t2, $t6, divideb
	
	#branch to terminate if input was invalid
	j terminate
	
additionb:
	#add the integers
	add $t0, $t0, $t1
	
	#print the output prompt
	li $v0, 4
	la $a0, outputprompt
	syscall
	
	#print the answer
	move $a0, $t0
	li $v0, 1
	syscall
	
	j terminate
	
	
minusb:
	#subtract the integers
	sub $t0, $t0, $t1
	
	#print the output prompt
	li $v0, 4
	la $a0, outputprompt
	syscall
	
	#print the answer
	move $a0, $t0
	li $v0, 1
	syscall
	
	j terminate
	
multiplyb:
	#multiply the integers
	mul  $t0, $t0, $t1
	
	#print the output prompt
	li $v0, 4
	la $a0, outputprompt
	syscall
	
	#print the answer
	move $a0, $t0
	li $v0, 1
	syscall
	
	j terminate
	
divideb:
	
	#print the output prompt
	li $v0, 4
	la $a0, outputprompt
	syscall
	#divide the integers
	div $t0, $t0, $t1
	mflo $a0
	mfhi $t7
	
	#print the answer
	move $a0, $t0
	li $v0, 1
	syscall
	
	#Print the remainder prompt
	li $v0, 4
	la $a0, remainderprompt
	syscall
	
	#Print remainder
	move $a0, $t7
	li $v0, 1
	syscall
	
	j terminate
	
terminate:
	#terminate the program
	li $v0, 10
	syscall
	
	