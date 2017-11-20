# Write a function print_line that mimics system call 4. The only input parameter 
# to this function should be the memory address of the start of a null terminated 
# character array (appropriately stored on the stack). The function should utilize 
# MMIO to print out the characters in the array one by one. Once the null terminator
# is reached, print out a newline character.

.data
prompt: .asciiz "This is the string to print"

.text


main:

la $a0, prompt				#Load the address into $a0

# invokoe the print_line
addi $sp, $sp, -8
sw $a0, 0($sp)
sw $ra, 4($sp)
jal print_line
lw $ra, 4($sp)
lw $a0, 0($sp)
addi $sp, $sp, 8

#Terminate
li $v0, 10
syscall 

# System call 4 Function
print_line:
	# Read input param from stack
	lw $a0, 0($sp)	# $a0 holds the address of the string
	li $t0, 0xffff0000			# Starting 
	control_check:
		lw $t1, 8($t0) 		# Control ready bit
		andi $t1, $t1, 1
		beqz $t1, control_check
	lb $t2, ($a0)	
	beq $t2, 10, return
	beqz $t2, return
	sb $t2, 12($t0)			# Transmit Data
	addi $a0, $a0, 1
	b control_check
		
return:
jr $ra		
		




