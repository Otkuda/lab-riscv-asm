.data
N:
  .word 6
M:
  .word 3
matrix:
  .word 1, -2, -3, -4, -5, -6
  .word 1, -2, -3, -4, -5, -6
  .word 1, -2, -3, -4, -5, -6
result:
  .word 0

.text

.globl _start

_start:
  call main

  addi a0, x0, 10
  ecall

main:
  addi sp, sp, -16 # Сохраняем место в стеке с выравниванием 16 бит
  sw ra, 12(sp)    # Сохраняем значение регистра ra - адреса возврата,
                   # так как main вызывает другие функции
  lw a0, N
  lw a1, M
  la a2, matrix
  la a3, result    # Загрузка аргументов в соответствующие регистры
  call sum_pos     # sum_pos( N, M, *matrix, *result)

  lw a1, result
  call print_int

  lw ra, 12(sp)   # Возвращаем сохраненный адрес возврата
  addi sp, sp, 16 # освобождаем место на стеке
  ret

print_int:
  addi a0, x0, 1
  ecall
  ret

sum_pos:
  addi t1, x0, 0 # Очищаем регистр t1, так как в нем могут быть неактуальные данные
  mv t2, a0      # Копируем значение a0 в t2 (инициализация счетчика цикла)
  cycle_0:
    lw t0, 0(a2)   # Получаем значение по адресу a2 в регистр t0 (первый элемент в матрице)
    addi a2, a2, 4 # a2 += 4 (Сместили указатель на следующий элемент матрицы)
    blt t0, x0, loop_check_row # Проверка знака элемента 
    add t1, t1, t0 # Если элемент положительный, то прибавляем его к результату
  loop_check_row:
    addi t2, t2, -1     # }
    bgt t2, x0, cycle_0 # } for (t2 = a0; t2 > 0; t2--) cycle_0
  loop_check_col:
    addi a1, a1, -1     # }
    ble a1, x0, fun_end # } for (a1 = M; a1 > 0; a1--)
    mv t2, a0           # Восстановление значения t2 = N
    j cycle_0           # Возврат в начало цикла
  fun_end:
    sw t1, 0(a3)        # *result = t1
    ret
    



  
