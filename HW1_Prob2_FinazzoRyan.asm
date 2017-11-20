#This program calulates and prints the average of 3 numbers.

.data

num1prompt: .asciiz "Enter the first number: "
num2prompt: .asciiz "Enter the second number: "
num3prompt: .asciiz "Enter the thrid number: "
printprompt: .asciiz "The average of the 3 numbers is = "
remainderprompt: .asciiz "\nRemainder: "
three: .word 3

.text 
#prompt the user for the first integer
li $v0, 4
la $a0, num1prompt
syscall

#store the first integer in $t0
li $v0, 5
syscall
move $t0, $v0

#prompt the user fo the second integer
li $v0, 4
la $a0, num2prompt
syscall

#store the second integer in $t1
li $v0, 5
syscall
move $t1, $v0

#add the first two integers together
add $t0, $t0, $t1

#prompt user for the third integer
li $v0, 4
la $a0, num3prompt
syscall

#store the third integer in $t1 
li $v0, 5
syscall
move $t1, $v0

#add last integer to the sum of the first two integers
add $t0, $t0, $t1

#Print
li $v0, 4
la $a0, printprompt
syscall

#load 3 into a register for division
lw $t1, three

#Divide the intergers by 3 to get the average
div $t0, $t1
mflo $a0 
mfhi $a1

#print out average of the 3
li $v0, 1
syscall

#Print remainder Prompt
li $v0, 4
la $a0, remainderprompt
syscall

#move remainder into printable register
move $a0, $a1

#print remainder
li $v0, 1
syscall

#Terminate program
li $v0, 10
syscall 


