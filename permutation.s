.data
msg1:	.asciiz "Please input integer n: "
msg2:	.asciiz "Please input integer k: "
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

# do for loop t0 = i, a1 = n, a2 = k
		add $t0, $zero, $zero		# i = 0
L1:
		slt $t1, $t0, $a2			# 1 if i < k (break when 0)
		beq $t1, $zero, exit
		sub $t3, $a1, $t0			# t3 = n-i
		mul $t2, $t2, $t3			# sum = sum * (n-i)
		addi $t0, $t0, 1
		j L1

# exit   
exit: 
# print msg3 on the console interface
		li      $v0, 4
		la      $a0, msg3
		syscall

# print integer t2
		li $v0, 1
    	move $a0, $t2
    	syscall

# print msg4 on the console interface
		li      $v0, 4
		la      $a0, msg4
		syscall

		li $v0, 10					# call system call: exit
  		syscall						# run the syscall
