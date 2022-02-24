module IMEM(
input [10:0]addr,
output [31:0]instr
    );
    
    imem_ip im(.a(addr),.spo(instr));
endmodule