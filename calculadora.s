.data
	str_new_line:  .asciiz "\n"
	str_space:     .asciiz " "
	str_open_par:  .asciiz "("
	str_close_par: .asciiz ")"
	str_data_type: .asciiz "DataType: "
	str_operation: .asciiz "Operation: "
	str_overflow:  .asciiz "Overflow\n"
	str_v1:        .asciiz "Insira o valor 1: "
	str_v2:        .asciiz "Insira o valor 2: "
	str_result:    .asciiz "Result: "
	str_end:       .asciiz "End of Program\n"
	str_repeat:    .asciiz "Repeat? Y = Yes, N = No: "
	str_inv_op:    .asciiz "\nOperacao invalida. Digite I, D ou F (maiusculo ou minusculo).\n"

	Valor1_int:    .word   00000000
	Valor2_int:    .word   00000000

	Valor1_float:  .float  00000000
	Valor2_float:  .float  00000000

	Valor1_double: .double 0000000000000000
	Valor2_double: .double 0000000000000000

	Result_int:    .word   00000000
	Result_float:  .float  00000000
	Result_double: .double 0000000000000000
	
.text
.globl main

main:
get_type:
	# Imprime a string "DataType: "
	li $v0, 4
	la $a0, str_data_type
	syscall

	# Le o tipo de dado sobre o qual a operacao sera' realizada
	li $v0, 12
	syscall
	# Guarda o tipo de dado em $s0
	move $s0, $v0

	# Quebra de linha
	la $a0, str_new_line
	li $v0, 4
	syscall
	
get_op:
	# Imprime a string "Operation: "
	li $v0, 4
	la $a0, str_operation
	syscall

	# Le qual operacao sera' realizada
	li $v0, 12
	syscall
	# Guarda operacao em $s1
	move $s1, $v0

	# Quebra de linha
	la $a0, str_new_line
	li $v0, 4
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

# Operacao invalida -> avisa o usuario e reinicia o programa
invalid_op:
	li $v0, 4
	la $a0, str_inv_op
	syscall

	j repeat

# Le os valores inteiros do usuario
get_data_int:
	# Imprime string "Insira o valor 1: "
	la $a0, str_v1
	li $v0, 4
	syscall
		
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
	la $a0, str_new_line
	li $v0, 4
	syscall

	# Imprime string "Insira o valor 2: "
	la $a0, str_v2
	li $v0, 4
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
	la $a0, str_new_line
	li $v0, 4
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

	# Checa se e' para inverter o sinal ($t0 = '!')
	li  $t0, 33
	beq $s1, $t0, int_invert

# Le os floats do usuario
get_data_float:
	# Imprime string "Insira o valor 1: "
	la $a0, str_v1
	li $v0, 4
	syscall
	
	# Le o valor1
	li $v0, 6
	syscall
	# Armazena na memoria
	s.s $f0, Valor1_float
	# Imprime em hexadecimal
	mfc1 $a0, $f0
	li   $v0, 34
	syscall

	# Quebra de linha
	la $a0, str_new_line
	li $v0, 4
	syscall

	# Imprime string "Insira o valor 2: "
	la $a0, str_v2
	li $v0, 4
	syscall
	
	# Le o valor2
	li $v0, 6
	syscall
	# Armazena na memoria
	s.s $f0, Valor2_float
	# Imprime em hexadecimal	
	mfc1 $a0, $f0
	li $v0, 34
	syscall

	# Quebra de linha
	la $a0, str_new_line
	li $v0, 4
	syscall

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

	# Checa se e' para inverter o sinal ($t0 = '!')
	li  $t0, 33
	beq $s1, $t0, float_invert

# Le os doubles do usuario
get_data_double:
	# Imprime string "Insira o valor 1: "
	la $a0, str_v1
	li $v0, 4
	syscall

	# Le o valor1
	li $v0, 7
	syscall
	# Armazena na memoria
	s.d $f0, Valor1_double
	# Imprime em hexadecimal (primeira parte do double)
	mfc1 $a0, $f0
	li   $v0, 34
	syscall
	# Espaco entre as duas partes
	li $v0, 4
	la $a0, str_space
	syscall
	# Imprime em hexadecimal (segunda parte do double)
	mfc1 $a0, $f1
	li   $v0, 34
	syscall

	# Quebra de linha
	la $a0, str_new_line
	li $v0, 4
	syscall

	# Imprime string "Insira o valor 2: "
	la $a0, str_v2
	li $v0, 4
	syscall

	# Le o valor2
	li $v0, 7
	syscall
	# Armazena na memoria
	s.d $f0, Valor2_double
	# Imprime em hexadecimal (primeira parte do double)
	mfc1 $a0, $f0
	li   $v0, 34
	syscall
	# Espaco entre as duas partes
	li $v0, 4
	la $a0, str_space
	syscall
	# Imprime em hexadecimal (segunda parte do double)
	mfc1 $a0, $f1
	li   $v0, 34
	syscall

	# Quebra de linha
	la $a0, str_new_line
	li $v0, 4
	syscall

