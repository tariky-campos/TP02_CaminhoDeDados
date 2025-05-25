module Memory (clk, aluresult2, read_data2, read_dataM, memwrite, memread, immediate, mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7, 
        mem8, mem9, mem10, mem11, mem12, mem13, mem14, mem15, mem16, mem17, mem18, mem19, mem20, mem21, mem22, mem23, mem24, mem25,
            mem26, mem27, mem28, mem29, mem30, mem31, state, writedataR);
    input wire clk;
    input [3:0] state;
    input [31:0] aluresult2; // resultado da alu
    input [31:0] read_data2; // registrador de leitura 2
    input memwrite; // sinal de controle para saber se vai ser escrito na mmoria
    input memread; // sinal de controle para saber se vai ser lido na mmoria
    input [11:0] immediate;
    output reg [31:0] read_dataM; // valor que vai ser lido da mmoria e escrito no registrador
    output reg [31:0] writedataR; // valor que vai ser escrito no registrador
    output reg [31:0] mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8, mem9, mem10, mem11;
    output reg [31:0] mem12, mem13, mem14, mem15, mem16, mem17, mem18, mem19, mem20, mem21, mem22, mem23; 
    output reg [31:0] mem24, mem25, mem26, mem27, mem28, mem29, mem30, mem31;
    reg [31:0] memory [0:31]; // mmoria de 32 bits

    initial begin
        $readmemb("../Inputs/memory.bin", memory); 
        mem0 <= memory[0];
        mem1 <= memory[1];
        mem2 <= memory[2];
        mem3 <= memory[3];
        mem4 <= memory[4];
        mem5 <= memory[5];
        mem6 <= memory[6];
        mem7 <= memory[7];
        mem8 <= memory[8];
        mem9 <= memory[9];
        mem10 <= memory[10];
        mem11 <= memory[11];
        mem12 <= memory[12];
        mem13 <= memory[13];
        mem14 <= memory[14];
        mem15 <= memory[15];
        mem16 <= memory[16];
        mem17 <= memory[17];
        mem18 <= memory[18];
        mem19 <= memory[19];
        mem20 <= memory[20];
        mem21 <= memory[21];
        mem22 <= memory[22];
        mem23 <= memory[23];
        mem24 <= memory[24];
        mem25 <= memory[25];
        mem26 <= memory[26];
        mem27 <= memory[27];
        mem28 <= memory[28];
        mem29 <= memory[29];
        mem30 <= memory[30];
        mem31 <= memory[31];
    end

    // atualizando a memory a cada ciclo de clock
    always @(posedge clk) begin
        if((state == 4'b0011) || (state == 4'b0110 ) || (state == 4'b0111)) begin
            // mux para saber se vai ser escrito ou lido na memory 
            if(memwrite == 1'b1) begin
                memory[aluresult2] <= read_data2;
            end
            if(memread == 1'b1) begin
                read_dataM <= memory[aluresult2];
            end
            // atualizando o valor que vai ser escrito no registrador
            writedataR <= aluresult2;
            // atualizando os registradores pra visualização de cada posição da memory
            mem0 <= memory[0];
            mem1 <= memory[1];
            mem2 <= memory[2];
            mem3 <= memory[3];
            mem4 <= memory[4];
            mem5 <= memory[5];
            mem6 <= memory[6];
            mem7 <= memory[7];
            mem8 <= memory[8];
            mem9 <= memory[9];
            mem10 <= memory[10];
            mem11 <= memory[11];
            mem12 <= memory[12];
            mem13 <= memory[13];
            mem14 <= memory[14];
            mem15 <= memory[15];
            mem16 <= memory[16];
            mem17 <= memory[17];
            mem18 <= memory[18];
            mem19 <= memory[19];
            mem20 <= memory[20];
            mem21 <= memory[21];
            mem22 <= memory[22];
            mem23 <= memory[23];
            mem24 <= memory[24];
            mem25 <= memory[25];
            mem26 <= memory[26];
            mem27 <= memory[27];
            mem28 <= memory[28];
            mem29 <= memory[29];
            mem30 <= memory[30];
            mem31 <= memory[31];
        end
    end
    
endmodule