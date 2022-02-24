module EXT_5(
input [4:0]a,
output [31:0]b
);
assign b={{27{1'b0}},a};
endmodule

module EXT_16(
input [15:0]a,
output [31:0]b
);
assign b={{16{1'b0}},a};
endmodule

module S_EXT_16(
input [15:0]a,
output [31:0]b
);
assign b={{16{a[15]}},a};
endmodule

module S_EXT_18(
input [17:0]a,
output [31:0]b
);
assign b={{14{a[17]}},a};
endmodule



