module Read_instructions (instrucao, PC, clk, estado);
    input wire [31:0] PC;
    input wire clk;
    input wire [3:0] estado;
    output reg [31:0] instrucao;
    // alterar confome a quantidade de linhas do arquivo
    reg [31:0] instrucoes [0:14]; // Memória de instruções

    // Lendo instruções
    // Especifique qual instrucoes.bin esta lendo
    initial begin
        $readmemb("../Inputs/instruction1.bin", instrucoes); // Lendo instruções em formato binário
        instrucao <= instrucoes[PC];
    end

    // Atualizando instrução a cada ciclo de clock
    always @(posedge clk) begin
        
        if(estado == 4'b0000)begin
            instrucao <= instrucoes[PC];
        end
    end

endmodule


