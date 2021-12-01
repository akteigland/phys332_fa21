`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module seven_segment(
    input [3:0] in, // a 4 bit number, allows for 0 to 15
    output [6:0] segment // 7 segments
);

    wire zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, tweleve, thirteen, fourteen, fifteen;
    
    assign zero = ~in[3] & ~in[2] & ~in[1] & ~in[0]; // 0000
    assign one = ~in[3] & ~in[2] & ~in[1] & in[0];   // 0001
    assign two = ~in[3] & ~in[2] & in[1] & ~in[0];   // 0010
    assign three = ~in[3] & ~in[2] & in[1] & in[0];  // 0011
    assign four = ~in[3] & in[2] & ~in[1] & ~in[0];  // 0100
    assign five = ~in[3] & in[2] & ~in[1] & in[0];   // 0101
    assign six = ~in[3] & in[2] & in[1] & ~in[0];    // 0110
    assign seven = ~in[3] & in[2] & in[1] & in[0];   // 0111
    assign eight = in[3] & ~in[2] & ~in[1] & ~in[0]; // 1000
    assign nine = in[3] & ~in[2] & ~in[1] & in[0];   // 1001
    assign ten = in[3] & ~in[2] & in[1] & ~in[0];    // 1010
    assign eleven = in[3] & ~in[2] & in[1] & in[0];  // 1011
    assign twelve = in[3] & in[2] & ~in[1] & ~in[0]; // 1100
    assign thirteen = in[3] & in[2] & ~in[1] & in[0];// 1101
    assign fourteen = in[3] & in[2] & in[1] & ~in[0];// 1110
    assign fifteen = in[3] & in[2] & in[1] & in[0];  // 1111

    // TODO: work for 10-15 (a-f)
    assign segment[0] = zero | two | three | five | six | seven | eight | nine | ten | fourteen | fifteen;
    assign segment[1] = zero | one | two | three | four | seven | eight | nine | ten | thirteen;
    assign segment[2] = zero | one | three | four | five | six | seven | eight | nine | ten | eleven | thirteen;
    assign segment[3] = zero | two | three | five | six | eight | eleven | twelve | thirteen | fourteen;
    assign segment[4] = zero | two | six | eight | ten | eleven | twelve | thirteen | fourteen | fifteen;
    assign segment[5] = zero | four | five | six | eight | nine | ten | eleven | fourteen | fifteen;
    assign segment[6] = two | three | four | five | six | eight | nine | ten | eleven | twelve | thirteen | fourteen | fifteen;
endmodule