# Checa qual operacao sera' realizada com os doubles
check_op_double:
	# Checa se e' soma ($t0 = '+')
	li  $t0, 43
	beq $s1, $t0, double_sum

	# Checa se e' subtracao ($t0 = '-')
	li  $t0, 45
	beq $s1, $t0, double_subtract

	# Checa se e' multiplicacao ($t0 = '*')
	li  $t0, 42
	beq $s1, $t0, double_multiply

	# Checa se e' divisao ($t0 = '/')
	li  $t0, 47
	beq $s1, $t0, double_divide

	# Checa se e' para inverter o sinal ($t0 = '!')
	li  $t0, 33
	beq $s1, $t0, double_invert


#  .....:: OPERACOES COM INTEIROS ::.....  #

# Soma de inteiros
int_sum:
	lw   $t0, Valor1_int
	lw   $t1, Valor2_int
	addu $t2, $t0, $t1

	# Checa overflow
	xor  $t3, $t0, $t2
	xor  $t4, $t1, $t2
	and  $t3, $t3, $t4
	bltz $t3, overflow

	# Guarda o resultado
	sw  $t2, Result_int

	j print_result_int

# Subtracao de inteiros
int_subtract:
	lw  $t0, Valor1_int
	lw  $t1, Valor2_int
	sub $t2, $t0, $t1

	# Checa overflow
	xor  $t3, $t0, $t2
	xor  $t4, $t1, $t2
	and  $t3, $t3, $t4
	bltz $t3, overflow

	# Guarda o resultado
	sw  $t2, Result_int
	
	j print_result_int

# Multiplicacao de inteiros
int_multiply:
	lw   $t0, Valor1_int
	lw   $t1, Valor2_int
	mult $t0, $t1
	mflo $t2

	# Checa overflow
	xor  $t3, $t0, $t2
	xor  $t4, $t1, $t2
	and  $t3, $t3, $t4
	bltz $t3, overflow

	# Guarda o resultado
	sw   $t2, Result_int

	j print_result_int

# Divisao de inteiros
int_divide:
	lw   $t0, Valor1_int
	lw   $t1, Valor2_int
	div  $t0, $t1
	mflo $t2

	# Checa overflow
	xor  $t3, $t0, $t2
	xor  $t4, $t1, $t2
	and  $t3, $t3, $t4
	bltz $t3, overflow

	# Guarda o resultado
	sw   $t2, Result_int

	j print_result_int

# Inverte o sinal de inteiro
int_invert:
	lw  $t0, Valor1_int
	li  $t1, 0
	add $t1, $t0, $t0 # $t1 = 2 * valor1
	sub $t2, $t0, $t1 # $t2 = valor1 - 2*valor1 = -valor1

	# Guarda o resultado
	sw  $t2, Result_int

	j print_result_int


#  .....:: OPERACOES COM FLOATS ::.....  #

# Soma de floats
float_sum:
	l.s   $f0, Valor1_float
	l.s   $f2, Valor2_float
	add.s $f4, $f0, $f2

	# Checa overflow
	mfc1 $t0, $f4
	li   $t1, 2139095040 # $t1 = inf
	beq  $t0, $t1, overflow

	# Guarda o resultado
	s.s $f4, Result_float
	
	j print_result_float

# Subtracao de floats
float_subtract:
	l.s   $f0, Valor1_float
	l.s   $f2, Valor2_float
	sub.s $f4, $f0, $f2
	
	# Checa overflow
	mfc1 $t0, $f4
	li   $t1, 2139095040 # $t1 = inf
	beq  $t0, $t1, overflow
	
	# Guarda o resultado
	s.s $f4, Result_float

	j print_result_float

# Multiplicacao de floats
float_multiply:
	l.s   $f0, Valor1_float
	l.s   $f2, Valor2_float
	mul.s $f4, $f0, $f2
	
	# Checa overflow
	mfc1 $t0, $f4
	li   $t1, 2139095040 # $t1 = inf
	beq  $t0, $t1, overflow

	# Guarda o resultado
	s.s $f4, Result_float

	j print_result_float

# Divisao de floats
float_divide:
	l.s   $f0, Valor1_float
	l.s   $f2, Valor2_float
	div.s $f4, $f0, $f2
	
	# Checa overflow
	mfc1 $t0, $f4
	li   $t1, 2139095040 # $t1 = inf
	beq  $t0, $t1, overflow

	# Guarda o resultado
	s.s   $f4, Result_float

	j print_result_float

# Inverte o sinal de float
float_invert:
	l.s   $f0, Valor1_float
	neg.s $f4, $f0

	# Guarda o resultado
	s.s   $f4, Result_float	

	j print_result_float


