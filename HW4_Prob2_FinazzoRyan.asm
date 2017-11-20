

.data

prompt: .asciiz "Enter a non negative integer array"
array: .space 11


.text
# Print out prompt
la $a0, prompt
li $v0, 4
syscall

# Invoke read_int

la $a0, array
li $a1, 11
addi $sp, $sp, -12
sw $a0, 0($sp)
sw $a1, 4($sp)
sw $ra, 8($sp)
jal read_int
lw $ra, 8($sp)
lw $a0, 0($sp)
addi $sp, $sp, 12

li $v0, 10
syscall

read_int:
lw $a0, 0($sp)		# a0 holds char array address
lw $a1, 4($sp)		# a1 holds array size

li $a2, 0xffff0000	#Load base address of keyboard 
li $t7, 0		# Set loop counter to 0
# start main loop
main:
#read a single character
not_ready:
      lw $t1, 0($a2)	# read keyboard status
      andi $t1, $t1, 1  # extract ready bit
      beqz $t1, not_ready    # if not ready, iterate again
lw $t0, 4($a2)       	# once ready, extract character
beq $t0, 10, done    	# exit loop on "enter" key
blt $t0, 48, error	# check to see if Ascii code is less than 48
bge  $t0, 58, error	# check to see if Ascii code is greater than 58
beq $t0, 0, done	# branch to done if null terminator
sw $t0, 0($a0)		# add character to array
addi $a0, $a0, 4	# increment the adress
addi $a1, $a1, -1	# increment array index
addi $t7, $t7, 1	# Incrment loop counter
beqz $a1, done		# Branch if integer is over 10 digits

j main
   
error: 
lw $t3, 8($a2)
	andi $t3, $t3, 1
	beqz $t3, incout
	# print
li $t7, -1	# load -1 to print
sw $t7, 12($a2)	

li $v0, 10	#Terminate 
syscall

done:
	incloop:		#incrmeent loop
	beq $a1, 10, incout	# jump out of incrmenet loop if equal to 10(size of array)
	addi $a1, $a1, 1	# increment
	add $a0, $a0, -4	# decement
	j incloop
	
	incout:
	lw $t3, 8($a2)
	andi $t3, $t3, 1
	beqz $t3, incout
	
	sw $a0, 12($a2)
	addi $a0, $a0, 4	# Increment address
	addi $t7, $t7, -1 	# decrement loop counter
	beqz $t7, return
	j incout
	
return:	
	jr $ra	#jump back

