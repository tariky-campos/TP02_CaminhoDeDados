addi x1, x0, 100  # x1 = 100 (endereço da memória)
lb   x2, 0(x1)    # x2 = memória[x1 + 0] (carrega o byte do endereço 100 para x2)