#  .....:: OPERACOES COM DOUBLES ::.....  #

# Soma de doubles
double_sum:
	l.d   $f0, Valor1_double
	l.d   $f2, Valor2_double
	add.d $f4, $f0, $f2

	# Checa overflow
	mfc1 $t0, $f4
	li   $t1, 2139095040 # $t1 = inf
	beq  $t0, $t1, overflow

	# Guarda o resultado
	s.d   $f4, Result_double

	j print_result_double

# Subtracao de doubles
double_subtract:
	l.d   $f0, Valor1_double
	l.d   $f2, Valor2_double
	sub.d $f4, $f0, $f2
	
	# Checa overflow
	mfc1 $t0, $f4
	li   $t1, 2139095040 # $t1 = inf
	beq  $t0, $t1, overflow

	# Guarda o resultado
	s.d   $f4, Result_double

	j print_result_double

# Multiplicacao de doubles
double_multiply:
	l.d   $f0, Valor1_double
	l.d   $f2, Valor2_double
	mul.d $f4, $f0, $f2
	
	# Checa overflow
	mfc1 $t0, $f4
	li   $t1, 2139095040 # $t1 = inf
	beq  $t0, $t1, overflow

	# Guarda o resultado
	s.d   $f4, Result_double

	j print_result_double

# Divisao de doubles
double_divide:
	l.d   $f0, Valor1_double
	l.d   $f2, Valor2_double
	div.d $f4, $f0, $f2
	
	# Checa overflow
	mfc1 $t0, $f4
	li   $t1, 2139095040 # $t1 = inf
	beq  $t0, $t1, overflow

	# Guarda o resultado
	s.d   $f4, Result_double

	j print_result_double

# Inverte o sinal de double
double_invert:
	l.d   $f0, Valor1_double
	neg.d $f4, $f0

	# Guarda o resultado
	s.d   $f4, Result_double	

	j print_result_double

# Imprime o inteiro resultante
print_result_int:
	# Imprime String "Result: "
	la $a0, str_result
	li $v0, 4
	syscall

	# Imprime em hexadecimal
	lw $a0, Result_int
	li $v0, 34
	syscall

	# Espaco
	la $a0, str_space
	li $v0, 4
	syscall

	# Imprime em decimal tambem
	la $a0, str_open_par
	li $v0, 4
	syscall
	lw $a0, Result_int
	li $v0, 1
	syscall
	la $a0, str_close_par
	li $v0, 4
	syscall

	# Quebra de linha
	la $a0, str_new_line
	li $v0, 4
	syscall

	j repeat

# Imprime o float resultante
print_result_float:
	# Imprime String "Result: "
	la $a0, str_result
	li $v0, 4
	syscall
	
	# Imprime em hexadecimal
	l.s  $f0, Result_float
	mfc1 $a0, $f0
	li   $v0, 34
	syscall

	# Espaco
	la $a0, str_space
	li $v0, 4
	syscall

	# Imprime em decimal tambem
	la $a0, str_open_par
	li $v0, 4
	syscall
	l.s $f12, Result_float
	li $v0, 2
	syscall
	la $a0, str_close_par
	li $v0, 4
	syscall

	# Quebra de linha
	la $a0, str_new_line
	li $v0, 4
	syscall

	j repeat

# Imprime o double resultante
print_result_double:
	# Imprime String "Result: "
	la $a0, str_result
	li $v0, 4
	syscall
	
	# Imprime a primeira parte em hexadecimal
	l.d  $f0, Result_double
	mfc1 $a0, $f0
	li   $v0, 34
	syscall
	# Espaco em branco
	li $v0, 4
	la $a0, str_space
	syscall
	# Imprime a segunda parte em hexadecimal
	mfc1 $a0, $f1
	li   $v0, 34
	syscall

	# Espaco
	la $a0, str_space
	li $v0, 4
	syscall

	# Imprime em decimal tambem
	la $a0, str_open_par
	li $v0, 4
	syscall
	l.d $f12, Result_double
	li $v0, 3
	syscall
	la $a0, str_close_par
	li $v0, 4
	syscall

	# Quebra de linha
	la $a0, str_new_line
	li $v0, 4
	syscall

	j repeat

# Imprime a string "Overflow" e reinicia o programa
overflow:
	la $a0, str_overflow
	li $v0, 4
	syscall
	j repeat

# Checa se o usuario quer fazer outra operacao
repeat:
	# Imprime string "Repeat? Y = Yes, N = No"
	li $v0, 4
	la $a0, str_repeat
	syscall

	# Quebra de linha
	la $a0, str_new_line
	li $v0, 4
	syscall

	# Le a resposta e armazena em $s0
	li $v0, 12
	syscall
	move $s0, $v0

	# Quebra de linha
	la $a0, str_new_line
	li $v0, 4
	syscall

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