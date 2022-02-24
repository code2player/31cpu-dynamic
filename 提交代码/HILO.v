module HILO(
input clk,
input rst,
input [31:0]hi_in,
input [31:0]lo_in,
input hi_w,
input lo_w,
output [31:0]hi_out,
output [31:0]lo_out
    );
    reg [31:0]hi;
    reg [31:0]lo;
    
    assign hi_out=hi;
    assign lo_out=lo;
    
    always @(negedge clk or posedge rst)
    begin
    if(rst==1'b1)
    begin
    hi<=32'b0;
    lo<=32'b0;
    end
    else
    begin
        if(hi_w==1)
        begin
        hi<=hi_in;
        end
        else
        begin
        end
        
        if(lo_w==1)
        begin
        lo<=lo_in;
        end
        else
        begin
        end
        
    end
    
    
    end
    
endmodule
