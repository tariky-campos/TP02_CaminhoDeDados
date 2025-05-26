module ControlUnit(
    input  wire [6:0] opcode,
    input  wire [2:0] funct3,
    output reg        memread,
    output reg        memwrite,
    output reg        regwrite,
    output reg        is_lb,
    output reg        is_sb
);

always @(*) begin
    // Default
    memread  = 0;
    memwrite = 0;
    regwrite = 0;
    is_lb    = 0;
    is_sb    = 0;

    case(opcode)
        7'b0000011: begin // Loads
            memread = 1;
            regwrite = 1;
            if(funct3 == 3'b000) begin // lb
                is_lb = 1;
            end
            // pode expandir para lh, lw, lbu, etc
        end

        7'b0100011: begin // Stores
            memwrite = 1;
            if(funct3 == 3'b000) begin // sb
                is_sb = 1;
            end
            // pode expandir para sh, sw, etc
        end

        // outros casos...

        default: begin
            memread  = 0;
            memwrite = 0;
            regwrite = 0;
            is_lb    = 0;
            is_sb    = 0;
        end
    endcase
end

endmodule
