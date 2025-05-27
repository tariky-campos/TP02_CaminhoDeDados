module Alu (clk, ler_dados1, ler_dados2, alusrc, alucontrol, imediato, aluresult1, aluresult2, pcsrc, branch, estado, negativo);
    input wire clk; // clock
    input wire [3:0] estado; // estado atual da maquina de estados
    input [31:0] ler_dados1; // registrador de leitura 1
    input [31:0] ler_dados2; // registrador de leitura 2
    input alusrc; // sinal de controle para saber se a alu vai usar imediato ou não
    input [11:0] imediato; // imediato
    input branch; // sinal de controle para o desvio
    input [3:0] alucontrol; // sinal de controle para qual operação a alu vai fazer
    input negativo; // sinal de controle para saber se o imediato é negativo ou não
    output reg aluresult1; // sinal de controle de desvio
    output reg [31:0] aluresult2; // resultado da alu
    output pcsrc; // sinal de controle para o pc saber se vai ser incrementado com imeadiato ou não
    reg [31:0] temp;
    assign pcsrc = aluresult1 & branch;

    always @(posedge clk) begin
        //estados em a alu é usada
        if ((estado == 4'b0101) || (estado == 4'b0110 )) begin // Estado de execução
            //alusrc define se a alu vai usar imediato ou não
            case (alusrc)
                1'b0: begin // operações para funções que não usam imediato
                    //alucontrol define a operação que a alu vai fazer
                    case (alucontrol)
                        4'b0000: begin // and
                            aluresult2 <= ler_dados1 & ler_dados2;
                            aluresult1 <= 1'b0;
                        end
                        4'b0001: begin // or
                            aluresult2 <= ler_dados1 | ler_dados2;
                            aluresult1 <= 1'b0;
                        end
                        4'b0010: begin // soma
                            aluresult2 <= ler_dados1 + ler_dados2;
                            aluresult1 <= 1'b0;
                        end
                        4'b0110: begin //subtração
                            aluresult2 <= ler_dados1 - ler_dados2;
                            aluresult1 <= 1'b0;
                        end
                        4'b0100: begin // xor
                            aluresult2 <= ler_dados1 ^ ler_dados2;
                            aluresult1 <= 1'b0;
                        end
                        4'b0101: begin // slr
                            aluresult2 <= ler_dados1 >>> ler_dados2;
                            aluresult1 <= 1'b0;
                        end
                        4'b1010: begin // sll (shift left logical)
                            aluresult2 <= ler_dados1 << ler_dados2;
                            aluresult1 <= 1'b0;
                        end

                    endcase
                end
                1'b1: begin // operações para funções que usam imediato
                    case (alucontrol)
                        4'b0010: begin // soma lw e sw
                            if(negativo == 1'b1) begin
                                aluresult2 <= ler_dados1 - (imediato/4); // divindo por 4 pois a memoria é acessada de 1 em 1
                            end else begin
                                aluresult2 <= ler_dados1 + (imediato/4); // divindo por 4 pois a memoria é acessada de 1 em 1
                            end
                            aluresult1 <= 1'b0;
                            
                        end
                        4'b0011: begin // addi
                            if(negativo == 1'b1) begin
                                aluresult2 <= ler_dados1 - imediato; // subtraindo pois o imediato é negativo
                            end else begin
                                aluresult2 <= ler_dados1 + imediato; // somando pois o imediato é positivo
                            end
                            aluresult1 <= 1'b0;
                            
                        end
                        4'b0110: begin //subtração para bne
                      
                            temp = ler_dados1 - ler_dados2;
                            aluresult2 <= temp;
                            aluresult1 <= (temp != 0) ? 1'b1 : 1'b0;
                            
                        end
                        4'b1001: begin //ori
                            aluresult2 <= ler_dados1 | imediato;
                            aluresult1 <= 1'b0;
                        end
                        4'b1010: begin // sll com imediato
                            aluresult2 <= ler_dados1 << imediato;
                            aluresult1 <= 1'b0;
                        end
                        4'b1100: begin // lb (load byte)
                            if (negativo == 1'b1) begin
                                aluresult2 <= ler_dados1 - imediato; // endereço = rs1 - offset
                            end else begin
                                aluresult2 <= ler_dados1 + imediato; // endereço = rs1 + offset
                            end
                            aluresult1 <= 1'b0;
                        end
                        4'b1111: begin // BEQ (branch se igual)
                            temp = ler_dados1 - ler_dados2;
                            aluresult2 <= temp;
                            aluresult1 <= (temp == 0) ? 1'b1 : 1'b0;
                        end

                    endcase
                end
            endcase
        end
    end
    
endmodule