.data
nums:	.word	69, 98, 73, 138, 5, 49, 5, 14, 5, 7  #signed
	.eqv	N	10

	
.align	2
nums_a:	.space	40

.text

	la	a0, nums #current address
	mv	t6, a0
	la	s11, nums_a
	mv	s8, s11 #на всякий случай, вдруг понадобится неиспорченное
	li	s9, N	# не портим
	li	a1, N	# это будем портить
	li	s4, N
	call	sort #на вход sort в a0 - адрес начала массива, в a1 - кол-во элементов в массиве
	
	li	a7, 10
	ecall
	
sort:
	addi	sp, sp, -32
	sw	ra, 0(sp)
	sw	s0, 4(sp)
	sw	s1, 8(sp)
	sw	s2, 12(sp)
	sw	s3, 16(sp)
	
	li	t0, 1
	beq	a1, t0, epilogue #если длина 1 - уже отсортировано
	
	srli	t0, a1, 1
	
	sub	s1, a1, t0 #s1 - сколько элементов во 2 половине
	slli	t1, t0, 2
	add	s0, a0, t1 #s0 - адрес начала 2 половины
	
	mv	a1, t0 # - кол-во элементов в 1 половине 
	call	sort
	mv	s2, a1	# - начало первой половины(?)
	
	mv	a0, s0
	mv	a1, s1
	call	sort
	mv	s3, a0 # - начало второй половины(?)
	
	b	merge
	
merge:
	beqz	s4, epilogue
	lw	a5, (s2) # - читаем по числу из каждой половины (тут падает)
	lw	a6, (s3)
	ble	a5, a6, lessoreq1	
	blt	a6, a5, less2
#теперь берем меньшее число и добавляем во временный массив nums_a, двигаемся по массивам
lessoreq1: 
	sw	a5, (s11)
	addi	s11, s11, 4
	addi	s2, s2, 4
	addi	s4, s4, -1
	b	merge

less2:	
	sw	a6, (s11)
	addi	s11, s11, 4
	addi	s3, s3, 4
	addi	s4, s4, -1
	b	merge

epilogue:
	mv	t0,zero
	#li	a6, 2
	#mul	t1, a6, s9
	#srl	s11, s11, t1
	mv	s11, s8 #теперь s11 - начало nums_a	
moving:		
	beq	t0, s9, printing
	lw	a1, (s11)
	addi	t0, t0, 1
	addi	s11, s11, 4
	sw	a1, (t6)
	addi	t6, t6, 4
	b	moving
	
printing:
	li x17, 1
	mul	t1, a6, s9
	sra	t6, t6, t1
	mv	t0, zero
	print:
		lw a0, (t6)
		addi t0, t0, 1
		li a7, 1
		ecall
		li a0, '\n'
		li a7, 11
		ecall
		beq t0, s9, ending
		b print
	
ending:	
	lw	s3, 16(sp)
	lw	s2, 12(sp)
	lw	s1, 8(sp)
	lw	s0, 4(sp)
	lw	ra, 0(sp)
	addi	sp, sp, 32
	ret			
