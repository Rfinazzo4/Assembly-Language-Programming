# Write a MIPS assembly language program that asks the
# user to input an integer and then prints out a string 
# that shows how that integer should be encoded using 16 bits. 
# Your program should handle both positive and negative valued 
# inputs. Your program should also print out an error message  
# if the given input cannot be expressed as a 16 bit signed integer.
 
# As an example, if the input is 12, your program should 
# output “0000000000001100”. If the input is 34000, your program 
# should print out an error since the largest 16 bit signed 
# integer is 215 - 1 = 32767.


.data

startprompt: .asciiz "Enter an integer to be converted into 16 bit binary : "
endprompt: .asciiz "The integer in 16 bit binary is : "
errorprompt: .asciiz "Invalid input, integer is either too high or too low."

array: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 

.text

	# Prompt the user for an integer
	li $v0, 4
	la $a0, startprompt 
	syscall

	# store the input into $t0
	li $v0, 5
	syscall
	move $t0, $v0

	# branch to error if the input is invalid
	bgt $t0, 32767, error
	blt $t0, -32768, error
	
	# Load index's into registers
	li $t1, 0 		#first index of the array
	li $t2, 15		# last index of the array
	
	# Load the address of the array and initalize the index
	la $a0, array
	
	# branch to different loop depending on its value( + , - )
	bge $t0, 0, positive 	#branch to positive loop for breakdown if greater than or equal to 0
	blt $t0, 0, pneg	# branch to negative identifier 
	
	
positive: 
	# divide the integer by 2
	div $t3, $t0, 2		# store in a temp register
	mfhi $t4		# store the remainder in $t4
	move $t0, $t3		# move new divided value into $t0
	
	# move the remainder value into the index of $a0
	sb $t4, 0($a0)
	
	# Check for the end of the array
	beq $t1, $t2, print
	
	# increment
	addi $a0, $a0, 1	#increment the address of the array
	addi $t1, $t1, 1	#incrmenent the starting index 
	
	j positive
	
pneg: 
	# print a (1) to indetify it is a negative
	li $a0, 1		# Load 1
	li $v0, 1
	syscall			# print 1
	
	# Reset $a0 address to array
	la $a0, array
	
	#convert to positive number
	sub $t0, $zero, $t0	# By subtracting a negative from zero, double negative makes a positive
	
	# Set new index for $t2
	li $t2, 14		# To fix the off by on error (Or else it would 17 bits lol)
	
	# Jump to negative
	j negative
	
negative: 
	# divide the integer by 2
	div $t3, $t0, 2		# store in a temp register
	mfhi $t4		# store the remainder in $t4
	move $t0, $t3		# move new divided value into $t0
	
	# move the remainder value into the index of $a0
	sb $t4, 0($a0)
	
	# Check for the end of the array
	beq $t1, $t2, print
	
	# increment
	addi $a0, $a0, 1	#increment the address of the array
	addi $t1, $t1, 1	#incrmenent the starting index 
	
	j negative
	
print: 
	# Print out the integer in 16 bit binary
	lb $t5, 0($a0)		# load byte store at the index 
	move $a0, $t5		# load the byte to print
	li $v0, 1		#print
	syscall
	
	# Reset the address and add the index back 
	la $a0, array
	add $a0, $a0, $t1
	
	# Check for the end of the array
	beqz $t1, terminate
	
	#Increment backwards
	subi $a0, $a0, 1	#increment the address of the array
	subi $t1, $t1, 1	#incrmenent the starting index 
	
	j print

error:
	# Print the error prompt
	li $v0, 4
	la $a0, errorprompt
	syscall
	
	j terminate		# Jump to terminate
	
terminate: 
	# terminate the program
	li $v0, 10
	syscall
	






