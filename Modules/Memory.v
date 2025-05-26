module Memory (
    input wire clk,
    input wire [3:0] estado,
    input wire [31:0] aluresult2,
    input wire [31:0] ler_dados2,
    input wire memwrite,
    input wire memread,
    input wire [11:0] imediato,

    input wire is_lb,
    input wire is_sb,

    output reg [31:0] reddataM,
    output reg [31:0] writedataR,
    output reg [31:0] mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7,
                     mem8, mem9, mem10, mem11, mem12, mem13, mem14, mem15,
                     mem16, mem17, mem18, mem19, mem20, mem21, mem22, mem23,
                     mem24, mem25, mem26, mem27, mem28, mem29, mem30, mem31
);

// Memória interna: 32 palavras de 32 bits
reg [31:0] memoria [0:31];

// Endereço de palavra (5 bits): endereços dos 32 blocos de 32 bits
wire [4:0] addr_word = aluresult2[6:2];

// Offset do byte dentro da palavra (2 bits)
wire [1:0] addr_byte = aluresult2[1:0];

// Para extrair o byte certo para lb
reg [7:0] byte_data;
reg [31:0] lb_data;

// Combinacional: extrai byte e faz extensão de sinal para lb
always @(*) begin
    case(addr_byte)
        2'b00: byte_data = memoria[addr_word][7:0];
        2'b01: byte_data = memoria[addr_word][15:8];
        2'b10: byte_data = memoria[addr_word][23:16];
        2'b11: byte_data = memoria[addr_word][31:24];
        default: byte_data = 8'b0;
    endcase

    // Extensão de sinal do byte para 32 bits
    lb_data = {{24{byte_data[7]}}, byte_data};
end

// Inicialização da memória
initial begin
    $readmemb("../Inputs/memory.bin", memoria);
    memoria[4] = 32'h000000AA;  // exemplo para teste

    // Atualiza saída para visualização
    mem0 = memoria[0];
    mem1 = memoria[1];
    mem2 = memoria[2];
    mem3 = memoria[3];
    mem4 = memoria[4];
    mem5 = memoria[5];
    mem6 = memoria[6];
    mem7 = memoria[7];
    mem8 = memoria[8];
    mem9 = memoria[9];
    mem10 = memoria[10];
    mem11 = memoria[11];
    mem12 = memoria[12];
    mem13 = memoria[13];
    mem14 = memoria[14];
    mem15 = memoria[15];
    mem16 = memoria[16];
    mem17 = memoria[17];
    mem18 = memoria[18];
    mem19 = memoria[19];
    mem20 = memoria[20];
    mem21 = memoria[21];
    mem22 = memoria[22];
    mem23 = memoria[23];
    mem24 = memoria[24];
    mem25 = memoria[25];
    mem26 = memoria[26];
    mem27 = memoria[27];
    mem28 = memoria[28];
    mem29 = memoria[29];
    mem30 = memoria[30];
    mem31 = memoria[31];
end

// Escrita e leitura da memória sincronizadas com clock
always @(posedge clk) begin
    if ((estado == 4'b0011) || (estado == 4'b0110) || (estado == 4'b0111)) begin
        // Escrita na memória
        if (memwrite) begin
            if (is_sb) begin
                // store byte: altera só o byte selecionado, mantém os outros intactos
                case(addr_byte)
                    2'b00: memoria[addr_word] <= {memoria[addr_word][31:8], ler_dados2[7:0]};
                    2'b01: memoria[addr_word] <= {memoria[addr_word][31:16], ler_dados2[7:0], memoria[addr_word][7:0]};
                    2'b10: memoria[addr_word] <= {memoria[addr_word][31:24], ler_dados2[7:0], memoria[addr_word][15:0]};
                    2'b11: memoria[addr_word] <= {ler_dados2[7:0], memoria[addr_word][23:0]};
                endcase
            end else begin
                // store word completo
                memoria[addr_word] <= ler_dados2;
            end
        end

        // Leitura da memória
        if (memread) begin
            if (is_lb) begin
                reddataM <= lb_data;  // byte carregado com extensão de sinal
            end else begin
                reddataM <= memoria[addr_word];  // palavra completa
            end
        end else begin
            reddataM <= 32'b0;
        end

        // Atualiza saída de writedataR (endereço calculado pela ALU)
        writedataR <= aluresult2;

        // Atualiza registradores para visualização do estado da memória
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
