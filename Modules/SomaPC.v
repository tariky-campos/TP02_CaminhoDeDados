module SomaPC(PC, clk, pcsrc, immediate, state, negative);
  input wire clk;
  input wire [3:0] state;
  input pcsrc;
  input [11:0] immediate;
  input negative;
  output reg [31:0] PC; // posição da próxima instrução

  // inicializa o PC
  initial begin
      PC <= 0;
  end

  // incrementa o PC
  always @(posedge clk) begin
    if(state == 4'b1000) begin
      // sinais de controle para o pc saber se vai ser incrementado com imeadiato ou não
      case (pcsrc)
          1'b0: begin
            PC <= PC + 1; // proxima instrução
          end
          1'b1: begin
            // sinal de controle para saber se o imediato é negative ou não
            if(negative == 1'b1)begin
              PC <= PC - (immediate/4); // caso haja desvio
            end
            else begin
              PC <= PC + (immediate/4); // caso haja desvio
            end
          end
      endcase
    end
  end

endmodule