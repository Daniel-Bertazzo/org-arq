.data
	str_data_type: .asciiz "DataType:"
	str_operation: .asciiz "Operation:"
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
	move $t0, $v0 # Guarda o tipo de dado em $t0
	
	# Checa se a operacao e' com inteiro
	li $t1, 73  # $t1 = I
	li $t2, 105 # $t2 = i
	beq $t0, $t1, integer_op
	beq $t0, $t2, integer_op

	# Checa se a operacao e' com float
	li  $t1, 70  # $t1 = F
	li  $t2, 102 # $t2 = f
	beq $t0, $t1, float_op
	beq $t0, $t2, float_op
	
	# Checa se a operacao e' com double
	li  $t1, 68  # $t1 = D
	li  $t2, 100 # $t2 = d
	beq $t0, $t1, double_op
	beq $t0, $t2, double_op
	
# Entrada invalida -> avisa o usuario e volta ao inicio
invalid_op:
	li $v0, 4
	la $a0, str_inv_op
	syscall

	j main

# Selecionar operacao com inteiro
integer_op:
	# Imprime a string "Operation:"
	li $v0, 4
	la $a0, str_operation
	syscall

	# Le qual operacao sera' realizada
	li $v0, 12
	syscall
	move $t0, $v0 # Guarda operacao em $t0

	

float_op:

double_op:
		
finish:
	li $v0, 10
	syscall
