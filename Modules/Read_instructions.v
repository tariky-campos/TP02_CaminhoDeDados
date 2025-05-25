module Read_instructions (instruction, PC, clk, state);
    input wire [31:0] PC;
    input wire clk;
    input wire [3:0] state;
    output reg [31:0] instruction;
    // alterar confome a quantidade de linhas do arquivo
    reg [31:0] instructions [0:14]; // Memória de instruções

    // Lendo instruções
    // Especifique qual instructions.bin esta lendo
    initial begin
        $readmemb("../Inputs/instruction1.bin", instructions); // Lendo instruções em formato binário
        instruction <= instructions[PC];
    end

    // Atualizando instrução a cada ciclo de clock
    always @(posedge clk) begin
        
        if(state == 4'b0000)begin
            instruction <= instructions[PC];
        end
    end

endmodule

