# $s0 = tipo de dado (i, f, d)
# $s1 = operacao (+, -, *, /, !)

.data
	str_data_type: .asciiz "DataType:"
	str_operation: .asciiz "Operation:"
	str_result:    .asciiz "Result:"
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
	beq $s1, $t0, int_sum

	# Checa se e' subtracao ($t0 = '-')
	li  $t0, 45
	beq $s1, $t0, int_subtract

	# Checa se e' multiplicacao ($t0 = '*')
	li  $t0, 42
	beq $s1, $t0, int_multiply

	# Checa se e' divisao ($t0 = '/')
	li  $t0, 47
	beq $s1, $t0, int_divide

	# Checa se e' divisao ($t0 = '!')
	li  $t0, 33
	beq $s1, $t0, int_invert


get_data_float:

get_data_double:

# Soma de inteiros
int_sum:
	lw  $t0, Valor1_int
	lw  $t1, Valor2_int
	add $t2, $t0, $t1
	sw  $t2, Result

float_sum:
double_sum:

# Subtracao de inteiros
int_subtract:
	lw  $t0, Valor1_int
	lw  $t1, Valor2_int
	sub $t2, $t0, $t1
	sw  $t2, Result

float_sub:
double_sub:

# Multiplicacao de inteiros
int_multiply:
	lw   $t0, Valor1_int
	lw   $t1, Valor2_int
	mult $t0, $t1
	# ******************************************************************************
	# CHECAR OVERFLOW AQUI (mfhi)
	# ******************************************************************************
	mflo $t2
	sw   $t2, Result

float_mult:
double_mult:

# Divisao de inteiros
int_divide:
	lw   $t0, Valor1_int
	lw   $t1, Valor2_int
	div  $t0, $t1
	mflo $t2
	sw   $t2, Result


float_div:
double_div:

# Inverte o sinal de inteiro
int_invert:
	lw  $t0, Valor1_int
	li  $t1, 0
	add $t1, $t0, $t0 # $t1 = 2 * valor1
	sub $t2, $t0, $t1 # $t2 = valor1 - 2*valor1 = -valor1
	sw  $t2, Result

finish:
	# Imprime a string "End of Program"
	li $v0, 4
	la $a0, str_end
	syscall

	# Retorna ao sistema operacional
	li $v0, 10
	syscall
