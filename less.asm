.text
 	li	x17, 5
  	ecall
 	mv  	x3, x10
  	ecall
 	mv	x4, x10
 	ecall
  	mv  	x5, x10
  	
	bge  	x3, x4, g1 #x3>=x4
  	b  	c2
  	  
g1:  	mv  	x3, x4

c2:  	bge  	x3, x5, g2 #x3>=x5
  	b  	end

g2:  	mv  	s3, x5
  
end:  	mv  	x10, x3
  	li  	x17, 1
  	ecall
	
	
	
	