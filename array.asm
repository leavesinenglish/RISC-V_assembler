.text
input:
	li a7, 5 
	ecall #a0 = amount of int
	mv s11, a0
	add a0, s11, s11 #array size
	add a0, a0, a0 #array size
	li t5, 0 #counter
	li a7, 9
	ecall
	mv ra, a0
		
fillarray:	
	li a7, 41
	ecall
	sw a0, (ra)
	addi t5, t5, 1
	beq t5, s11, endfilling 
	addi ra, ra, 4 #shift
	b fillarray
	
endfilling:
	addi t5, t5, -1
	mv	s0, ra
	
back_to_begining:
	addi ra, ra, -4
	addi t5, t5, -1
	beqz t5, sort
	b back_to_begining
	mv s1, ra
	
sort:
	beq	ra, s0, next
	lw a2, (ra)
	addi ra, ra, 4
	beq	ra, s0, next
	lw a3, (ra)
	
compare:
	
	ble a2, a3, sort #if a3 >= a2 do nothing
	bgt a2, a3, second_case     
		
second_case: #a3 < a2     
	sw a2, (ra)
	addi ra, ra, -4
	sw a3, (ra)
	
going_back:
	
	addi ra, ra, -4
	blt	ra, s1, next
	lw a2, (ra)
	addi ra, ra, 4
	b compare
	
next: 	
	addi ra, ra, -4
	addi t5, t5, 1
	mv s10, s11
	addi s10, s10, -1
	beq t5, s10, finish
	b next
	
finish:
	li a7, 1
	li t5, 0
	output:
		lw a0, (ra)
		addi ra, ra, 4
		ecall
		li a0, '\n'
		li a7, 11
		ecall
		addi t5, t5, 1
		beq t5, s11, end
		li a7, 1
		b output
	
end:	
	
	
