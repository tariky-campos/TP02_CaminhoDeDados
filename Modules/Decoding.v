module Decoding (instruction, opcode, rd, rs1, rs2, funct3, funct7, immediate, type, clk, state, negative);
    input wire [31:0] instruction; 
    input wire clk;
    input wire [3:0] state;
    output reg [6:0] opcode;
    output reg [4:0] rd; // registrador de escrita
    output reg [4:0] rs1; // registrador de leitura 1
    output reg [4:0] rs2; // registrador de leitura 2
    output reg [2:0] funct3; 
    output reg [6:0] funct7;
    output reg [11:0] immediate; 
    output reg [2:0] type; // determinar de qual formato é a instrução
    output reg negative; // sinal de controle para saber se o imediato é negative ou não

    always @(posedge clk) begin
      // estados em a decoficação é usada
      if(state == 4'b0001)begin
        // recebendo os valores conforme o opcode de cada função
        case (instruction[6:4]) 
          3'b000: begin //formato i
            rd <= instruction[11:7];
            rs1 <= instruction[19:15];
            funct3 <= instruction[14:12];
            immediate <= instruction[31:20];
            negative <= 1'b0;
            type <= 3'b000;
          end
          3'b001: begin //formato i
            rd <= instruction[11:7];
            rs1 <= instruction[19:15];
            funct3 <= instruction[14:12];
            if(instruction[31] == 1'b1)begin // se o imediato for negativo
              immediate <= (~(instruction[31:20]) + 1'b1);
              negative <= 1'b1;
            end
            else begin
              immediate <= instruction[31:20];
              negative <= 1'b0;
            end
            type <= 3'b001;
          end
          3'b010: begin //formato s
            immediate <= {instruction[31:25], instruction[11:7]};
            negative <= 1'b0;
            rs1 <= instruction[19:15];
            rs2 <= instruction[24:20];
            funct3 <= instruction[14:12];
            type <= 3'b010;
          end
          3'b011: begin //formato r
            funct7 <= instruction[31:25];
            rs2 <= instruction[24:20];
            rs1 <= instruction[19:15];
            rd <= instruction[11:7];
            funct3 <= instruction[14:12];
            type <= 3'b011;
          end 
          3'b110: begin //formato sb
            if(instruction[31] == 1'b1)begin // se o imediato for negativo
              immediate <= (~{instruction[31], instruction[7], instruction[30:25], instruction[11:8]} + 1) << 1;
              negative <= 1'b1;
            end
            else begin
              immediate <= {instruction[31], instruction[7], instruction[30:25], instruction[11:8]} << 1;
              negative <= 1'b0;
            end
            rs1 <= instruction[19:15];
            rs2 <= instruction[24:20];
            funct3 <= instruction[14:12];
            type <= 3'b110;
          end 
        endcase
      end
  end

endmodule