module Alu (clk, read_data1, read_data2, alusrc, alucontrol, immediate, aluresult1, aluresult2, pcsrc, branch, state, negative);
    input wire clk;
    input wire [3:0] state;
    input alusrc;
    input negative;
    input branch;
    input [3:0] alucontrol;
    input [11:0] immediate;
    input [31:0] read_data1;
    input [31:0] read_data2;
    output reg [31:0] aluresult2;
    output reg aluresult1;
    output pcsrc;

    assign pcsrc = aluresult1 & branch;

    always @(posedge clk) begin
        
        if ((state == 4'b0101) || (state == 4'b0110)) begin // Estado de execução
             case(alusrc)
                1'b0: begin
                    case(alucontrol)
                        4'b0000: begin
                            aluresult1 <= read_data1 & read_data2;
                            aluresult1 <= 1'b0;
                        end
                        4'b0001: begin // or
                            aluresult2 <= read_data1 | read_data2;
                            aluresult1 <= 1'b0;
                        end
                        4'b0010: begin // soma
                            aluresult2 <= read_data1 + read_data2;
                            aluresult1 <= 1'b0;
                        end
                        4'b0110: begin //subtração
                            aluresult2 <= read_data1 - read_data2;
                            aluresult1 <= 1'b0;
                        end
                        4'b0100: begin // xor
                            aluresult2 <= read_data1 ^ read_data2;
                            aluresult1 <= 1'b0;
                        end
                        4'b0101: begin // slr
                            aluresult2 <= read_data1 >>> read_data2;
                            aluresult1 <= 1'b0;
                        end
                    endcase
                end
                1'b1: begin // operações para funções que usam imediato
                    case (alucontrol)
                        4'b0010: begin // soma lw e sw
                            if(negative == 1'b1) begin
                                aluresult2 <= read_data1 - (immediate/4); // divindo por 4 pois a memoria é acessada de 1 em 1
                            end else begin
                                aluresult2 <= read_data1 + (immediate/4); // divindo por 4 pois a memoria é acessada de 1 em 1
                            end
                            aluresult1 <= 1'b0;
                            
                        end
                        4'b0011: begin // addi
                            if(negative == 1'b1) begin
                                aluresult2 <= read_data1 - immediate; // subtraindo pois o imediato é negative
                            end else begin
                                aluresult2 <= read_data1 + immediate; // somando pois o imediato é positivo
                            end
                            aluresult1 <= 1'b0;
                            
                        end
                        4'b0110: begin //subtração para beq
                            aluresult2 <= read_data1 - read_data2; 
                            if(aluresult2 == 0) begin
                                aluresult1 <= 1'b1;
                            end
                        end
                        4'b1111: begin // bne
                            if(read_data1 != read_data2) begin 
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