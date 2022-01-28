.text
main:
#ask the user for the sum
li $v0,4 
la $a0, Input
li $a1, 20
syscall

#store the user input
li $v0,8
la $a0, Sum
li $a1, 1024
syscall

#store the sum into t0
la $t0, Sum #Initialize the string
li $t1, 0 #initialize the count to 0
li $t2, 0 #Initialize the tot to 0
li $t4, 10 # store the constant 10 in $t4.

#t3 is the character pointed to by the string
lb $t3, ($t0)
#get first character

beq $t3, '-', negFirstNum

#if not a negative number, perform conversion:
bne $t3, '-', posFirstNum

posFirstNum:
addi $t3, $t3, -48
add $t2, $t2, $t3 #add the char to the total
j while

while:
lb $t3, ($t0) #load next byte into the space
beq $t3, '=', end_loop # if $t1 == =, branch out of loop.
beq $t3, '+', plus_num # if $t1 == +, branch out of loop.
beq $t3, '-', minus_num # if $t1 == -, branch out of loop.
addi $t0, $t0, 1
j while

plus_num:
addi $t0, $t0, 1 #increment counter
lb $t3, ($t0) #add the char to the address
addi $t3, $t3, -48 #convert to int
add $t2, $t2, $t3 #add the int to the total
addi $t0, $t0, 1 #increment counter
j while

minus_num:
addi $t0, $t0, 1 #increment counter
lb $t3, ($t0) #add the char to the address
addi $t3, $t3, -48 #convert to int
sub $t2, $t2, $t3 #subtract the int from the total
addi $t0, $t0, 1 #increment counter
j while

negFirstNum:
j minus_num

end_loop:
move $a0, $t2 # print out the answer (t2).
li $v0, 1
syscall

li $v0, 10 # load "exit" into $v0.
syscall # make the system call.

.data
Input: .asciiz "Enter a sum:\n"
Sum: .space 1024 # reserve 1024 bytes for the string.
