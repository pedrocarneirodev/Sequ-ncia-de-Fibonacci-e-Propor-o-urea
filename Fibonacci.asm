.data
    fib30:      .word 30
    fib40:      .word 40
    fib41:      .word 41

.text   
.globl main

main:
    lw $t0, fib30
    lw $t1, fib40
    lw $t2, fib41

    # Calcular o 30 termo
    move $a0, $t0
    jal fibonacci
    move $s1, $v0

    # Calcular o 40 termo
    move $a0, $t1
    jal fibonacci
    move $s2, $v0

    # Calcular o 41 termo
    move $a0, $t2
    jal fibonacci
    move $s3, $v0

    # Carregar os valores de $s2 e $s3 em registradores de ponto flutuante
    mtc1 $s2, $f12      
    mtc1 $s3, $f14      
    cvt.s.w $f12, $f12  
    cvt.s.w $f14, $f14  
    div.s $f0, $f12, $f14

    li $v0, 10
    syscall

fibonacci:
    li $v0, 0
    beqz $a0, fim_fibonacci
    li $v0, 1
    beq $a0, 1, fim_fibonacci

    li $t3, 0
    li $t4, 1 
    li $t5, 2

fib_loop:
    bge $t5, $a0, fim_fibonacci_loop

    add $t6, $t3, $t4  
    move $t3, $t4     
    move $t4, $t6     
    addi $t5, $t5, 1

    j fib_loop

fim_fibonacci_loop:
    move $v0, $t4

fim_fibonacci:
    jr $ra
