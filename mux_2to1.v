`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module mux_2to1 (
    input [31:0] in0,
    input [31:0] in1,
    input  sel,
    output reg [31:0] out
);

    always @ (*) begin
        if (sel) 
            out = in1;
        else 
            out = in0;
        
    end
    
endmodule
