.text
li x17, 5
ecall
mv x5, x10
ecall


#х5 - то, что мы суммируем
#х10 - то, сколько раз суммируем
#х4 - то, на сколько сдвигаем х5
#х1 - тут лежит результат умножения
bltz	x10, secondisnegative

loop:	beqz	x10,result
	andi	x9, x10, 1
	beqz 	x9, savezero
	b	if1
		savezero: addi 	x4, x4, 1
			  srai x10,x10,1
			  b loop

if1:	beqz x4, first1
	sll x11, x5, x4 #промежуточный рез-т
	add x1, x1, x11
	srai x10, x10,1
	addi x4, x4, 1
	b loop

first1: add x1, x1, x5
	srai x10, x10,1
	addi x4, x4, 1
	b loop

secondisnegative: neg x5, x5
		  neg x10,x10
		  b loop

result:	mv x10, x1
	li x17, 1
	ecall