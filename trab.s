.data
	str_data_type: .asciiz "DataType:"
	str_operation: .asciiz "Operation:"
	str_end:       .asciiz "End of Program\n"
	str_inv_op:    .asciiz "\nOperacao invalida. Digite I, D ou F.\n"
	Valor1_int:    .word   00000000
	Valor2_int:    .word   00000000
	
.text
.globl main

main:
	# Imprime a string "DataType:"
	li $v0, 4
	la $a0, str_data_type
	syscall
	
	# Le o tipo de dado sobre o qual a operacao sera' realizada
	li $v0, 12
	syscall
	
	# Guarda o tipo de dado em $s0
	move $s0, $v0
	
	# # Checa se a operacao e' com inteiro
	# li $t1, 73  # $t1 = 'I'
	# li $t2, 105 # $t2 = 'i'
	# beq $s0, $t1, integer_op
	# beq $s0, $t2, integer_op

	# # Checa se a operacao e' com float
	# li  $t1, 70  # $t1 = 'F'
	# li  $t2, 102 # $t2 = 'f'
	# beq $s0, $t1, float_op
	# beq $s0, $t2, float_op
	
	# # Checa se a operacao e' com double
	# li  $t1, 68  # $t1 = 'D'
	# li  $t2, 100 # $t2 = 'd'
	# beq $s0, $t1, double_op
	# beq $s0, $t2, double_op
	
# Entrada invalida -> avisa o usuario e volta ao inicio
invalid_op:
	li $v0, 4
	la $a0, str_inv_op
	syscall

	j main

select_op:
	# Imprime a string "Operation:"
	li $v0, 4
	la $a0, str_operation
	syscall

	# Le qual operacao sera' realizada
	li $v0, 12
	syscall
	
	# Guarda operacao em $s1
	move $s1, $v0

	# Checa se e' soma ($t0 = '+')
	li  $t0, 43
	beq $s1, $t0, sum

	# Checa se e' subtracao ($t0 = '-')
	li  $t0, 45
	beq $s1, $t0, subtract

	# Checa se e' multiplicacao ($t0 = '*')
	li $t0, 42
	beq $s1, $t0, multiply

	# Checa se e' divisao ($t0 = '/')
	li $t0, 47
	beq $s1, $t0, divide

		
finish:
	# Imprime a string "End of Program"
	li $v0, 4
	la $a0, str_end
	syscall

	# Retorna ao sistema operacional
	li $v0, 10
	syscall
