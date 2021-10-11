`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab5_b
//////////////////////////////////////////////////////////////////////////////////


module lab5_b(
    input [3:0] SW, //  4 input switches
    output [2:0] LED // 3 output LEDs
    );
    wire A0, A1, B0, B1;
    wire E, F, G;
    
    // A/B are inputs
    assign A0 = SW[0];
    assign A1 = SW[1];
    assign B0 = SW[2];
    assign B1 = SW[3];
    
    // led is e,g,f 
    assign LED[0] = E; // equal
    assign LED[1] = F; // A > B
    assign LED[2] = G; // A < B
    
    // logic for comparing
    assign E = (!A1 & !A0 & !B1 & !B0) | (A1 & !A0 & B1 & !B0) | (!A1 & A0 & !B1 & B0) | (A1 & A0 & B1 & B0);
    assign F = (A1 & !B1) | (A0 & !B1 & !B0) | (A1 & A0 & !B0);
    assign G = (!A1 & B1) | (!A1 & !A0 & B0) | (!A0 & B1 & B0);
endmodule
