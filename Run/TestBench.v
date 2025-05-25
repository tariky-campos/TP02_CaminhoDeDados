`include "Main.v"

module caminho_tb;

    reg clk_tb, rst_tb;
    wire [31:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10;
    wire [31:0] reg11, reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19, reg20, reg21;
    wire [31:0] reg22, reg23, reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31;
    wire [31:0] mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8, mem9, mem10, mem11;
    wire [31:0] mem12, mem13, mem14, mem15, mem16, mem17, mem18, mem19, mem20, mem21, mem22, mem23; 
    wire [31:0] mem24, mem25, mem26, mem27, mem28, mem29, mem30, mem31;

    main main (.clk(clk_tb), .rst(rst_tb), .reg0(reg0), .reg1(reg1), .reg2(reg2), 
    .reg3(reg3), .reg4(reg4), .reg5(reg5), .reg6(reg6), .reg7(reg7), .reg8(reg8), 
    .reg9(reg9), .reg10(reg10), .reg11(reg11),.reg12(reg12), .reg13(reg13), 
    .reg14(reg14), .reg15(reg15), .reg16(reg16), .reg17(reg17), .reg18(reg18), 
    .reg19(reg19), .reg20(reg20), .reg21(reg21), .reg22(reg22), .reg23(reg23),
    .reg24(reg24), .reg25(reg25), .reg26(reg26), .reg27(reg27), .reg28(reg28), 
    .reg29(reg29), .reg30(reg30), .reg31(reg31), .mem0(mem0), .mem1(mem1), .mem2(mem2), 
    .mem3(mem3), .mem4(mem4), .mem5(mem5), .mem6(mem6), .mem7(mem7), .mem8(mem8), .mem9(mem9), .mem10(mem10), 
    .mem11(mem11),.mem12(mem12), .mem13(mem13), .mem14(mem14), .mem15(mem15), .mem16(mem16), .mem17(mem17), 
    .mem18(mem18), .mem19(mem19), .mem20(mem20), .mem21(mem21), .mem22(mem22), .mem23(mem23), .mem24(mem24), 
    .mem25(mem25), .mem26(mem26), .mem27(mem27), .mem28(mem28), .mem29(mem29), .mem30(mem30), .mem31(mem31));

    initial begin
        $dumpfile("TestBench.vcd");
        $dumpvars(0, caminho_tb);
        $display("\nResultados Finais");
        rst_tb = 0;
        #1000;
        rst_tb = 1;
        #1
        $display("--------------Memoria--------------");
        $display("memoria [0] =  %d", mem0);
        $display("memoria [1] =  %d", mem1);
        $display("memoria [2] =  %d", mem2);
        $display("memoria [3] =  %d", mem3);
        $display("memoria [4] =  %d", mem4);
        $display("memoria [5] =  %d", mem5);
        $display("memoria [6] =  %d", mem6);
        $display("memoria [7] =  %d", mem7);
        $display("memoria [8] =  %d", mem8);
        $display("memoria [9] =  %d", mem9);
        $display("memoria [10] = %d", mem10);
        $display("memoria [11] = %d", mem11);
        $display("memoria [12] = %d", mem12);
        $display("memoria [13] = %d", mem13);
        $display("memoria [14] = %d", mem14);
        $display("memoria [15] = %d", mem15);
        $display("memoria [16] = %d", mem16);
        $display("memoria [17] = %d", mem17);
        $display("memoria [18] = %d", mem18);
        $display("memoria [19] = %d", mem19);
        $display("memoria [20] = %d", mem20);
        $display("memoria [21] = %d", mem21);
        $display("memoria [22] = %d", mem22);
        $display("memoria [23] = %d", mem23);
        $display("memoria [24] = %d", mem24);
        $display("memoria [25] = %d", mem25);
        $display("memoria [26] = %d", mem26);
        $display("memoria [27] = %d", mem27);
        $display("memoria [28] = %d", mem28);
        $display("memoria [29] = %d", mem29);
        $display("memoria [30] = %d", mem30);
        $display("memoria [31] = %d", mem31);
        $display("--------------Registradores--------------");
        $display("Registrador [0] =  %d", reg0);
        $display("Registrador [1] =  %d", reg1);
        $display("Registrador [2] =  %d", reg2);
        $display("Registrador [3] =  %d", reg3);
        $display("Registrador [4] =  %d", reg4);
        $display("Registrador [5] =  %d", reg5);
        $display("Registrador [6] =  %d", reg6);
        $display("Registrador [7] =  %d", reg7);
        $display("Registrador [8] =  %d", reg8);
        $display("Registrador [9] =  %d", reg9);
        $display("Registrador [10] = %d", reg10);
        $display("Registrador [11] = %d", reg11);
        $display("Registrador [12] = %d", reg12);
        $display("Registrador [13] = %d", reg13);
        $display("Registrador [14] = %d", reg14);
        $display("Registrador [15] = %d", reg15);
        $display("Registrador [16] = %d", reg16);
        $display("Registrador [17] = %d", reg17);
        $display("Registrador [18] = %d", reg18);
        $display("Registrador [19] = %d", reg19);
        $display("Registrador [20] = %d", reg20);
        $display("Registrador [21] = %d", reg21);
        $display("Registrador [22] = %d", reg22);
        $display("Registrador [23] = %d", reg23);
        $display("Registrador [24] = %d", reg24);
        $display("Registrador [25] = %d", reg25);
        $display("Registrador [26] = %d", reg26);
        $display("Registrador [27] = %d", reg27);
        $display("Registrador [28] = %d", reg28);
        $display("Registrador [29] = %d", reg29);
        $display("Registrador [30] = %d", reg30);
        $display("Registrador [31] = %d", reg31);
        $finish;
    end
    initial clk_tb = 1'b0;
    always #1 clk_tb = ~clk_tb;

endmodule