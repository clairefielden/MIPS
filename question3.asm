.text
main:
#ask the user for the sum
li $v0,4 
la $a0, Input
li $a1, 20
syscall

#store the user input
li $v0,8
la $a0, l1
li $a1, 20
syscall

move $t1, $a0
#store line 1

la $a0, l2
syscall
move $t2, $a0
#store line 2

la $a0,l3
syscall
move $t3, $a0
#store line 3

#store the rotations into t0
li $v0,5
syscall
move $t0, $v0

setChars:
lb $s0, 2($t1) #load the third byte of line 1 into s0
lb $s1, 2($t2) #load the third byte of line 2 into s1
lb $s2, 2($t3) #load the third byte of line 3 into s2

lb $s3, 1($t1) #load the second byte of line 1 into s3
lb $s4, 1($t2) #load the second byte of line 2 into s4
lb $s5, 1($t3) #load the second byte of line 3 into s5

lb $s6, 0($t1) #load the first byte of line 1 into s6
lb $s7, 0($t2) #load the first byte of line 2 into s7
lb $t8, 0($t3) #load the first byte of line 3 into t8

bgt $t0,0,clockwise #if the rotations are positive, perform clockwise roation
beqz $t0, do_nothing
mul $t0, $t0, -1 #if the rotations is negative, multipl by -1 and jump there
j anticlockwise #if the rotations are negative, perform anticlockwise rotation

clockwise:
beq $t0, 0, end #if the count is less than the rotations, end
#now all the individual chars have been stored
# now you set each word to nothing
#now you add the char individually
#when repeated, the current chars will be refound

la $t1, array1
la $t2, array2
la $t3, array3

sb $s0, 2($t3) #byte3 from line 3
sb $s1, 1($t3) #byte2 from line 3
sb $s2, 0($t3) #byte1 from line 3

sb $s3, 2($t2) #byte3 from line 2
sb $s4, 1($t2) #byte2 from line 2
sb $s5, 0($t2) #byte1 from line 2

sb $s6, 2($t1) #byte3 from line 1
sb $s7, 1($t1) #byte2 from line 1
sb $t8, 0($t1) #byte1 from line 1

subu $t0,$t0,1 #decrement the counter
j setChars

anticlockwise:
beq $t0, 0, end

la $t1, array1
la $t2, array2
la $t3, array3

#now we reorder
#t5 = line 1

sb $s0, 0($t1)
sb $s1, 1($t1)
sb $s2, 2($t1)

sb $s3, 0($t2)
sb $s4, 1($t2)
sb $s5, 2($t2)

sb $s6, 0($t3)
sb $s7, 1($t3)
sb $t8, 2($t3)

mul $t0, $t0, -1 #make the roations negative again otherwise will follow the clockwise path after
addu $t0,$t0,1 #increment the counter
j setChars

do_nothing:

la $t1, array1
sb $s6, 0($t1)
sb $s3, 1($t1)
sb $s0, 2($t1)

la $t2, array2
sb $s7, 0($t2)
sb $s4, 1($t2)
sb $s1, 2($t2)

la $t3, array3
sb $t8, 0($t3)
sb $s5, 1($t3)
sb $s2, 2($t3)

j end

end:
move $a0, $t1 # print out line1
li $v0, 4
syscall

la $a0, newLine # print out new line
li $v0, 4
syscall

move $a0, $t2 # print out line2
li $v0, 4
syscall

la $a0, newLine # print out new line
li $v0, 4
syscall

move $a0, $t3 # print out line3
li $v0, 4
syscall

li $v0, 10 # load "exit" into $v0.
syscall # make the system call.

.data
Input: .asciiz "Enter a 3x3 matrix:\n"
l1: .space 20 # reserve bytes for line1
l2: .space 20 # reserve bytes for line1
l3: .space 20 # reserve bytes for line1
array1: .space 4
array2: .space 4
array3: .space 4
newLine: .asciiz "\n"
