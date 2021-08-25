.data
msg1:	.asciiz "Please input integer x: "
msg2:	.asciiz "Please input integer y: "
msg3:	.asciiz "The result is: "
msg4:	.asciiz "\n"

.text
.globl main
#------------------------- main -----------------------------
main:
# sum = 1
addi $t2, $zero, 1		# t2 (sum) = 1

# print msg1 on the console interface
		li      $v0, 4				# call system call: print string
		la      $a0, msg1			# load address of string into $a0
		syscall                 	# run the syscall
 
# read n
 		li      $v0, 5          	# call system call: read integer
  		syscall                 	# run the syscall
  		move    $a1, $v0      		# store n in $a1

# print msg2 on the console interface
		li      $v0, 4				# call system call: print string
		la      $a0, msg2			# load address of string into $a0
		syscall                 	# run the syscall
 
# read k
 		li      $v0, 5          	# call system call: read integer
  		syscall                 	# run the syscall
  		move    $a2, $v0      		# store k in $a2

# a1 -> a0, a2 -> a1
		move $a0, $a1
		move $a1, $a2

# call gcd
		jal gcd
		move $t8, $v0				#save return value in t8

# exit   
exit: 
# print msg3 on the console interface
		li      $v0, 4
		la      $a0, msg3
		syscall

# print integer t2
		li $v0, 1
    	move $a0, $t8
    	syscall

# print msg4 on the console interface
		li      $v0, 4
		la      $a0, msg4
		syscall

		li $v0, 10					# call system call: exit
  		syscall						# run the syscall


#------------------------- procedure gcd -----------------------------
# load argument a in a0, b in a1, return value in v0. 
.text
gcd:
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $a0, 4($sp)
		sw $a1, 0($sp)
		beq $a1, $zero, return_a	# jump is b == 0 (return a)
		div $a0, $a1				# a / b
		mfhi $a3					# remainder to $a3
		move $a0, $a1				# a = b
		move $a1, $a3				# b = a % b
		jal gcd
		lw $a1, 0($sp)
		lw $a0, 4($sp)
		lw $ra, 8($sp)
		addi $sp, $sp, 12
		jr $ra

return_a:
		addi $sp, $sp, 12			
		move $v0, $a0				# return value = a
		jr $ra