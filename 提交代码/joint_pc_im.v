module joint_pc_im(
input [27:0] imem_in,
input [3:0] pc_in,
output [31:0] joint_out
    );
    
    assign joint_out={pc_in,imem_in};

endmodule
