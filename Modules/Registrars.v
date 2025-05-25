module Registrars (clk, rs1, rs2, rd, read_data1, read_data2, regiwrite, memtoreg, writedataR, read_dataM, 
reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15, reg16, reg17, 
reg18, reg19, reg20, reg21, reg22, reg23, reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31, state);
    input wire clk;
    input [3:0] state;
    input [4:0] rs1;
    input [4:0] rs2;
    input [4:0] rd;
    input regiwrite;
    input memtoreg;
    input [31:0] writedataR;
    input [31:0] read_dataM;
    output [31:0] read_data1;
    output [31:0] read_data2;
    output reg [31:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11;
    output reg [31:0] reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23; 
    output reg [31:0] reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31;
    reg [31:0] bankregistrars [0:31];

    initial begin
        $readmemb("../Inputs/registrars.bin", bankregistrars); // Lendo registradores do arquivo registradores.bin
        // registradores para visualização de cada registrador 
        reg0 <= bankregistrars[0];
        reg1 <= bankregistrars[1];
        reg2 <= bankregistrars[2];
        reg3 <= bankregistrars[3];
        reg4 <= bankregistrars[4];
        reg5 <= bankregistrars[5];
        reg6 <= bankregistrars[6];
        reg7 <= bankregistrars[7];
        reg8 <= bankregistrars[8];
        reg9 <= bankregistrars[9];
        reg10 <= bankregistrars[10];
        reg11 <= bankregistrars[11];
        reg12 <= bankregistrars[12];
        reg13 <= bankregistrars[13];
        reg14 <= bankregistrars[14];
        reg15 <= bankregistrars[15];
        reg16 <= bankregistrars[16];
        reg17 <= bankregistrars[17];
        reg18 <= bankregistrars[18];
        reg19 <= bankregistrars[19];
        reg20 <= bankregistrars[20];
        reg21 <= bankregistrars[21];
        reg22 <= bankregistrars[22];
        reg23 <= bankregistrars[23];
        reg24 <= bankregistrars[24];
        reg25 <= bankregistrars[25];
        reg26 <= bankregistrars[26];
        reg27 <= bankregistrars[27];
        reg28 <= bankregistrars[28];
        reg29 <= bankregistrars[29];
        reg30 <= bankregistrars[30];
        reg31 <= bankregistrars[31];
    end

    // lendo os valores dos registradores usados na alu
    assign read_data1 = bankregistrars[rs1];
    assign read_data2 = bankregistrars[rs2];

    // escrevendo no registrador
    always @(posedge clk) begin
        // state onde o registrador é escrito
        if ((state == 4'b0110 ) || (state == 4'b0111)) begin // state de execução
            // regiwirte mostra se o registrador é escrito ou não
            case (regiwrite)
                1'b1: begin
                    // memtoreg mostra se o dado vem da memória ou da alu
                    case (memtoreg)
                        1'b1: begin
                            if(rd != 0) begin
                                bankregistrars[rd] <= read_dataM;
                            end          
                        end
                        1'b0: begin
                            if(rd != 0) begin
                                bankregistrars[rd] <= writedataR;
                            end
                        end
                    endcase
                end 
            endcase
            // atualizando os registradores para visualização
            reg0 <= bankregistrars[0];
            reg1 <= bankregistrars[1];
            reg2 <= bankregistrars[2];
            reg3 <= bankregistrars[3];
            reg4 <= bankregistrars[4];
            reg5 <= bankregistrars[5];
            reg6 <= bankregistrars[6];
            reg7 <= bankregistrars[7];
            reg8 <= bankregistrars[8];
            reg9 <= bankregistrars[9];
            reg10 <= bankregistrars[10];
            reg11 <= bankregistrars[11];
            reg12 <= bankregistrars[12];
            reg13 <= bankregistrars[13];
            reg14 <= bankregistrars[14];
            reg15 <= bankregistrars[15];
            reg16 <= bankregistrars[16];
            reg17 <= bankregistrars[17];
            reg18 <= bankregistrars[18];
            reg19 <= bankregistrars[19];
            reg20 <= bankregistrars[20];
            reg21 <= bankregistrars[21];
            reg22 <= bankregistrars[22];
            reg23 <= bankregistrars[23];
            reg24 <= bankregistrars[24];
            reg25 <= bankregistrars[25];
            reg26 <= bankregistrars[26];
            reg27 <= bankregistrars[27];
            reg28 <= bankregistrars[28];
            reg29 <= bankregistrars[29];
            reg30 <= bankregistrars[30];
            reg31 <= bankregistrars[31];
        end
    end
    
endmodule