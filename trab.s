# $s0 = tipo de dado (i, f, d)
# $s1 = operacao (+, -, *, /, !)

.data
	str_new_line:  .asciiz "\n"
	str_data_type: .asciiz "DataType: "
	str_operation: .asciiz "Operation: "
	str_result:    .asciiz "Result: "
	str_end:       .asciiz "End of Program\n"
	str_repeat:    .asciiz "Repeat? Y = Yes, N = No: "
	str_inv_op:    .asciiz "\nOperacao invalida. Digite I, D ou F (maiusculo ou minusculo).\n"
	Valor1_int:    .word   00000000
	Valor2_int:    .word   00000000
	Valor1_float:  .float  00000000
	Valor2_float:  .float  00000000
	Result_int:    .word   00000000
	Result_float:  .float  00000000
	
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

	# Quebra de linha
	li $v0, 4
	la $a0, str_new_line
	syscall
	
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

	# Quebra de linha
	li $v0, 4
	la $a0, str_new_line
	syscall

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

	j repeat

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

	# Quebra de linha
	li $v0, 4
	la $a0, str_new_line
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

	# Quebra de linha
	li $v0, 4
	la $a0, str_new_line
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

# Le os floats do usuario
get_data_float:
	# Le o valor1
	li $v0, 6
	syscall
	# Armazena na memoria
	s.s $f0, Valor1_float

	# Le o valor2
	li $v0, 6
	syscall
	# Armazena na memoria
	s.s $f0, Valor2_float

# Checa qual operacao sera' realizada com os floats
check_op_float:
	# Checa se e' soma ($t0 = '+')
	li  $t0, 43
	beq $s1, $t0, float_sum

	# Checa se e' subtracao ($t0 = '-')
	li  $t0, 45
	beq $s1, $t0, float_subtract

	# Checa se e' multiplicacao ($t0 = '*')
	li  $t0, 42
	beq $s1, $t0, float_multiply

	# Checa se e' divisao ($t0 = '/')
	li  $t0, 47
	beq $s1, $t0, float_divide

	# Checa se e' divisao ($t0 = '!')
	li  $t0, 33
	beq $s1, $t0, float_invert

get_data_double:

check_op_double:

# Soma de inteiros
int_sum:
	lw  $t0, Valor1_int
	lw  $t1, Valor2_int
	add $t2, $t0, $t1
	sw  $t2, Result_int

	j print_result_int

# Soma de floats
float_sum:
	l.s   $f0, Valor1_float
	l.s   $f2, Valor2_float
	add.s $f4, $f0, $f2
	s.s   $f4, Result_float

	j print_result_float

double_sum:

# Subtracao de inteiros
int_subtract:
	lw  $t0, Valor1_int
	lw  $t1, Valor2_int
	sub $t2, $t0, $t1
	sw  $t2, Result_int

	j print_result_int

# Subtracao de floats
float_subtract:
	l.s   $f0, Valor1_float
	l.s   $f2, Valor2_float
	sub.s $f4, $f0, $f2
	s.s   $f4, Result_float

	j print_result_float


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
	sw   $t2, Result_int

	j print_result_int


# Multiplicacao de floats
float_multiply:
	l.s   $f0, Valor1_float
	l.s   $f2, Valor2_float
	mul.s $f4, $f0, $f2
	s.s   $f4, Result_float

	j print_result_float


double_mult:

# Divisao de inteiros
int_divide:
	lw   $t0, Valor1_int
	lw   $t1, Valor2_int
	div  $t0, $t1
	mflo $t2
	sw   $t2, Result_int

	j print_result_int

# Divisao de floats
float_divide:
	l.s   $f0, Valor1_float
	l.s   $f2, Valor2_float
	div.s $f4, $f0, $f2
	s.s   $f4, Result_float

	j print_result_float

double_divide:

# Inverte o sinal de inteiro
int_invert:
	lw  $t0, Valor1_int
	li  $t1, 0
	add $t1, $t0, $t0 # $t1 = 2 * valor1
	sub $t2, $t0, $t1 # $t2 = valor1 - 2*valor1 = -valor1
	sw  $t2, Result_int

	j print_result_int

float_invert:
	l.s   $f0, Valor1_float
	neg.s $f4, $f0
	s.s   $f4, Result_float	

	j print_result_float

# Imprime o inteiro resultante
print_result_int:
	lw $a0, Result_int
	li $v0, 1
	syscall

	j repeat

# Imprime o float resultante
print_result_float:
	l.s $f12, Result_float
	li  $v0, 2
	syscall

	j repeat


print_result_double:

# Checa se o usuario quer fazer outra operacao
repeat:
	# Imprime string "Repeat? Y = Yes, N = No"
	li $v0, 4
	la $a0, str_repeat
	syscall

	# Quebra de linha
	li $v0, 4
	la $a0, str_new_line
	syscall

	# Le a resposta e armazena em $s0
	li $v0, 12
	syscall
	move $s0, $v0

	# Checa se usuario escolheu continuar a execucao
	# Caso nao queira, apenas termina o programa
	li $t0, 89  # $t0 = Y
	li $t1, 121 # $t1 = y
	beq $s0, $t0, get_type
	beq $s0, $t1, get_type

finish:
	# Imprime a string "End of Program"
	li $v0, 4
	la $a0, str_end
	syscall

	# Retorna ao sistema operacional
	li $v0, 10
	syscall
