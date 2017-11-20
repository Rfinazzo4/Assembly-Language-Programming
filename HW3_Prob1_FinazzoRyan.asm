# Write a program that asks the user to input a string 
# (of no more than 50 characters). Your program should 
# then output the length of the string. The string 
# length should be determined using a separate function 
# strlen that will accept the address of the string and 
# return its length. For the purposes of this exercise, 
# the length of a string will be defined as the number 
# of non-null and non-newline characters until either 
# the null character (ASCII 0) or the newline character 
# (ASCII 10) is encountered.


.data 
prompt: .asciiz "Enter a string no more than 50 characters : "
endprompt: .asciiz "The length of the string you entered is : "
errorprompt: .asciiz "ERROR: The length of the string is too long"

buffer: .space 51 #space for 50 +null string

.text 

# prompt the user for a string
li $v0, 4
la $a0, prompt 
syscall

# take the users input
li $v0, 8
la $a0, buffer
li $a1, 51
syscall

# Intialize the increment counter
li $t1, 0

# $trlen Function 
move $t0, $a0	## Create local variable of $a0 address in $t0
jal strlen

# Print the end prompt
li $v0, 4
la $a0, endprompt
syscall

# Print the length of the string
move $a0, $t1	#move the value into a0 to print
li $v0, 1
syscall

#terminate the program
li $v0, 10
syscall

strlen:


# Load the char at respected byte in string
lb $t2, 0($t0)
beqz $t2, end 	#If the char is equal to Null  then branch to end
beq $t2, 10, end #If the char is equal to endline then branch to end

# Else continue
addi $t1, $t1, 1	#increment the counter
addi $t0, $t0, 1	#increment the address 

j strlen

end: 
# Return back to the link address (jal)
jr $31


