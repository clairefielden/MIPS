.text
main:
li $v0, 4
#Display first message

la $a0, Input
syscall

li $v0, 8

#take in first variable
la $a0, One
li $a1, 10
syscall

#take in second variable
la $a0, Two
li $a1, 10
syscall

#take in third variable

la $a0, Three
li $a1, 10
syscall

#output

li $v0, 4
la $a0, Output
syscall

li $v0,4
la $a0, Three
syscall

li $v0,4 
la $a0, One
syscall

li $v0,4 
la $a0, Two
syscall

li $v0,10
syscall

.data
Input: .asciiz "Enter a list of 3 lines:\n"
Output: .asciiz "The reordered list is:\n"
One: .space 10
Two: .space 10
Three: .space 10
NewLine: .asciiz "\n"
