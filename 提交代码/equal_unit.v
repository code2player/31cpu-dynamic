module equal_unit(
input [31:0] a,
input [31:0] b,
output c
    );
    assign c=(a==b)?1:0;
endmodule
