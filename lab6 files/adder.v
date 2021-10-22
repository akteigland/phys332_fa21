`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module four_bit_adder (
    input [3:0] a, // first four bit number
    input [3:0] b, // second four bit number
    output [4:0] sum // final output where sum[4] is cout
);
    // wires to connect to adders
    wire carry0, carry1, carry2;
 
    // connect to adders
    full_adder add0(a[0], b[0], 0, carry0, sum[0]); // Note: c_in is set to ground
    full_adder add1(a[1], b[1], carry0, carry1, sum[1]);
    full_adder add2(a[2], b[2], carry1, carry2, sum[2]);
    full_adder add3(a[3], b[3], carry2, sum[4], sum[3]);
endmodule

module full_adder(
    input a,
    input b,
    input c_in,
    output c_out,
    output s
    );
    
    assign c_out = (a & b) | (a & c_in) | (b & c_in);
    assign s = (~a & ~b & c_in) | (~a & b & ~c_in) | (a & b & c_in) | (a & ~b & ~c_in);

endmodule
