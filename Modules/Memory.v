module Memory (clk, aluresult2, readdata2R, reddataM, memwrite, memread, immediate, mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8, mem9, mem10, mem11, mem12, mem13, mem14, mem15, mem16, mem17, mem18, mem19, mem20, mem21, mem22, mem23, mem24, mem25, mem26, mem27, mem28, mem29, mem30, mem31, estado, writedataR);
    input wire clk;
    input [3:0] estado;
    input [31:0] aluresult2; // resultado da alu
    input [31:0] readdata2R; // registrador de leitura 2
    input memwrite; // sinal de controle para saber se vai ser escrito na memoria
    input memread; // sinal de controle para saber se vai ser lido na memoria
    input [11:0] immediate;
    output reg [31:0] reddataM; // valor que vai ser lido da memoria e escrito no registrador
    output reg [31:0] writedataR; // valor que vai ser escrito no registrador
    output reg [31:0] mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8, mem9, mem10, mem11;
    output reg [31:0] mem12, mem13, mem14, mem15, mem16, mem17, mem18, mem19, mem20, mem21, mem22, mem23; 
    output reg [31:0] mem24, mem25, mem26, mem27, mem28, mem29, mem30, mem31;
    reg [31:0] memoria [0:31]; // memoria de 32 bits

    // leiura da memoria do arquivo memoria.bin
    initial begin
        $readmemb("../Inputs/memory.bin", memoria); // iniciando a memoria, lendo o arquivo memoria.bin
        // registradores pra visualização de cada posição da memoria
        mem0 <= memoria[0];
        mem1 <= memoria[1];
        mem2 <= memoria[2];
        mem3 <= memoria[3];
        mem4 <= memoria[4];
        mem5 <= memoria[5];
        mem6 <= memoria[6];
        mem7 <= memoria[7];
        mem8 <= memoria[8];
        mem9 <= memoria[9];
        mem10 <= memoria[10];
        mem11 <= memoria[11];
        mem12 <= memoria[12];
        mem13 <= memoria[13];
        mem14 <= memoria[14];
        mem15 <= memoria[15];
        mem16 <= memoria[16];
        mem17 <= memoria[17];
        mem18 <= memoria[18];
        mem19 <= memoria[19];
        mem20 <= memoria[20];
        mem21 <= memoria[21];
        mem22 <= memoria[22];
        mem23 <= memoria[23];
        mem24 <= memoria[24];
        mem25 <= memoria[25];
        mem26 <= memoria[26];
        mem27 <= memoria[27];
        mem28 <= memoria[28];
        mem29 <= memoria[29];
        mem30 <= memoria[30];
        mem31 <= memoria[31];
    end

    // atualizando a memoria a cada ciclo de clock
    always @(posedge clk) begin
        if((estado == 4'b0011) || (estado == 4'b0110 ) || (estado == 4'b0111)) begin
            // mux para saber se vai ser escrito ou lido na memoria 
            if(memwrite == 1'b1) begin
                memoria[aluresult2] <= readdata2R;
            end
            if(memread == 1'b1) begin
                reddataM <= memoria[aluresult2];
            end
            // atualizando o valor que vai ser escrito no registrador
            writedataR <= aluresult2;
            // atualizando os registradores pra visualização de cada posição da memoria
            mem0 <= memoria[0];
            mem1 <= memoria[1];
            mem2 <= memoria[2];
            mem3 <= memoria[3];
            mem4 <= memoria[4];
            mem5 <= memoria[5];
            mem6 <= memoria[6];
            mem7 <= memoria[7];
            mem8 <= memoria[8];
            mem9 <= memoria[9];
            mem10 <= memoria[10];
            mem11 <= memoria[11];
            mem12 <= memoria[12];
            mem13 <= memoria[13];
            mem14 <= memoria[14];
            mem15 <= memoria[15];
            mem16 <= memoria[16];
            mem17 <= memoria[17];
            mem18 <= memoria[18];
            mem19 <= memoria[19];
            mem20 <= memoria[20];
            mem21 <= memoria[21];
            mem22 <= memoria[22];
            mem23 <= memoria[23];
            mem24 <= memoria[24];
            mem25 <= memoria[25];
            mem26 <= memoria[26];
            mem27 <= memoria[27];
            mem28 <= memoria[28];
            mem29 <= memoria[29];
            mem30 <= memoria[30];
            mem31 <= memoria[31];
        end
    end
    
endmodule