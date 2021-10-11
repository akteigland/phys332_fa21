`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab5
//////////////////////////////////////////////////////////////////////////////////


module lab5(
    input [3:0] SW,
     output [2:0] LED, 
     output LED17_B, 
     output LED17_G, 
     output LED17_R
    );
    
    // Step 4, assign LEDs to switches
    assign LED[0] = SW[0];
    assign LED[1] = SW[1];
    assign LED[2] = SW[2] & SW[3];
    
    // Step 5/6 assign RGB LED to switches
    assign LED17_R = SW[1] & SW[0];
    assign LED17_G = SW[2] & SW[0];
    assign LED17_B = SW[3] & SW[0];

endmodule
