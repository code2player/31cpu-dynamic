module sccomp_dataflow(
input clk_in,
input reset,
input stop,

output [7:0] o_seg,
output [7:0] o_sel
/*output clk1,
output [31:0] inst,
output [31:0] pc,
output [31:0] dmem_out,
output [31:0] imem_addr,
output [31:0] dmem_data,
output [31:0] dmem_addr,
output dmem_DM_W,
output [31:0] add_out,
output equal_out,
output [31:0] join_out,
output [31:0] pcmux_out,
output [31:0] aluamux_out,
output [31:0] alubmux_out,
output [31:0] rdmux_out,
output [4:0] rdcmux_out,
output [31:0] ext5_out,
output [31:0] ext16_out,
output [31:0] sext16_out,
output [31:0] sext18_out,
output [31:0] rs_out,
output [31:0] rt_out,
output [31:0] alu_out,
output RF_W_control,
output [3:0] ALUC_control,
output  [1:0] PCMux_control,
output  [2:0] ALUaMux_control,
output  [1:0] ALUbMux_control,
output  rdMux_control,
output  [1:0] rdcMux_control,
output CS_control,
output DM_R_control,
output DM_W_control,
output [4:0] stall,
output HI_W,
output LO_W,
output [1:0] rsoutMux,
output [1:0] rtoutMux,
output [1:0] hioutMux,
output [1:0] looutMux,
output [31:0] rs_to_mux,
output [31:0] rt_to_mux,
output [31:0] hi_out,
output [31:0] lo_out,
output [31:0] hi_mux_out,
output [31:0] lo_mux_out,
output [63:0] z,
output [63:0] Z1,
output [63:0] Z2,
output id_ex_RF_W,
output [3:0] id_ex_aluc,
output id_ex_DM_W,
output id_ex_rdMux,
output [1:0] id_ex_rdcMux,
output ex_me_RF_W,
output ex_me_DM_W,
output ex_me_rdMux,
output [1:0] ex_me_rdcMux,
output ex_me_Z,
output ex_me_C,
output ex_me_N,
output ex_me_O,
output me_wb_RF_W,
output me_wb_rdMux,
output [1:0] me_wb_rdcMux,
output me_wb_Z,
output me_wb_C,
output me_wb_N,
output me_wb_O,
output [31:0] NPC,
output [31:0] IR1,
output [31:0] IR2,
output [31:0] IR3,
output [31:0] IR4,
output [31:0] ALUa,
output [31:0] ALUb,
output [31:0] ALUo1,
output [31:0] ALUo2,
output [31:0] Rdata1,
output [31:0] Rdata2,
output [31:0] Wdata,
output [31:0] pc1,
output [31:0] pc2,
output [31:0] pc3,
output [31:0] pc4,
output [31:0] out_reg*/
    );
    
    wire clk1;
    wire [31:0] inst;
    wire [31:0] pc;
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
    wire RF_W_control;
    wire [3:0] ALUC_control;
    wire  [1:0] PCMux_control;
    wire  [2:0] ALUaMux_control;
    wire  [1:0] ALUbMux_control;
    wire  rdMux_control;
    wire  [1:0] rdcMux_control;
    wire CS_control;
    wire DM_R_control;
    wire DM_W_control;
    wire [4:0] stall;
    
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
    
    
    wire id_ex_RF_W;
    wire [3:0] id_ex_aluc;
    wire id_ex_DM_W;
    wire id_ex_rdMux;
    wire [1:0] id_ex_rdcMux;
    wire ex_me_RF_W;
    wire ex_me_DM_W;
    wire ex_me_rdMux;
    wire [1:0] ex_me_rdcMux;
    wire ex_me_Z;
    wire ex_me_C;
    wire ex_me_N;
    wire ex_me_O;
    wire me_wb_RF_W;
    wire me_wb_rdMux;
    wire [1:0] me_wb_rdcMux;
    wire me_wb_Z;
    wire me_wb_C;
    wire me_wb_N;
    wire me_wb_O;
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

    wire clk_in2=clk_in|stop;

    
    wire [31:0] dm_addr;
    wire [31:0] im_addr;
        assign im_addr =  imem_addr- 32'h00400000;
        assign dm_addr =  dmem_addr- 32'h10010000;
    
    IMEM imemory(pc[12:2],inst);
    DMEM dmemory(clk1,1'b1,dmem_DM_W,dm_addr[12:2],dmem_data,dmem_out);
    
   /* module cpu(
    input clk,
    input rst,
    input [31:0] imem_out,
    input [31:0] dmem_out,
    output [31:0] imem_in,
    output [31:0] dmem_data_in,
    output [31:0] dmem_addr_in,
    output dmem_DM_W
    
    );*/
    
    cpu sccpu(clk1,reset,inst,dmem_out,imem_addr,dmem_data,dmem_addr,dmem_DM_W,pc,
    add_out,
    equal_out,
    join_out,
    pcmux_out,
    aluamux_out,
    alubmux_out,
    rdmux_out,
    rdcmux_out,
    ext5_out,
    ext16_out,
    sext16_out,
    sext18_out,
    rs_out,
    rt_out,
    alu_out,
    RF_W_control,
    ALUC_control,
    PCMux_control,
    ALUaMux_control,
    ALUbMux_control,
    rdMux_control,
    rdcMux_control,
    CS_control,
    DM_R_control,
    DM_W_control,
    stall,
     HI_W,
    LO_W,
     rsoutMux,
     rtoutMux,
     hioutMux,
     looutMux,
     rs_to_mux,
     rt_to_mux,
     hi_out,
     lo_out,
     hi_mux_out,
     lo_mux_out,
     z,
     Z1,
     Z2,
    id_ex_RF_W,
    id_ex_aluc,
    id_ex_DM_W,
    id_ex_rdMux,
    id_ex_rdcMux,
    ex_me_RF_W,
    ex_me_DM_W,
    ex_me_rdMux,
    ex_me_rdcMux,
    ex_me_Z,
    ex_me_C,
    ex_me_N,
    ex_me_O,
    me_wb_RF_W,
    me_wb_rdMux,
    me_wb_rdcMux,
    me_wb_Z,
    me_wb_C,
    me_wb_N,
    me_wb_O,
    NPC,
    IR1,
    IR2,
    IR3,
    IR4,
    ALUa,
    ALUb,
    ALUo1,
    ALUo2,
    Rdata1,
    Rdata2,
    Wdata,
    pc1,pc2,pc3,pc4,out_reg); 
    
    
   // assign clk1=clk_in;
        Divider d1(clk_in2,reset,clk1);
        seg7x16 s716(clk_in,reset,1,out_reg,o_seg,o_sel);
    
    
endmodule
