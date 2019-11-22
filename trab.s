# $s0 = tipo de dado (i, f, d)
# $s1 = operacao (+, -, *, /, !)

.data
	str_data_type: .asciiz "DataType:"
	str_operation: .asciiz "Operation:"
	str_end:       .asciiz "End of Program\n"
	str_inv_op:    .asciiz "\nOperacao invalida. Digite I, D ou F (maiusculo ou minusculo).\n"
	Valor1_int:    .word   00000000
	Valor2_int:    .word   00000000
	Result:        .word   00000000
	
.text
.globl main

main:
get_type:
	# Imprime a string "DataType:"
	li $v0, 4
	la $a0, str_data_type
	syscall

	# Le o tipo de dado sobre o qual a operacao sera' realizada
	li $v0, 12
	syscall
	# Guarda o tipo de dado em $s0
	move $s0, $v0
	
get_op:
	# Imprime a string "Operation:"
	li $v0, 4
	la $a0, str_operation
	syscall

	# Le qual operacao sera' realizada
	li $v0, 12
	syscall
	# Guarda operacao em $s1
	move $s1, $v0

	# Checa se a operacao e' com inteiro
	li  $t1, 73  # $t1 = 'I'
	li  $t2, 105 # $t2 = 'i'
	beq $s0, $t1, get_data_int
	beq $s0, $t2, get_data_int
	
	# Checa se a operacao e' com float
	li  $t1, 70  # $t1 = 'F'
	li  $t2, 102 # $t2 = 'f'
	beq $s0, $t1, get_data_float
	beq $s0, $t2, get_data_float
	
	# Checa se a operacao e' com double
	li  $t1, 68  # $t1 = 'D'
	li  $t2, 100 # $t2 = 'd'
	beq $s0, $t1, get_data_double
	beq $s0, $t2, get_data_double

# Entrada invalida -> avisa o usuario e encerra o programa
invalid_op:
	li $v0, 4
	la $a0, str_inv_op
	syscall

	j finish

# Le os valores inteiros do usuario
get_data_int:
	# Le o valor1
	li $v0, 5
	syscall
	# Armazena na memoria
	sw $v0, Valor1_int
	# Imprime o valor em hexadecimal
	lw $a0, Valor1_int
	li $v0, 34
	syscall

	# Le o valor2
	li $v0, 5
	syscall
	# Armazena na memoria
	sw $v0, Valor2_int
	# Imprime o valor em hexadecimal
	lw $a0, Valor2_int
	li $v0, 34
	syscall

# Checa qual operacao sera' realizada com os inteiros
check_op_int:
	# Checa se e' soma ($t0 = '+')
	li  $t0, 43
	beq $s1, $t0, integer_sum

	# Checa se e' subtracao ($t0 = '-')
	li  $t0, 45
	beq $s1, $t0, integer_sub

	# Checa se e' multiplicacao ($t0 = '*')
	li  $t0, 42
	beq $s1, $t0, integer_mult

	# Checa se e' divisao ($t0 = '/')
	li  $t0, 47
	beq $s1, $t0, integer_div

	# Checa se e' divisao ($t0 = '!')
	li  $t0, 33
	beq $s1, $t0, integer_invert


get_data_float:

get_data_double:
	# # Checa se e' soma ($t0 = '+')
	# li  $t0, 43
	# beq $s1, $t0, sum

	# # Checa se e' subtracao ($t0 = '-')
	# li  $t0, 45
	# beq $s1, $t0, subtract

	# # Checa se e' multiplicacao ($t0 = '*')
	# li $t0, 42
	# beq $s1, $t0, multiply

	# # Checa se e' divisao ($t0 = '/')
	# li $t0, 47
	# beq $s1, $t0, divide

# Checa qual o tipo de dado para somar
sum:
	# Checa se a operacao e' com inteiro
	li $t1, 73  # $t1 = 'I'
	li $t2, 105 # $t2 = 'i'
	beq $s0, $t1, integer_sum
	beq $s0, $t2, integer_sum
	
	# Checa se a operacao e' com float
	li  $t1, 70  # $t1 = 'F'
	li  $t2, 102 # $t2 = 'f'
	beq $s0, $t1, float_sum
	beq $s0, $t2, float_sum
	
	# Checa se a operacao e' com double
	li  $t1, 68  # $t1 = 'D'
	li  $t2, 100 # $t2 = 'd'
	beq $s0, $t1, double_sum
	beq $s0, $t2, double_sum

# Checa qual o tipo de dado para subtrair
subtract:
	# Checa se a operacao e' com inteiro
	li $t1, 73  # $t1 = 'I'
	li $t2, 105 # $t2 = 'i'
	beq $s0, $t1, integer_sum
	beq $s0, $t2, integer_sum
	
	# Checa se a operacao e' com float
	li  $t1, 70  # $t1 = 'F'
	li  $t2, 102 # $t2 = 'f'
	beq $s0, $t1, float_sum
	beq $s0, $t2, float_sum
	
	# Checa se a operacao e' com double
	li  $t1, 68  # $t1 = 'D'
	li  $t2, 100 # $t2 = 'd'
	beq $s0, $t1, double_sum
	beq $s0, $t2, double_sum

multiply:
divide:

# Soma com inteiros
integer_sum:
	# Le o valor1
	li $v0, 5
	syscall
	# Armazena na memoria
	sw $v0, Valor1_int
	# Imprime o valor em hexadecimal
	lw $a0, Valor1_int
	li $v0, 34
	syscall

	# Le o valor2
	li $v0, 5
	syscall
	# Armazena na memoria
	sw $v0, Valor2_int
	# Imprime o valor em hexadecimal
	lw $a0, Valor2_int
	li $v0, 34
	syscall
	
	# Realiza a soma
	lw  $t0, Valor1_int
	lw  $t1, Valor2_int
	add $t3, $t0, $t1
	sw  $t3, Result

float_sum:
double_sum:

integer_sub:


float_sub:
double_sub:

integer_mult:
float_mult:
double_mult:

integer_div:
float_div:
double_div:

finish:
	# Imprime a string "End of Program"
	li $v0, 4
	la $a0, str_end
	syscall

	# Retorna ao sistema operacional
	li $v0, 10
	syscall
