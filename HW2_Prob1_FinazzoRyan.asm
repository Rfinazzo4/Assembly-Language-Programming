# This code prompts the user for two strings and determines 
# whether the second is a substring of the first. If the 
# second is a substring of the first, it prints out the 
# location of the start of the second string in the 
# first string. If the second string is not a substring 
# of the first, the program will print out -1

.data

	str1: .asciiz "Enter first string : "
	str2: .asciiz "Enter the second string: "

	str1buffer: .space 50
	str2buffer: .space 50

.text 

# Prompt the user for the first string and store the string in $t0
	li $v0, 4
	la $a0, str1
	syscall			#prompt th user
	li $v0, 8
	la $a0, str1buffer 	#store the unput in $a0 
	li $a1, 50
	syscall
	move $t0, $a0		#move the string into $t0

# prompt the user for the second string and store the string in $t1
	li $v0, 4
	la $a0, str2
	syscall			#prompt th user
	li $v0, 8
	la $a0, str2buffer 	#store the unput in $a0 
	li $a1, 50
	syscall
	move $t1, $a0		#move the string into $t0

#increment counter for the strings
	li $t2, 0		#First 
	
# Traverse through the first string
loop:	
	lb $t4, 0($t0)
	lb $t5, 0($t1)
	beq $t4, $t5, movestrings	# Branch if the char stored in $t3(First) is equal to the start of $t4 (Second)
	beqz $t4, printne 	# print not equal if either string is over	
	add $t0, $t0, 1		# increment the address of $t0 (First)
	add $t2, $t2, 1		# increment the counter
	j loop			# jump back to loop 
	
movestrings: 
	move $t6, $t0	# move the strings into seperate register
	move $t7, $t1		# to hold the values in the same registers but compare in different
		
	j compare
		
compare:
	add $t6, $t6, 1		# increment the first string address
	add $t7, $t7, 1		# increment the second string address 
	lb $t4, 0($t6)		# load the next char of the first string 
	lb $t5, 0($t7)		# load the next char of the second string 
	beqz $t5, printi	# branch to print index if second string is equal to 0
	beq $t4, $t5, printi	# branch to print index if the next charachter of the second string is equal to first
	bne $t4, $t5, reset	# branch to reset if at least two charachets of the 
				# second string are not equal to the first
reset: 
	add $t0, $t0, 1		# increment the address of $t0 (First)
	add $t2, $t2, 1		#incremen the counter 
				
	j loop			# jump back to loop, and start the proccess over
	
printne: 
	li $a0, -1		#load -1 to print 
	li $v0, 1
	syscall			#print 
	
	j terminate 	
	
printi:	
	move $a0, $t2		# load the char to print into $a0 
	li $v0, 1
	syscall			# print 
	
	j terminate

terminate: 
	li $v0, 10 
	syscall 	#terminate the program
	
	
	
	
	
	
	
	
