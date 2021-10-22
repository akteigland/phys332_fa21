`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module seven_segment(
    input [3:0] in, // a 4 bit number 
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g
);
    // TODO: work for 10-15 (a-f)
    assign a = in[1] | in[3] | (in[2] & in[0]) | (~in[2] & ~in[0]);
    assign b = in[3] | (~in[3] & ~in[2]) | (~in[1] & ~in[0]) | (in[1] & in[0]);
    assign c = in[3] | in[2] | ~in[1] | in[0];
    assign d = in[3] | (~in[2] & ~in[0]) | (~in[2] & in[1]) | (in[1] & ~in[0]) | (in[2] & ~in[1] & in[0]);
    assign e = (~in[2] & ~in[0]) | (in[1] & ~in[0]);
    assign f = in[3] | (~in[1] & ~in[0]) | (in[2] & ~in[1]) | (in[2] & ~in[0]);
    assign g = in[3] | (~in[2] & in[1]) | (in[2] & ~in[0]) | (in[2] & ~in[1]);
endmodule
