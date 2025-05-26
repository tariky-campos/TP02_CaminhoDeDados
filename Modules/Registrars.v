module Registrars (clk, rs1, rs2, rd, ler_dados1, ler_dados2, regiwrite, memtoreg, writedataR, reddataM, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23, reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31, estado);
    input wire clk;
    input [3:0] estado;
    input [4:0] rs1;
    input [4:0] rs2;
    input [4:0] rd;
    input regiwrite;
    input memtoreg;
    input [31:0] writedataR;
    input [31:0] reddataM;
    output [31:0] ler_dados1;
    output [31:0] ler_dados2;
    output reg [31:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11;
    output reg [31:0] reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23; 
    output reg [31:0] reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31;
    reg [31:0] bancoregistradores [0:31];

    // lendo os valores dos registradores no arquivo registradores.bin
    initial begin
        $readmemb("../Inputs/registrars.bin", bancoregistradores); // Lendo registradores do arquivo registradores.bin
        // registradores para visualização de cada registrador 
        reg0 <= bancoregistradores[0];
        reg1 <= bancoregistradores[1];
        reg2 <= bancoregistradores[2];
        reg3 <= bancoregistradores[3];
        reg4 <= bancoregistradores[4];
        reg5 <= bancoregistradores[5];
        reg6 <= bancoregistradores[6];
        reg7 <= bancoregistradores[7];
        reg8 <= bancoregistradores[8];
        reg9 <= bancoregistradores[9];
        reg10 <= bancoregistradores[10];
        reg11 <= bancoregistradores[11];
        reg12 <= bancoregistradores[12];
        reg13 <= bancoregistradores[13];
        reg14 <= bancoregistradores[14];
        reg15 <= bancoregistradores[15];
        reg16 <= bancoregistradores[16];
        reg17 <= bancoregistradores[17];
        reg18 <= bancoregistradores[18];
        reg19 <= bancoregistradores[19];
        reg20 <= bancoregistradores[20];
        reg21 <= bancoregistradores[21];
        reg22 <= bancoregistradores[22];
        reg23 <= bancoregistradores[23];
        reg24 <= bancoregistradores[24];
        reg25 <= bancoregistradores[25];
        reg26 <= bancoregistradores[26];
        reg27 <= bancoregistradores[27];
        reg28 <= bancoregistradores[28];
        reg29 <= bancoregistradores[29];
        reg30 <= bancoregistradores[30];
        reg31 <= bancoregistradores[31];
    end

    // lendo os valores dos registradores usados na alu
    assign ler_dados1 = bancoregistradores[rs1];
    assign ler_dados2 = bancoregistradores[rs2];

    // escrevendo no registrador
    always @(posedge clk) begin

        // estado onde o registrador é escrito
        if ((estado == 4'b0110 ) || (estado == 4'b0111)) begin // Estado de execução
            // regiwirte mostra se o registrador é escrito ou não
            case (regiwrite)
                1'b1: begin
                    // memtoreg mostra se o dado vem da memória ou da alu
                    case (memtoreg)
                        1'b1: begin
                            if(rd != 0) begin
                                bancoregistradores[rd] <= reddataM;
                            end          
                        end
                        1'b0: begin
                            if(rd != 0) begin
                                bancoregistradores[rd] <= writedataR;
                            end
                        end
                    endcase
                end 
            endcase
            // atualizando os registradores para visualização
            reg0 <= bancoregistradores[0];
            reg1 <= bancoregistradores[1];
            reg2 <= bancoregistradores[2];
            reg3 <= bancoregistradores[3];
            reg4 <= bancoregistradores[4];
            reg5 <= bancoregistradores[5];
            reg6 <= bancoregistradores[6];
            reg7 <= bancoregistradores[7];
            reg8 <= bancoregistradores[8];
            reg9 <= bancoregistradores[9];
            reg10 <= bancoregistradores[10];
            reg11 <= bancoregistradores[11];
            reg12 <= bancoregistradores[12];
            reg13 <= bancoregistradores[13];
            reg14 <= bancoregistradores[14];
            reg15 <= bancoregistradores[15];
            reg16 <= bancoregistradores[16];
            reg17 <= bancoregistradores[17];
            reg18 <= bancoregistradores[18];
            reg19 <= bancoregistradores[19];
            reg20 <= bancoregistradores[20];
            reg21 <= bancoregistradores[21];
            reg22 <= bancoregistradores[22];
            reg23 <= bancoregistradores[23];
            reg24 <= bancoregistradores[24];
            reg25 <= bancoregistradores[25];
            reg26 <= bancoregistradores[26];
            reg27 <= bancoregistradores[27];
            reg28 <= bancoregistradores[28];
            reg29 <= bancoregistradores[29];
            reg30 <= bancoregistradores[30];
            reg31 <= bancoregistradores[31];
        end
    end
    
endmodule