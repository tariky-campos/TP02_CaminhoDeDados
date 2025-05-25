`include "../Modules/Read_instructions.v"
`include "../Modules/Decoding.v"
`include "../Modules/Control_signis.v"
`include "../Modules/SomaPC.v"
`include "../Modules/Registrars.v"
`include "../Modules/Alu.v"
`include "../Modules/Memory.v"

//lw sw sub xor addi srl beq

module main(clk, rst, reg0, reg1, reg2, reg3, reg4, reg5, 
reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, 
reg15, reg16, reg17, reg18, reg19, reg20, reg21, reg22, 
reg23, reg24, reg25, reg26, reg27, reg28, reg29, reg30, 
reg31, mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7, 
mem8, mem9, mem10, mem11, mem12, mem13, mem14, mem15, 
mem16, mem17, mem18, mem19, mem20, mem21, mem22, mem23, 
mem24, mem25, mem26, mem27, mem28, mem29, mem30, mem31);

    input wire clk, rst;

    //IF - para ler a instrução
    wire [31:0] instrucao;
    wire [6:0] opcode;
    wire [4:0] rd; // registrador de destino
    wire [4:0] rs1; // registrador de leitura 1
    wire [4:0] rs2; // registrador de leitura 2
    wire [2:0] funct3; 
    wire [6:0] funct7;
    wire [11:0] immediate;
    wire [2:0] tipo; // tipo da instrução
    wire [31:0] PC; // posição para ler a instrução
    wire negativo; // usado para quando o immediate é negativo
    //wire clk;

    //ID - para ler os registradores
    wire [31:0] readdata1R; //R para indicar que pertence ao banco de registradores
    wire [31:0] readdata2R; //R para indicar que pertence ao banco de registradores
    wire [31:0] writedataR; //R para indicar que pertence ao banco de registradores
    //registradores de x0 a x31
    output [31:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11;
    output [31:0] reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23; 
    output [31:0] reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31;

    //EX - para executar a instrução
    //resultado da alu
    wire aluresult1;
    wire [31:0] aluresult2;

    //MEM - para ler/escrever na memoria
    wire [31:0] reddataM; //M para indicar que pertence a memoria
    //campos da memoria
    output [31:0] mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8, mem9, mem10, mem11;
    output [31:0] mem12, mem13, mem14, mem15, mem16, mem17, mem18, mem19, mem20, mem21, mem22, mem23; 
    output [31:0] mem24, mem25, mem26, mem27, mem28, mem29, mem30, mem31;

    //sinais de controle
    wire regiwrite;
    wire [3:0] alucontrol;
    wire branch;
    wire memwrite;
    wire memread;
    wire pcsrc;
    wire memtoreg;
    wire alusrc;


    //parametros do estado
    parameter IF = 4'b0000, //posição instrução
              ID = 4'b0001, //leitura
              EX = 4'b0010, //execução
              AUX1 = 4'b0101, //auxiliar para atraso
              AUX2 = 4'b1111, //auxiliar para atraso
              MEM = 4'b0011, //leitura memoria
              WB = 4'b0100, //escrita
              AUX3 = 4'b0110, //auxiliar para atraso
              AUX4 = 4'b0111, //auxiliar para atraso
              SUMPC = 4'b1000, //soma pc
              FIM = 4'b1001; //finish


    // //maquina de estados
    reg [3:0] estado;

    // inciando a maquina de estados e exportando arquivo teste
    initial begin
         estado <= IF;
    end

    //calcular o endereço
    SomaPC SomaPC(.PC(PC), .clk(clk), .pcsrc(pcsrc), .immediate(immediate), .estado(estado), 
    .negativo(negativo));
    //leitura da instrução da instruction memory
    Read_instructions Read_instructions(.instrucao(instrucao), .PC(PC), .clk(clk), .estado(estado));
    //decodificação da instrução
    Decoding Decoding(.instrucao(instrucao), .opcode(opcode), .rd(rd), .rs1(rs1), .rs2(rs2), 
    .funct3(funct3), .funct7(funct7), .immediate(immediate), .tipo(tipo), .clk(clk), .estado(estado), 
    .negativo(negativo));
    //gerando os sinais de controle
    Control_signis Control_signis(.tipo(tipo), .regiwrite(regiwrite), .memwrite(memwrite), 
    .memread(memread), .alucontrol(alucontrol), .funct3(funct3), .clk(clk), .branch(branch), 
    .memtoreg(memtoreg), .alusrc(alusrc), .funct7(funct7), .estado(estado));
    //leitura e escrita dos registradores
    Registrars Registrars(.clk(clk), .rs1(rs1), .rs2(rs2), .rd(rd), .readdata1R(readdata1R), 
    .readdata2R(readdata2R), .regiwrite(regiwrite), .memtoreg(memtoreg), .writedataR(writedataR), 
    .reddataM(reddataM),.reg0(reg0), .reg1(reg1), .reg2(reg2), .reg3(reg3), .reg4(reg4), .reg5(reg5), 
    .reg6(reg6), .reg7(reg7), .reg8(reg8), .reg9(reg9), .reg10(reg10), .reg11(reg11),.reg12(reg12), 
    .reg13(reg13), .reg14(reg14), .reg15(reg15), .reg16(reg16), .reg17(reg17), .reg18(reg18), .reg19(reg19), 
    .reg20(reg20), .reg21(reg21), .reg22(reg22), .reg23(reg23), .reg24(reg24), .reg25(reg25), .reg26(reg26), 
    .reg27(reg27), .reg28(reg28), .reg29(reg29), .reg30(reg30), .reg31(reg31), .estado(estado));
    //execução da alu
    Alu Alu(.clk(clk), .readdata1R(readdata1R), .readdata2R(readdata2R), .alusrc(alusrc), 
    .alucontrol(alucontrol), .immediate(immediate), .aluresult1(aluresult1), .aluresult2(aluresult2), 
    .pcsrc(pcsrc), .branch(branch), .estado(estado), .negativo(negativo));
    //leitura e escrita da memoria
    Memory Memory(.clk(clk), .aluresult2(aluresult2), .readdata2R(readdata2R), .reddataM(reddataM), 
    .memwrite(memwrite), .memread(memread), .immediate(immediate), .mem0(mem0), .mem1(mem1), .mem2(mem2), 
    .mem3(mem3), .mem4(mem4), .mem5(mem5), .mem6(mem6), .mem7(mem7), .mem8(mem8), .mem9(mem9), .mem10(mem10), 
    .mem11(mem11),.mem12(mem12), .mem13(mem13), .mem14(mem14), .mem15(mem15), .mem16(mem16), .mem17(mem17), 
    .mem18(mem18), .mem19(mem19), .mem20(mem20), .mem21(mem21), .mem22(mem22), .mem23(mem23), .mem24(mem24), 
    .mem25(mem25), .mem26(mem26), .mem27(mem27), .mem28(mem28), .mem29(mem29), .mem30(mem30), .mem31(mem31), 
    .estado(estado), .writedataR(writedataR));

    //maquina de estados
    always @(posedge clk, posedge rst) begin
        // rst ativo acaba com a execução
        if(rst == 1'b1)begin
            estado <= IF;
        end 
        else begin
                case(estado)
            IF: begin
                estado <= ID;
            end
            ID: begin
                // se a instrução for 0, acaba a execução
                if(instrucao != 0)begin
                    estado <= EX;
                end
                else begin
                    estado <= FIM;
                end
            end
            EX: begin
                estado <= AUX1;
            end
            AUX1: begin
                estado <= AUX2;
            end
            AUX2: begin
                estado <= MEM;
            end
            MEM: begin
                estado <= WB;
            end
            WB: begin
                estado <= AUX3;
            end
            AUX3: begin
                estado <= AUX4;
            end
            AUX4: begin
                estado <= SUMPC;
            end
            SUMPC: begin
                estado <= IF;
            end
            FIM : begin
                if(rst == 1'b0) begin
                    estado <= IF;
                end
            end
            endcase
        end
    end


endmodule