module Regfiles(
input clk,
input rst,
input rf_w,

input [4:0]raddr1,
input [4:0]raddr2,
input [4:0]waddr,
input [31:0]wdata,
output reg [31:0]rdata1,
output reg [31:0]rdata2,
output reg [31:0] outreg1,
output reg [31:0] outreg2
    );
    
     reg [31:0] array_reg [31:0];//reg数组,前面为位数，后面为数组元素个数
     
     always @(*)
     begin
     outreg1=array_reg[16];
     outreg2=array_reg[16];
     end

     
     always @(negedge clk or posedge rst)
     begin
     if(rst==1'b1)
     begin
     array_reg[0]=32'b0;
     array_reg[1]=32'b0;
     array_reg[2]=32'b0;
     array_reg[3]=32'b0;
     array_reg[4]=32'b0;
     array_reg[5]=32'b0;
     array_reg[6]=32'b0;
     array_reg[7]=32'b0;
     array_reg[8]=32'b0;
     array_reg[9]=32'b0;
     array_reg[10]=32'b0;
     array_reg[11]=32'b0;
     array_reg[12]=32'b0;
     array_reg[13]=32'b0;
     array_reg[14]=32'b0;
     array_reg[15]=32'b0;
     array_reg[16]=32'b0;
     array_reg[17]=32'b0;
     array_reg[18]=32'b0;
     array_reg[19]=32'b0;
     array_reg[20]=32'b0;
     array_reg[21]=32'b0;
     array_reg[22]=32'b0;
     array_reg[23]=32'b0;
     array_reg[24]=32'b0;
     array_reg[25]=32'b0;
     array_reg[26]=32'b0;
     array_reg[27]=32'b0;
     array_reg[28]=32'b0;
     array_reg[29]=32'b0;
     array_reg[30]=32'b0;
     array_reg[31]=32'b0;
     
     
     end
     else
     begin
        if(rf_w==1)
        begin
        if (waddr == 0)
        array_reg[0] = 0;
        else if (waddr == 1)
        array_reg[1] = wdata;
        else if (waddr == 2)
        array_reg[2] = wdata;
        else if (waddr == 3)
        array_reg[3] = wdata;
        else if (waddr == 4)
        array_reg[4] = wdata;
        else if (waddr == 5)
        array_reg[5] = wdata;
        else if (waddr == 6)
        array_reg[6] = wdata;
        else if (waddr == 7)
        array_reg[7] = wdata;
        else if (waddr == 8)
        array_reg[8] = wdata;
        else if (waddr == 9)
        array_reg[9] = wdata;
        else if (waddr == 10)
        array_reg[10] = wdata;
        else if (waddr == 11)
        array_reg[11] = wdata;
        else if (waddr == 12)
        array_reg[12] = wdata;
        else if (waddr == 13)
        array_reg[13] = wdata;
        else if (waddr == 14)
        array_reg[14] = wdata;
        else if (waddr == 15)
        array_reg[15] = wdata;
        else if (waddr == 16)
        array_reg[16] = wdata;
        else if (waddr == 17)
        array_reg[17] = wdata;
        else if (waddr == 18)
        array_reg[18] = wdata;
        else if (waddr == 19)
        array_reg[19] = wdata;
        else if (waddr == 20)
        array_reg[20] = wdata;
        else if (waddr == 21)
        array_reg[21] = wdata;
        else if (waddr == 22)
        array_reg[22] = wdata;
        else if (waddr == 23)
        array_reg[23] = wdata;
        else if (waddr == 24)
        array_reg[24] = wdata;
        else if (waddr == 25)
        array_reg[25] = wdata;
        else if (waddr == 26)
        array_reg[26] = wdata;
        else if (waddr == 27)
        array_reg[27] = wdata;
        else if (waddr == 28)
        array_reg[28] = wdata;
        else if (waddr == 29)
        array_reg[29] = wdata;
        else if (waddr == 30)
        array_reg[30] = wdata;
        else if (waddr == 31)
        array_reg[31] = wdata;
        else
        begin
        
        end
            
        end
        else//rf_w==0
        begin
        
        end
     


     
     
     end
     end
     
     always @(*)
     begin
     if(raddr1==0)
     rdata1=array_reg[0];
     else if(raddr1==1)
     rdata1=array_reg[1];
     else if(raddr1==2)
     rdata1=array_reg[2];
     else if(raddr1==3)
     rdata1=array_reg[3];
     else if(raddr1==4)
     rdata1=array_reg[4];
     else if(raddr1==5)
     rdata1=array_reg[5];
     else if(raddr1==6)
     rdata1=array_reg[6];
     else if(raddr1==7)
     rdata1=array_reg[7];
     else if(raddr1==8)
     rdata1=array_reg[8];
     else if(raddr1==9)
     rdata1=array_reg[9];
     else if(raddr1==10)
     rdata1=array_reg[10];
     else if(raddr1==11)
     rdata1=array_reg[11];
     else if(raddr1==12)
     rdata1=array_reg[12];
     else if(raddr1==13)
     rdata1=array_reg[13];
     else if(raddr1==14)
     rdata1=array_reg[14];
     else if(raddr1==15)
     rdata1=array_reg[15];
     else if(raddr1==16)
     rdata1=array_reg[16];
     else if(raddr1==17)
     rdata1=array_reg[17];
     else if(raddr1==18)
     rdata1=array_reg[18];
     else if(raddr1==19)
     rdata1=array_reg[19];
     else if(raddr1==20)
     rdata1=array_reg[20];
     else if(raddr1==21)
     rdata1=array_reg[21];
     else if(raddr1==22)
     rdata1=array_reg[22];
     else if(raddr1==23)
     rdata1=array_reg[23];
     else if(raddr1==24)
     rdata1=array_reg[24];
     else if(raddr1==25)
     rdata1=array_reg[25];
     else if(raddr1==26)
     rdata1=array_reg[26];
     else if(raddr1==27)
     rdata1=array_reg[27];
     else if(raddr1==28)
     rdata1=array_reg[28];
     else if(raddr1==29)
     rdata1=array_reg[29];
     else if(raddr1==30)
     rdata1=array_reg[30];
     else if(raddr1==31)
     rdata1=array_reg[31];
     else
     begin
     
     end
     
     if(raddr2==0)
     rdata2=array_reg[0];
     else if(raddr2==1)
     rdata2=array_reg[1];
     else if(raddr2==2)
     rdata2=array_reg[2];
     else if(raddr2==3)
     rdata2=array_reg[3];
     else if(raddr2==4)
     rdata2=array_reg[4];
     else if(raddr2==5)
     rdata2=array_reg[5];
     else if(raddr2==6)
     rdata2=array_reg[6];
     else if(raddr2==7)
     rdata2=array_reg[7];
     else if(raddr2==8)
     rdata2=array_reg[8];
     else if(raddr2==9)
     rdata2=array_reg[9];
     else if(raddr2==10)
     rdata2=array_reg[10];
     else if(raddr2==11)
     rdata2=array_reg[11];
     else if(raddr2==12)
     rdata2=array_reg[12];
     else if(raddr2==13)
     rdata2=array_reg[13];
     else if(raddr2==14)
     rdata2=array_reg[14];
     else if(raddr2==15)
     rdata2=array_reg[15];
     else if(raddr2==16)
     rdata2=array_reg[16];
     else if(raddr2==17)
     rdata2=array_reg[17];
     else if(raddr2==18)
     rdata2=array_reg[18];
     else if(raddr2==19)
     rdata2=array_reg[19];
     else if(raddr2==20)
     rdata2=array_reg[20];
     else if(raddr2==21)
     rdata2=array_reg[21];
     else if(raddr2==22)
     rdata2=array_reg[22];
     else if(raddr2==23)
     rdata2=array_reg[23];
     else if(raddr2==24)
     rdata2=array_reg[24];
     else if(raddr2==25)
     rdata2=array_reg[25];
     else if(raddr2==26)
     rdata2=array_reg[26];
     else if(raddr2==27)
     rdata2=array_reg[27];
     else if(raddr2==28)
     rdata2=array_reg[28];
     else if(raddr2==29)
     rdata2=array_reg[29];
     else if(raddr2==30)
     rdata2=array_reg[30];
     else if(raddr2==31)
     rdata2=array_reg[31];
     else
     begin
     
     end

     end

endmodule
