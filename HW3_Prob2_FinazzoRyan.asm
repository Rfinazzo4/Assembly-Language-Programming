# Write a program that defines two integer arrays 
# of the same size and then calls a function sum
#  that will populate a third array with the 
# element-wise sums of the two input arrays. For
# example, if array x is [1, 2, 3] and array y is
# [3, 4, 5], the sum should be the array [4, 6, 8].
# Your sum function should accept the addresses of
# the two input arrays, the address of the output
# array (which you will pre-allocate in the .data segment),
# and the length of the arrays. Your function may assume
# that the lengths of all three arrays are equal.
 
# Also, write a function print_array that prints out the 
#contents of an array. Its inputs should be the address
# of the input array and the length of the array. After
# computing the sum of two inputs, call the print_array
# function to print out the resulting sum array.


.data
	arr1: .word 1, 2, 3
	arr2: .word 3, 4, 5
	oparr: .word 0, 0, 0
	
	outputp: .asciiz "The sum of the two arrays  = "
	space: .asciiz " "
	
.text
	# Load the address into temp register
	la $t0, arr1	# address of array 1
	la $t1, arr2	# address of array 2
	la $t2, oparr	# Output array, will hold sum of both arrays
	
	# Intialize the size of the arrays into $t3
	li $t3, 3
	
	# Call sum function
	jal sum
	
	# Set up for print function
	addi $t3, $t3, 3	# Reset the array back to starting index
	jal printarray		# Call the Function printarray
	
	# Terminate the program
	li $v0, 10	
	syscall 
	
	
	sum:	# Add the sum of two arrays
		beqz $t3, end	# Branch to the end of the function 
		lb $t4, 0($t0)	# Load the byte of the first array into $t4
		lb $t5, 0($t1) 	# Load the byte of the second array into $t5
		add $t6, $t4, $t5 	# take the sum of two integers and store into $t6
		sb $t6, 0($t2) 	# Store the sum into the first index of the output array
		li $t6, 0	#reset t6
		
		# Decrement and increment
		addi $t0, $t0, 4	# Increment the first array 
		addi $t1, $t1, 4	# Increment the second array
		addi $t2, $t2, 4	# Increment the output arry
		subi $t3, $t3, 1	# Decrement the index counter 
		
		j sum 	# Jump back to the start of the function
		
		end:
		
		jr $ra 	# Return to original Jal
	

	printarray:	#print the array added together
		li $v0, 4	# print output prompt
		la $a0, outputp
		syscall

		decrement: 	# decremnt the index of the output array
			beq $t3, 0, print	#jump to print if array is reset
			subi $t2, $t2, 4	# decrement the output array 
			subi $t3, $t3, 1	# decrement the index counter 
			
			
			j decrement	# jump to decrement
		
		print:		
		# Branch 
			beq $t3, 3, endprint
		
		#print the array 
			li $v0, 1
			lb $t6, 0($t2)
			move $a0, $t6
			syscall
		
		# increment the output array and index counter
			addi $t2, $t2, 4
			addi $t3, $t3, 1	
		
		# load space to print
			li $v0, 4
			la $a0, space

			j print 	#jump to print
				
		endprint:
			jr $ra 			
						
							
									
	