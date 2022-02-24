module cpu(
input clk,
input rst,
input [31:0] imem_out,
input [31:0] dmem_out,
output [31:0] imem_in,
output [31:0] dmem_data_in,
output [31:0] dmem_addr_in,
output dmem_DM_W,
output [31:0] pc_out,
output wire [31:0] add_out,
output wire equal_out,
output wire [31:0] join_out,

output wire [31:0] pcmux_out,
output wire [31:0] aluamux_out,
output wire [31:0] alubmux_out,
output wire [31:0] rdmux_out,
output wire [4:0] rdcmux_out,

output wire [31:0] ext5_out,
output wire [31:0] ext16_out,
output wire [31:0] sext16_out,
output wire [31:0] sext18_out,

output wire [31:0] rs_out,
output wire [31:0] rt_out,
output wire [31:0] alu_out,

/*控制信号*/
/*---------------------------------*/
output wire RF_W_control,
output wire [3:0] ALUC_control,//alu识别码

/*选择器*/
output wire  [1:0] PCMux_control,
output wire  [2:0] ALUaMux_control,
output wire  [1:0] ALUbMux_control,
output wire  rdMux_control,
output wire  [1:0] rdcMux_control,


/*dmem信号*/
output wire CS_control,//无用
output wire DM_R_control,//无用
output wire DM_W_control,

output wire [4:0] stall,


/*动态额外添加*/
output wire HI_W,
output wire LO_W,
output wire [1:0] rsoutMux,
output wire [1:0] rtoutMux,
output wire [1:0] hioutMux,
output wire [1:0] looutMux,
output wire [31:0] rs_to_mux,
output wire [31:0] rt_to_mux,

output wire [31:0] hi_out,
output wire [31:0] lo_out,
output wire [31:0] hi_mux_out,
output wire [31:0] lo_mux_out,


output wire [63:0] z,
output reg [63:0] Z1,
output reg [63:0] Z2,



/*id-ex段间控制信号寄存器*/
output reg id_ex_RF_W,
output reg [3:0] id_ex_aluc,
output reg id_ex_DM_W,
output reg id_ex_rdMux,
output reg [1:0] id_ex_rdcMux,

/*ex-me段间控制信号寄存器*/
output reg ex_me_RF_W,
// output reg [3:0] ex_me_aluc,
output reg ex_me_DM_W,
output reg ex_me_rdMux,
output reg [1:0] ex_me_rdcMux,
output wire ex_me_Z,
output wire ex_me_C,
output wire ex_me_N,
output wire ex_me_O,


/*me-wb段间控制信号寄存器*/
output reg me_wb_RF_W,
// output reg [3:0] me_wb_aluc,
//output reg me_wb_DM_W,
output reg me_wb_rdMux,
output reg [1:0] me_wb_rdcMux,
output reg me_wb_Z,
output reg me_wb_C,
output reg me_wb_N,
output reg me_wb_O,


/*---------------------------------*/
/*段间寄存器*/
output reg [31:0] NPC,
output reg [31:0] IR1,
output reg [31:0] IR2,
output reg [31:0] IR3,
output reg [31:0] IR4,
output reg [31:0] ALUa,
output reg [31:0] ALUb,
output reg [31:0] ALUo1,
output reg [31:0] ALUo2,
output reg [31:0] Rdata1,
output reg [31:0] Rdata2,
output reg [31:0] Wdata,
output reg [31:0] pc1,
output reg [31:0] pc2,
output reg [31:0] pc3,
output reg [31:0] pc4,
output [31:0] out_seg
);
    /*流水线：分段声明；分段定义、实例化模块*/
    /*每个流水段间，处理两个东西：
    1：段间寄存器
    2：之后所有流水段所需要的控制信号*/
    /*控制信号：id段译码得出，在id-ex，ex-me，me-wb三个段间需要使用*/
    
    //wire [31:0] pc_out;
    //wire [31:0] npc_out;
    //wire [31:0] imem_out;
    //wire [31:0] dmem_out;
    wire [31:0] outreg1;
    wire [31:0] outreg2;
    assign out_seg=outreg1;

    
    
    /*组合逻辑控制器*/
        controller con(rst,imem_out,IR1,IR2,IR3,IR4,equal_out,RF_W_control,ALUC_control,
        PCMux_control,ALUaMux_control,ALUbMux_control,rdMux_control,rdcMux_control,
        CS_control,DM_R_control,DM_W_control,stall,
        HI_W,LO_W,rsoutMux,rtoutMux,hioutMux,looutMux);
    
    
    
    //stall:[4:0] wb me ex id if
    //stall后方正常流水，前方停止
    
    
    
    //if
    selector41 PCmux(NPC,add_out,join_out,rs_out,PCMux_control,pcmux_out);
    pc pc_cpu(clk,rst,~(stall[0]),pcmux_out,pc_out);
    assign imem_in=pc_out;
    
    //if-id
    always @ (posedge clk or posedge rst) begin
        if (rst==1 || (stall[0]==1 && stall[1]==0)) begin
            NPC <= 32'h00400000;
            IR1 <= 32'hffffffff;
        end
        else if ((stall[0]==0)) begin
            NPC <= pc_out + 4;
            IR1 <= imem_out;
            pc1<=pc_out;
        end
        else 
        begin
       /*NPC <= pc_out + 4;
                    IR1 <= imem_out;*/
        end
    end
    
    //id
    Regfiles cpu_ref(clk,rst,me_wb_RF_W,IR1[25:21],IR1[20:16],rdcmux_out,rdmux_out,rs_to_mux,rt_to_mux,outreg1,outreg2);
    equal_unit eu(rs_out,rt_out,equal_out);
    joint_pc_im jpi({IR1[25:0],2'b00},pc_out[31:28],join_out);
    ADD add_unit(sext18_out,NPC,add_out);
    
    EXT_5 ext5(IR1[10:6],ext5_out);
    EXT_16 ext16(IR1[15:0],ext16_out);
    S_EXT_16 sext16(IR1[15:0],sext16_out);
    S_EXT_18 sext18({IR1[15:0],2'b00},sext18_out);
    
    selector81 ALUamux(ext5_out,rs_out,NPC,hi_mux_out,lo_mux_out,32'b0,32'b0,32'b0,ALUaMux_control,aluamux_out);
    
    selector41 ALUbmux(rt_out,ext16_out,sext16_out,32'b0,ALUbMux_control,alubmux_out);
    

    HILO hilo_unit(clk,rst,Z2[63:32],Z2[31:0],HI_W,LO_W,hi_out,lo_out);
    
    selector41 RSmux(rs_to_mux,alu_out,ALUo1,ALUo2,rsoutMux,rs_out);
    selector41 RTmux(rt_to_mux,alu_out,ALUo1,ALUo2,rtoutMux,rt_out);
    selector41 HImux(hi_out,z[63:32],Z1[63:32],Z2[63:32],hioutMux,hi_mux_out);
    selector41 LOmux(lo_out,z[31:0],Z1[31:0],Z2[31:0],looutMux,lo_mux_out);
    
    
    
    //id-ex
    always @ (posedge clk or posedge rst) 
    begin
        if (rst==1 || (stall[1]==1 && stall[2]==0)) 
        begin
            id_ex_RF_W<=0;
            id_ex_aluc<=0;
            id_ex_DM_W<=0;
            id_ex_rdMux<=0;
            id_ex_rdcMux<=0;
            
            ALUa<=0;
            ALUb<=0;
            Rdata1<=0;
            IR2<=32'hffffffff;
        end
        else if (stall[1]==0) 
        begin
        id_ex_RF_W<=RF_W_control;
        id_ex_aluc<=ALUC_control;
        id_ex_DM_W<=DM_W_control;
        id_ex_rdMux<=rdMux_control;
        id_ex_rdcMux<=rdcMux_control;
        
        ALUa<=aluamux_out;
        ALUb<=alubmux_out;
        Rdata1<=rt_out;
        IR2<=IR1;
        pc2<=pc1;
        end
        else
        begin
        IR2<=32'h12345678;
        end
        
    end
    
    //ex
    alu alu_unit(ALUa,ALUb,id_ex_aluc,rst,alu_out,ex_me_Z,ex_me_C,ex_me_N,ex_me_O);
    MULT mult_unit(clk,rst,ALUa,ALUb,z);
    
    //ex-me
    always @ (posedge clk or posedge rst) 
    begin
        if (rst || (stall[2] && !stall[3])) 
        begin
            ex_me_RF_W<=0;
            ex_me_DM_W<=0;
            ex_me_rdMux<=0;
            ex_me_rdcMux<=0;
            
            Z1<=0;
            ALUo1<=0;
            Rdata2<=0;
            IR3<=32'hffffffff;
        end
        else if (!stall[2]) 
        begin
        /*对add，sub，addi三条指令的溢出（Overflow）情况做特殊处理（不写入）（改变RF_W）*/
        if((IR2[31:26]==6'b000000&&IR2[5:0]==6'b100000&&ex_me_O==1)||
        (IR2[31:26]==6'b000000&&IR2[5:0]==6'b100010&&ex_me_O==1)||
        (IR2[31:26]==6'b001000&&ex_me_O==1))
        begin
        ex_me_RF_W<=0;
        end
        else
        ex_me_RF_W<=id_ex_RF_W;
        
        
        
        ex_me_DM_W<=id_ex_DM_W;
        ex_me_rdMux<=id_ex_rdMux;
        ex_me_rdcMux<=id_ex_rdcMux;
        
        Z1<=z;
        ALUo1<=alu_out;
        Rdata2<=Rdata1;
        IR3<=IR2;
        pc3<=pc2;

        end
    end
    
    
    //me
    assign dmem_data_in=Rdata2;
    assign dmem_addr_in=ALUo1;
    assign dmem_DM_W=ex_me_DM_W;
    
    
    //me-wb
    always @ (posedge clk or posedge rst) 
    begin
        if (rst || (stall[3] && !stall[4])) 
        begin
            me_wb_RF_W<=0;
            me_wb_rdMux<=0;
            me_wb_rdcMux<=0;
            me_wb_Z<=0;
            me_wb_C<=0;
            me_wb_N<=0;
            me_wb_O<=0;
            
            Wdata<=0;
            Z2<=0;
            ALUo2<=0;
            IR4<=32'hffffffff;
        end
        else if (!stall[3]) 
        begin

        
        me_wb_RF_W<=ex_me_RF_W;
        me_wb_rdMux<=ex_me_rdMux;
        me_wb_rdcMux<=ex_me_rdcMux;
        me_wb_Z<=ex_me_Z;
        me_wb_C<=ex_me_C;
        me_wb_N<=ex_me_N;
        me_wb_O<=ex_me_O;
        
        Wdata<=dmem_out;
        Z2<=Z1;
        ALUo2<=ALUo1;
        IR4<=IR3;
        pc4<=pc3;

        end
    end
    
    
    //wb
    selector21 rdmux(ALUo2,Wdata,me_wb_rdMux,rdmux_out);
    selector41_5 rdcmux(IR4[15:11],IR4[20:16],5'b11111,5'b0,me_wb_rdcMux,rdcmux_out);
    
    
    
endmodule