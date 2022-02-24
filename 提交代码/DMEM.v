module DMEM(
input clk,
input ena,
input wena,//高电平写入有效，低电平读有效
input [10:0] addr,
input [31:0] data_in,
output reg [31:0] data_out
    );
    
    reg [31:0] memory [0:31];//reg数组,前面为位数，后面为数组元素个数
    
    always @(*)
    begin
     if(ena==0)
       data_out=32'hzzzzzzzz;
       else
       begin
       
       if(wena==1)//写有效
       begin
      // memory[addr]=data_in;
       end
       else//读有效
       begin
       data_out=memory[addr];
       end
       
       end
    
    
    
    end
    
    always @(posedge clk)
    begin
    if(ena==0)
    begin
    end
   // data_out=32'hzzzzzzzz;
    else
    begin
    
    if(wena==1)//写有效
    begin
    memory[addr]=data_in;
    end
    else//读有效
    begin
  //  data_out=memory[addr];
    end
    
    end
    
    end
    
    
    
endmodule

