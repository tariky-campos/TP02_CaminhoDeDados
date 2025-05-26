module SomaPC (PC, clk, pcsrc, imediato, estado, negativo);
  input wire clk;
  input wire [3:0] estado;
  input pcsrc;
  input [11:0] imediato;
  input negativo;
  output reg [31:0] PC; // posição da próxima instrução

  // inicializa o PC
  initial begin
      PC <= 0;
  end

  // incrementa o PC
  always @(posedge clk) begin
    if(estado == 4'b1000) begin
      // sinais de controle para o pc saber se vai ser incrementado com imeadiato ou não
      case (pcsrc)
          1'b0: begin
            PC <= PC + 1; // proxima instrução
          end
          1'b1: begin
            // sinal de controle para saber se o imediato é negativo ou não
            if(negativo == 1'b1)begin
              PC <= PC - (imediato/4); // caso haja desvio
            end
            else begin
              PC <= PC + (imediato/4); // caso haja desvio
            end
          end
      endcase
    end
  end

endmodule