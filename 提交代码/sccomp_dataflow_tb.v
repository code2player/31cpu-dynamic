`timescale 1ns / 1ns
module test(
    );
    reg clk, rst;
    wire clk1;
    wire [31:0] inst, pc; 
    
    
    
        wire [31:0] dmem_out;
    wire [31:0] imem_addr;
    wire [31:0] dmem_data;
    wire [31:0] dmem_addr;
    wire dmem_DM_W;
    
        wire [31:0] add_out;
    wire equal_out;
    wire [31:0] join_out;
    
    wire [31:0] pcmux_out;
    wire [31:0] aluamux_out;
    wire [31:0] alubmux_out;
    wire [31:0] rdmux_out;
    wire [4:0] rdcmux_out;
    
    wire [31:0] ext5_out;
    wire [31:0] ext16_out;
    wire [31:0] sext16_out;
    wire [31:0] sext18_out;
    
    wire [31:0] rs_out;
    wire [31:0] rt_out;
    wire [31:0] alu_out;
    
    /*控制信号*/
    /*---------------------------------*/
    wire RF_W_control;
    wire [3:0] ALUC_control;//alu识别码
    
    /*选择器*/
    wire  [1:0] PCMux_control;
    wire  [2:0] ALUaMux_control;
    wire  [1:0] ALUbMux_control;
    wire  rdMux_control;
    wire  [1:0] rdcMux_control;
    
    
    /*dmem信号*/
    wire CS_control;//无用
    wire DM_R_control;//无用
    wire DM_W_control;
    
    wire [4:0] stall;
    //wire [4:0] stall1;
    
    wire HI_W;
    wire LO_W;
    wire [1:0] rsoutMux;
    wire [1:0] rtoutMux;
    wire [1:0] hioutMux;
    wire [1:0] looutMux;
    wire [31:0] rs_to_mux;
    wire [31:0] rt_to_mux;
    
    wire [31:0] hi_out;
    wire [31:0] lo_out;
    wire [31:0] hi_mux_out;
    wire [31:0] lo_mux_out;
    
    
    wire [63:0] z;
    wire [63:0] Z1;
    wire [63:0] Z2;
    
    /*id-ex段间控制信号寄存器*/
    wire id_ex_RF_W;
    wire [3:0] id_ex_aluc;
    wire id_ex_DM_W;
    wire id_ex_rdMux;
    wire [1:0] id_ex_rdcMux;
    
    /*ex-me段间控制信号寄存器*/
    wire ex_me_RF_W;
   // wire [3:0] ex_me_aluc;
    wire ex_me_DM_W;
    wire ex_me_rdMux;
    wire [1:0] ex_me_rdcMux;
    wire ex_me_Z;
    wire ex_me_C;
    wire ex_me_N;
    wire ex_me_O;

    
    /*me-wb段间控制信号寄存器*/
    wire me_wb_RF_W;
   // wire [3:0] me_wb_aluc;
    //wire me_wb_DM_W;
    wire me_wb_rdMux;
    wire [1:0] me_wb_rdcMux;
    wire me_wb_Z;
    wire me_wb_C;
    wire me_wb_N;
    wire me_wb_O;
    
    
    /*---------------------------------*/
    /*段间寄存器*/
    wire [31:0] NPC;
    wire [31:0] IR1;
    wire [31:0] IR2;
    wire [31:0] IR3;
    wire [31:0] IR4;
    wire [31:0] ALUa;
    wire [31:0] ALUb;
    wire [31:0] ALUo1;
    wire [31:0] ALUo2;
    wire [31:0] Rdata1;
    wire [31:0] Rdata2;
    wire [31:0] Wdata;
    wire [31:0] pc1;
    wire [31:0] pc2;
    wire [31:0] pc3;
    wire [31:0] pc4;
    wire [31:0] out_reg;
    
    integer file_output;
    integer counter=0 ;
    initial begin
        file_output = $fopen("result.txt", "a");
        clk = 1'b0;
        rst = 1'b1;
        #50 rst=1'b0;
    end

    always begin
        #20 clk = !clk;
    end
    

    always @(posedge clk) begin
        if(counter>=1200)
        begin
        $fclose(file_output);
        end
        else if(clk==1'b1&&rst==1'b0)
        begin
        if(IR4!=32'hffffffff)
        begin
        counter=counter+1;
      /*  $fdisplay(file_output, "pc: %h", pc4);
        $fdisplay(file_output, "instr: %h", IR4);
        $fdisplay(file_output, "regfile0: %h", test.uut.sccpu.cpu_ref.array_reg[0]);
        $fdisplay(file_output, "regfile1: %h", test.uut.sccpu.cpu_ref.array_reg[1]);
        $fdisplay(file_output, "regfile2: %h", test.uut.sccpu.cpu_ref.array_reg[2]);
        $fdisplay(file_output, "regfile3: %h", test.uut.sccpu.cpu_ref.array_reg[3]);
        $fdisplay(file_output, "regfile4: %h", test.uut.sccpu.cpu_ref.array_reg[4]);
        $fdisplay(file_output, "regfile5: %h", test.uut.sccpu.cpu_ref.array_reg[5]);
        $fdisplay(file_output, "regfile6: %h", test.uut.sccpu.cpu_ref.array_reg[6]);
        $fdisplay(file_output, "regfile7: %h", test.uut.sccpu.cpu_ref.array_reg[7]);
        $fdisplay(file_output, "regfile8: %h", test.uut.sccpu.cpu_ref.array_reg[8]);
        $fdisplay(file_output, "regfile9: %h", test.uut.sccpu.cpu_ref.array_reg[9]);
        $fdisplay(file_output, "regfile10: %h", test.uut.sccpu.cpu_ref.array_reg[10]);
        $fdisplay(file_output, "regfile11: %h", test.uut.sccpu.cpu_ref.array_reg[11]);
        $fdisplay(file_output, "regfile12: %h", test.uut.sccpu.cpu_ref.array_reg[12]);
        $fdisplay(file_output, "regfile13: %h", test.uut.sccpu.cpu_ref.array_reg[13]);
        $fdisplay(file_output, "regfile14: %h", test.uut.sccpu.cpu_ref.array_reg[14]);
        $fdisplay(file_output, "regfile15: %h", test.uut.sccpu.cpu_ref.array_reg[15]);
        $fdisplay(file_output, "regfile16: %h", test.uut.sccpu.cpu_ref.array_reg[16]);
        $fdisplay(file_output, "regfile17: %h", test.uut.sccpu.cpu_ref.array_reg[17]);
        $fdisplay(file_output, "regfile18: %h", test.uut.sccpu.cpu_ref.array_reg[18]);
        $fdisplay(file_output, "regfile19: %h", test.uut.sccpu.cpu_ref.array_reg[19]);
        $fdisplay(file_output, "regfile20: %h", test.uut.sccpu.cpu_ref.array_reg[20]);
        $fdisplay(file_output, "regfile21: %h", test.uut.sccpu.cpu_ref.array_reg[21]);
        $fdisplay(file_output, "regfile22: %h", test.uut.sccpu.cpu_ref.array_reg[22]);
        $fdisplay(file_output, "regfile23: %h", test.uut.sccpu.cpu_ref.array_reg[23]);
        $fdisplay(file_output, "regfile24: %h", test.uut.sccpu.cpu_ref.array_reg[24]);
        $fdisplay(file_output, "regfile25: %h", test.uut.sccpu.cpu_ref.array_reg[25]);
        $fdisplay(file_output, "regfile26: %h", test.uut.sccpu.cpu_ref.array_reg[26]);
        $fdisplay(file_output, "regfile27: %h", test.uut.sccpu.cpu_ref.array_reg[27]);
        $fdisplay(file_output, "regfile28: %h", test.uut.sccpu.cpu_ref.array_reg[28]);
        $fdisplay(file_output, "regfile29: %h", test.uut.sccpu.cpu_ref.array_reg[29]);
        $fdisplay(file_output, "regfile30: %h", test.uut.sccpu.cpu_ref.array_reg[30]);
        $fdisplay(file_output, "regfile31: %h", test.uut.sccpu.cpu_ref.array_reg[31]);*/
        end
        end
        else
        begin
        
        end
        
    end
    
    sccomp_dataflow uut(
        .clk_in(clk),
        .reset(rst),
        .clk1(clk1),
        .inst(inst),
        .pc(pc),
        .dmem_out(dmem_out),
        .imem_addr(imem_addr),
        .dmem_data(dmem_data),
        .dmem_addr(dmem_addr),
        .dmem_DM_W(dmem_DM_W),
        
        .add_out(add_out),
                .equal_out(equal_out),
                .join_out(join_out),
                .pcmux_out(pcmux_out),
                .aluamux_out(aluamux_out),
                .alubmux_out(alubmux_out),
                .rdmux_out(rdmux_out),
                .rdcmux_out(rdcmux_out),
                .ext5_out(ext5_out),
                .ext16_out(ext16_out),
                .sext16_out(sext16_out),
                .sext18_out(sext18_out),
                .rs_out(rs_out),
                .rt_out(rt_out),
                .alu_out(alu_out),
                .RF_W_control(RF_W_control),
                .ALUC_control(ALUC_control),
                .PCMux_control(PCMux_control),
                .ALUaMux_control(ALUaMux_control),
                .ALUbMux_control(ALUbMux_control),
                .rdMux_control(rdMux_control),
                .rdcMux_control(rdcMux_control),
                .CS_control(CS_control),
                .DM_R_control(DM_R_control),
                .DM_W_control(DM_W_control),
                .stall(stall),
                 .HI_W(HI_W),
                 .LO_W(LO_W),
                 .rsoutMux(rsoutMux),
                 .rtoutMux(rtoutMux),
                 .hioutMux(hioutMux),
                 .looutMux(looutMux),
                 .rs_to_mux(rs_to_mux),
                 .rt_to_mux(rt_to_mux),
                 .hi_out(hi_out),
                 .lo_out(lo_out),
                 .hi_mux_out(hi_mux_out),
                 .lo_mux_out(lo_mux_out),
                 .z(z),
                 .Z1(Z1),
                 .Z2(Z2),
                .id_ex_RF_W(id_ex_RF_W),
                .id_ex_aluc(id_ex_aluc),
                .id_ex_DM_W(id_ex_DM_W),
                .id_ex_rdMux(id_ex_rdMux),
                .id_ex_rdcMux(id_ex_rdcMux),
                .ex_me_RF_W(ex_me_RF_W),
                .ex_me_DM_W(ex_me_DM_W),
                .ex_me_rdMux(ex_me_rdMux),
                .ex_me_rdcMux(ex_me_rdcMux),
                .ex_me_Z(ex_me_Z),
                .ex_me_C(ex_me_C),
                .ex_me_N(ex_me_N),
                .ex_me_O(ex_me_O),
                .me_wb_RF_W(me_wb_RF_W),
                .me_wb_rdMux(me_wb_rdMux),
                .me_wb_rdcMux(me_wb_rdcMux),
                .me_wb_Z(me_wb_Z),
                .me_wb_C(me_wb_C),
                .me_wb_N(me_wb_N),
                .me_wb_O(me_wb_O),
                .NPC(NPC),
                .IR1(IR1),
                .IR2(IR2),
                .IR3(IR3),
                .IR4(IR4),
                .ALUa(ALUa),
                .ALUb(ALUb),
                .ALUo1(ALUo1),
                .ALUo2(ALUo2),
                .Rdata1(Rdata1),
                .Rdata2(Rdata2),
                .Wdata(Wdata),
                .pc1(pc1),.pc2(pc2),.pc3(pc3),.pc4(pc4),
                .out_reg(out_reg)
        
    );
endmodule

