module Control_signis (tipo, regiwrite, memwrite, memread, alucontrol, funct3, clk, branch, memtoreg, alusrc, funct7, estado);
    input wire [2:0] tipo; //Pega os 3 bits mais significativos do opcode para comparação
    input wire [2:0] funct3;
    input wire [6:0] funct7;
    input wire clk;
    input wire [3:0] estado;
    output reg regiwrite;
    output reg [1:0] aluop;
    output reg memwrite;
    output reg memread;
    output reg [3:0] alucontrol;
    output reg branch;
    output reg memtoreg;
    output reg alusrc;

    // gerando sinais de controle
    always @(posedge clk)begin
        // estado para gerar valores de controle para a alu realizar determina operação
        /* 
        inicialmente os sinais de controle de escrita e leitura são iniciados como don't care 
        para não ocorrer a escrita no registrar antes do resultado da alu estiver pronto
        */
        if(estado == 4'b0010 ) begin
            case (tipo)
                // sinais de controle para i
                3'b000: begin //lw
                    regiwrite <= 1'bx;
                    memwrite <= 1'bx;
                    memread <= 1'bx;
                    alucontrol <= 4'b0010;
                    branch <= 1'b0;
                    memtoreg <= 1'b1;
                    alusrc <= 1'b1;
                end
                // sinais de controle para i
                3'b001: begin //addi
                    regiwrite <= 1'bx;
                    memwrite <= 1'bx;
                    memread <= 1'bx;
                    alucontrol <= 4'b0011;
                    branch <= 1'b0;
                    memtoreg <= 1'b0;
                    alusrc <= 1'b1;
                end
                // sinais de controle para s
                3'b010: begin //sw
                    regiwrite <= 1'bx;
                    memwrite <= 1'bx;
                    memread <= 1'bx;
                    alucontrol <= 4'b0010;
                    branch <= 1'b0;
                    memtoreg <= 1'b1;
                    alusrc <= 1'b1;
                end
                // sinais de controle para r
                3'b011: begin
                    // como o opcode é igual para todos os tipos de r, é necessário verificar o funct3
                    case (funct3)
                        3'b000 : begin //sub e soma
                            // add e sub são iguais, a diferença é o funct7
                            case(funct7[6:5])
                                2'b00: begin
                                    regiwrite <= 1'bx;
                                    memwrite <= 1'bx;
                                    memread <= 1'bx;
                                    alucontrol <= 4'b0010;
                                    branch <= 1'b0;
                                    memtoreg <= 1'b0;
                                    alusrc <= 1'b0;
                                end
                                2'b01: begin
                                    regiwrite <= 1'bx;
                                    memwrite <= 1'bx;
                                    memread <= 1'bx;
                                    alucontrol <= 4'b0110;
                                    branch <= 1'b0;
                                    memtoreg <= 1'b0;
                                    alusrc <= 1'b0;
                                end
                            endcase
                        end
                        3'b100 : begin //xor
                            regiwrite <= 1'bx;
                            memwrite <= 1'bx;
                            memread <= 1'bx;
                            alucontrol <= 4'b0100;
                            branch <= 1'b0;
                            memtoreg <= 1'b0;
                            alusrc <= 1'b0;
                        end
                        3'b101 : begin //srl
                            regiwrite <= 1'bx;
                            memwrite <= 1'bx;
                            memread <= 1'bx;
                            alucontrol <= 4'b0101;
                            branch <= 1'b0;
                            memtoreg <= 1'b0;
                            alusrc <= 1'b0;
                        end
                        3'b111 : begin //and
                        regiwrite <= 1'bx;
                        memwrite <= 1'bx;
                        memread <= 1'bx;
                            alucontrol <= 4'b0000;
                            branch <= 1'b0;
                            memtoreg <= 1'b0;
                            alusrc <= 1'b0;
                        end
                        3'b110 : begin //or
                            regiwrite <= 1'bx;
                            memwrite <= 1'bx;
                            memread <= 1'bx;
                            alucontrol <= 4'b0001;
                            branch <= 1'b0;
                            memtoreg <= 1'b0;
                            alusrc <= 1'b0;
                        end
                    endcase
                end
                // sinais de controle para sb
                3'b110: begin //beq
                    regiwrite <= 1'bx;
                    memwrite <= 1'bx;
                    memread <= 1'bx;
                    alucontrol <= 4'b0110;
                    branch <= 1'b1;
                    memtoreg <= 1'b0;
                    alusrc <= 1'b1;
                end
            endcase
        end
        // estado para gerar valores de controle para a leitura ou escrita
        /* 
        nesse último estado após o resultado vindo da alu estiver pronto os sinais de controle 
        de escrita e lei são gerados
        */
        if(estado == 4'b1111 )begin
            case (tipo)
                3'b000: begin //lw
                    regiwrite <= 1'b1;
                    memwrite <= 1'b0;
                    memread <= 1'b1;
                    alucontrol <= 4'b0010;
                    branch <= 1'b0;
                    memtoreg <= 1'b1;
                    alusrc <= 1'b1;
                end
                3'b001: begin //addi
                    regiwrite <= 1'b1;
                    memwrite <= 1'b0;
                    memread <= 1'b0;
                    alucontrol <= 4'b0011;
                    branch <= 1'b0;
                    memtoreg <= 1'b0;
                    alusrc <= 1'b1;
                end
                3'b010: begin //sw
                    regiwrite <= 1'b0;
                    memwrite <= 1'b1;
                    memread <= 1'b0;
                    alucontrol <= 4'b0010;
                    branch <= 1'b0;
                    memtoreg <= 1'b1;
                    alusrc <= 1'b1;
                end
                3'b011: begin
                    case (funct3)
                        3'b000 : begin //sub e soma
                            case(funct7[6:5])
                                2'b00: begin
                                    regiwrite <= 1'b1;
                                    memwrite <= 1'b0;
                                    memread <= 1'b0;
                                    alucontrol <= 4'b0010;
                                    branch <= 1'b0;
                                    memtoreg <= 1'b0;
                                    alusrc <= 1'b0;
                                end
                                2'b01: begin
                                regiwrite <= 1'b1;
                                    memwrite <= 1'b0;
                                    memread <= 1'b0;
                                    alucontrol <= 4'b0110;
                                    branch <= 1'b0;
                                    memtoreg <= 1'b0;
                                    alusrc <= 1'b0;
                                end
                            endcase
                        end
                        3'b100 : begin //xor
                            regiwrite <= 1'b1;
                            memwrite <= 1'b0;
                            memread <= 1'b0;
                            alucontrol <= 4'b0100;
                            branch <= 1'b0;
                            memtoreg <= 1'b0;
                            alusrc <= 1'b0;
                        end
                        3'b101 : begin //srl
                            regiwrite <= 1'b1;
                            memwrite <= 1'b0;
                            memread <= 1'b0;
                            alucontrol <= 4'b0101;
                            branch <= 1'b0;
                            memtoreg <= 1'b0;
                            alusrc <= 1'b0;
                        end
                        3'b111 : begin //and
                            regiwrite <= 1'b1;
                            memwrite <= 1'b0;
                            memread <= 1'b0;
                            alucontrol <= 4'b0000;
                            branch <= 1'b0;
                            memtoreg <= 1'b0;
                            alusrc <= 1'b0;
                        end
                        3'b110 : begin //or
                            regiwrite <= 1'b1;
                            memwrite <= 1'b0;
                            memread <= 1'b0;
                            alucontrol <= 4'b0001;
                            branch <= 1'b0;
                            memtoreg <= 1'b0;
                            alusrc <= 1'b0;
                        end
                    endcase
                end
                3'b110: begin //beq
                    case (funct3)
                        3'b000 : begin
                            regiwrite <= 1'b0;
                            memwrite <= 1'b0;
                            memread <= 1'b0;
                            alucontrol <= 4'b0110;
                            branch <= 1'b1;
                            memtoreg <= 1'b0;
                            alusrc <= 1'b1;
                        end
                        3'b001 : begin
                            regiwrite <= 1'b0;
                            memwrite <= 1'b0;
                            memread <= 1'b0;
                            alucontrol <= 4'b1111;
                            branch <= 1'b1;
                            memtoreg <= 1'b0;
                            alusrc <= 1'b1;
                        end
                    endcase

                end
            endcase
        end
    end
    
endmodule