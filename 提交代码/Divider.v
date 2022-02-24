module Divider(
input I_CLK,
input rst,
output reg O_CLK
    );
    
    parameter MAX_HZ=100000;
    
    reg [64:0]i=0;
    initial
    begin
    O_CLK<=0;
    end
    
    always @( posedge I_CLK or posedge rst)
    begin
    
    if(rst==1)
    begin
    i<=0;
    O_CLK<=0;
    end
    
    else if(i==MAX_HZ-1)
    begin
    i<=0;
    O_CLK<=~O_CLK;   
    end
       
    else
    begin
    i<=i+1;
    end

    end

endmodule
