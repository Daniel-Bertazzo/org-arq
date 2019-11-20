.data
		str_data_type: .asciiz "DataType:"
		str_operation: .asciiz "Operation:"
		Valor1_int:    .word   00000000
		Valor2_int     .word   00000000
		
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
			move $t0, $v0          # Guarda o tipo de dado em $t0
			
			# Checa se a operacao e' com float
			move $t1, 70           # $t1 = F
			move $t2, 102          # $t2 = f
			beq $t0, $t1, float_op
			beq $t0, $t2, float_op
			
			# Checa se a operacao e' com double
			move $t1, 68            # $t1 = D
			move $t2, 100           # $t2 = d
			beq $t0, $t1, double_op
			beq $t0, $t2, double_op
			
			# Se nao for nenhum dos dois acima, a operacao e' com inteiro
integer_op:
			
float_op:

double_op:
		
finish:
			li $v0, 10
			syscall