# Write a MIPS assembly language program that prompts the user to input 
# a string (of maximum length 50) and an integer index. The program 
# should then print out the substring of the input string starting 
# at the input index and ending at the end of the input string. For 
# example, with inputs “hello world” and 3, the output should be “lo world”.


.data
	strprompt: .asciiz "Enter a string up to 49 characters : "
	intprompt: .asciiz "Enter an integer : "

	buffer: .space 50

.text 

	#Prompt the user for string
	li $v0, 4
	la $a0, strprompt
	syscall
	
	#store the string
	li $v0, 8
	la $a0, buffer
	li $a1, 50
	syscall 
	
	move $t0, $a0 		#move string to $t0		
	
	
	#Promt the user for integer
	li $v0, 4
	la $a0, intprompt
	syscall
	
	#store the integer
	li $v0, 5
	syscall
	move $t1, $v0
	
	#set increment counter to zero
	li $t2, 0
	 
	
loop:
	lb $t3, 0($t0) 		#Load the byte (char) into temporary register
	beq $t2, $t1, print 	#If the counter is equal to the integer branch to printing
	add $t0, $t0, 1  	#increment the address 
	add $t2, $t2, 1 	#increment counter
	j loop 			#jump back to loop
	
print: 
	lb $t3, 0($t0) 		#Load the byte (char) into temporary register
	beqz $t3, terminate 	#Terminate if string is over
	
	# print out character at the address
	move $a0, $t3
	li $v0, 11
	syscall
	
	#continue the loop and increment
	add $t0, $t0, 1  	#increment the address 
	add $t1, $t1, 1 	#increment counter
	j print			#jump back to print

terminate:	

	li $v0, 10
	syscall
	