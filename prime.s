.data
msg1:	.asciiz "Please input a number: "
msg2:	.asciiz "It's a prime\n"
msg3:	.asciiz "It's not a prime\n"

.text
.globl main
#------------------------- main -----------------------------
main:
# print msg1 on the console interface
		li      $v0, 4				# call system call: print string
		la      $a0, msg1			# load address of string into $a0
		syscall                 	# run the syscall
 
# read the input integer in $v0
 		li      $v0, 5          	# call system call: read integer
  		syscall                 	# run the syscall
  		move    $a0, $v0      		# store input in $a0 (set arugument of procedure prime)

# jump to procedure prime
  		jal prime
		move $t0, $v0				# save return value in t0 (because v0 will be used by system call) 

# print msg2 on the console interface if it's a prime

		li      $v0, 4				# call system call: print string
		beq $t0, $zero, print_not_prime # jump when 0 (not_prime)

print_prime:
		la      $a0, msg2			# load address of string into $a0
		j run_syscall

print_not_prime:
		la 		$a0, msg3

run_syscall: 
		syscall                 	# run the syscall


# exit   
exit: 
		li $v0, 10					# call system call: exit
  		syscall						# run the syscall

#------------------------- procedure prime -----------------------------
# $a0 = n, $t0 = i
.text
prime:	addi $t0, $zero, 1
		bne $a0, $t0, L1			# jump to L1 if n != 1
		j exit0

L1:
		addi $t0, $zero, 2			# i = 2 when n != 1
L2:		
		mul $t1, $t0, $t0			# t1 = i * i
		slt $t2, $a0, $t1			# test if n < i * i. if so (1), jump
		bne $t2, $zero, exit1		# set => jump. zero => no jump

		div $a0, $t0				# n / i, 
		mfhi $t1					# remainder to $t1
		beq $t1, $zero, exit0		# if n%i == 0, jump to exit

		addi $t0, $t0, 1			# i++

		j L2

exit1:
		addi $v0, $zero, 1			# let return value = 1
		jr $ra

exit0:
		add $v0, $zero, $zero		# let return value = 0
		jr $ra