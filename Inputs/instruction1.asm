lb x1, 0(x2)       # Carrega byte da memória no endereço x2 + 0 para o registrador x1
ori x3, x1, 5      # x3 = x1 | 5
and x4, x3, x5     # x4 = x3 & x5
sll x6, x4, x7     # x6 = x4 << (x7 & 0x1F)
add x8, x6, x9     # x8 = x6 + x9
sb x8, 4(x2)       # Armazena o byte de x8 na memória no endereço x2 + 4
