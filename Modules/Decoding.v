module Decoding (instrucao, opcode, rd, rs1, rs2, funct3, funct7, imediato, tipo, clk, estado, negativo);
    input wire [31:0] instrucao; 
    input wire clk;
    input wire [3:0] estado;
    output reg [6:0] opcode;
    output reg [4:0] rd; // registrador de escrita
    output reg [4:0] rs1; // registrador de leitura 1
    output reg [4:0] rs2; // registrador de leitura 2
    output reg [2:0] funct3; 
    output reg [6:0] funct7;
    output reg [11:0] imediato; 
    output reg [2:0] tipo; // determinar de qual formato é a instrução
    output reg negativo; // sinal de controle para saber se o imediato é negativo ou não

    always @(posedge clk) begin
      // estados em a decoficação é usada
      if(estado == 4'b0001)begin
        // recebendo os valores conforme o opcode de cada função
        case (instrucao[6:4]) 
          3'b000: begin //formato i
            rd <= instrucao[11:7];
            rs1 <= instrucao[19:15];
            funct3 <= instrucao[14:12];
            imediato <= instrucao[31:20];
            negativo <= 1'b0;
            tipo <= 3'b000;
          end
          3'b001: begin //formato i
            rd <= instrucao[11:7];
            rs1 <= instrucao[19:15];
            funct3 <= instrucao[14:12];
            if(instrucao[31] == 1'b1)begin // se o imediato for negativo
              imediato <= (~(instrucao[31:20]) + 1'b1);
              negativo <= 1'b1;
            end
            else begin
              imediato <= instrucao[31:20];
              negativo <= 1'b0;
            end
            tipo <= 3'b001;
          end
          3'b010: begin //formato s
            imediato <= {instrucao[31:25], instrucao[11:7]};
            negativo <= 1'b0;
            rs1 <= instrucao[19:15];
            rs2 <= instrucao[24:20];
            funct3 <= instrucao[14:12];
            tipo <= 3'b010;
          end
          3'b011: begin //formato r
            funct7 <= instrucao[31:25];
            rs2 <= instrucao[24:20];
            rs1 <= instrucao[19:15];
            rd <= instrucao[11:7];
            funct3 <= instrucao[14:12];
            tipo <= 3'b011;
          end 
          3'b110: begin //formato sb
            if(instrucao[31] == 1'b1)begin // se o imediato for negativo
              imediato <= (~{instrucao[31], instrucao[7], instrucao[30:25], instrucao[11:8]} + 1) << 1;
              negativo <= 1'b1;
            end
            else begin
              imediato <= {instrucao[31], instrucao[7], instrucao[30:25], instrucao[11:8]} << 1;
              negativo <= 1'b0;
            end
            rs1 <= instrucao[19:15];
            rs2 <= instrucao[24:20];
            funct3 <= instrucao[14:12];
            tipo <= 3'b110;
          end 
        endcase
      end
  end

endmodule