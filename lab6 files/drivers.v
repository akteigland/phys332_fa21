`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module four_adder_display (
    input [7:0] SW, // 8 switches
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG,
    output [7:0] AN
);

    // flip wires for active low
    wire a,b,c,d,e,f,g;
    assign CA = ~a;
    assign CB = ~b;
    assign CC = ~c;
    assign CD = ~d;
    assign CE = ~e;
    assign CF = ~f;
    assign CG = ~g;

    // connect inputs to adder
    wire [4:0] sum;
    four_bit_adder adder(.a(SW[3:0]),.b(SW[7:4]),.sum(sum));

    // do math to get the ones place
    wire [3:0] ones;
    assign ones = sum % 4'b1010; // sum mod 10 = ones digit

   assign AN[0] = 0; // set anode to ground (active low)
   assign AN[7:1] = {7{1'b1}}; // set the rest of the displays off

    seven_segment display_ones(ones,a,b,c,d,e,f,g);

endmodule

module seven_segment_driver (
    input [3:0] SW, // 4 switches
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG,
    output [7:0] AN // using first display
);

    assign AN[0] = 0; // set anode to ground (active low)
    assign AN[7:1] = {7{1'b1}}; // set the rest of the displays off

    wire a,b,c,d,e,f,g;

    assign CA = ~a;
    assign CB = ~b;
    assign CC = ~c;
    assign CD = ~d;
    assign CE = ~e;
    assign CF = ~f;
    assign CG = ~g;
    seven_segment display(.in(SW),.a(a),.b(b),.c(c),.d(d),.e(e),.f(f),.g(g));

endmodule
module four_bit_adder_driver (
    input [7:0] SW, // 8 switches
    output [4:0] LED // 5 leds
);
    // connect to adders
    four_bit_adder adder(.a(SW[3:0]),.b(SW[7:4]),.sum(LED));
endmodule

module full_adder_driver(
    input [2:0] SW,
    output [1:0] LED
);

    wire a, b, cin, cout, sum;
    // global inputs
    assign a = SW[0];
    assign b = SW[1];
    assign cin = SW[2];

    // global outputs
    assign LED[0] = sum;
    assign LED[1] = cout;

    full_adder add0(a, b, cin, cout, sum);

endmodule 

