.text
	li	x17, 5
	ecall
	mv	x4, x10
	#x10 - ���-�� 1 �����
loop:	beqz	x4, result
	andi	x9, x4, 1
	beqz 	x9, zzero
	addi	x5, x5, 1 
	
zzero:	srli	x4, x4, 1
	b	loop
	
result:	li	x17, 1
	mv	x10, x5
	ecall