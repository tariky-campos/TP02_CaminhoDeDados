module Alu (clk, readdata1R, readdata2R, alusrc, alucontrol, immediate, aluresult1, aluresult2, pcsrc, branch, estado, negativo);
    input wire clk; // clock
    input wire [3:0] estado; // estado atual da maquina de estados
    input [31:0] readdata1R; // registrador de leitura 1
    input [31:0] readdata2R; // registrador de leitura 2
    input alusrc; // sinal de controle para saber se a alu vai usar imediato ou não
    input [11:0] immediate; // imediato
    input branch; // sinal de controle para o desvio
    input [3:0] alucontrol; // sinal de controle para qual operação a alu vai fazer
    input negativo; // sinal de controle para saber se o imediato é negativo ou não
    output reg aluresult1; // sinal de controle de desvio
    output reg [31:0] aluresult2; // resultado da alu
    output pcsrc; // sinal de controle para o pc saber se vai ser incrementado com imeadiato ou não

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
                            aluresult2 <= readdata1R & readdata2R;
                            aluresult1 <= 1'b0;
                        end
                        4'b0001: begin // or
                            aluresult2 <= readdata1R | readdata2R;
                            aluresult1 <= 1'b0;
                        end
                        4'b0010: begin // soma
                            aluresult2 <= readdata1R + readdata2R;
                            aluresult1 <= 1'b0;
                        end
                        4'b0110: begin //subtração
                            aluresult2 <= readdata1R - readdata2R;
                            aluresult1 <= 1'b0;
                        end
                        4'b0100: begin // xor
                            aluresult2 <= readdata1R ^ readdata2R;
                            aluresult1 <= 1'b0;
                        end
                        4'b0101: begin // slr
                            aluresult2 <= readdata1R >>> readdata2R;
                            aluresult1 <= 1'b0;
                        end
                    endcase
                end
                1'b1: begin // operações para funções que usam imediato
                    case (alucontrol)
                        4'b0010: begin // soma lw e sw
                            if(negativo == 1'b1) begin
                                aluresult2 <= readdata1R - (immediate/4); // divindo por 4 pois a memoria é acessada de 1 em 1
                            end else begin
                                aluresult2 <= readdata1R + (immediate/4); // divindo por 4 pois a memoria é acessada de 1 em 1
                            end
                            aluresult1 <= 1'b0;
                            
                        end
                        4'b0011: begin // addi
                            if(negativo == 1'b1) begin
                                aluresult2 <= readdata1R - immediate; // subtraindo pois o imediato é negativo
                            end else begin
                                aluresult2 <= readdata1R + immediate; // somando pois o imediato é positivo
                            end
                            aluresult1 <= 1'b0;
                            
                        end
                        4'b0110: begin //subtração para beq
                            aluresult2 <= readdata1R - readdata2R; // comparando os registradores para ver se são iguais e fazer o desvio
                            if(aluresult2 == 0) begin
                                aluresult1 <= 1'b1;
                            end
                        end
                        4'b1111: begin // bne
                            if(readdata1R != readdata2R) begin // comparando os registradores para ver se são diferentes e fazer o desvio
                                aluresult1 <= 1'b1;
                            end 
                            else begin
                                aluresult1 <= 1'b0;
                            end
                        end
                    endcase
                end
            endcase
        end
    end
    
endmodule