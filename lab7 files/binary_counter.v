`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 12:36:46 PM
// Design Name: 
// Module Name: binary_writer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module display_driver(
    input CLK100MHZ,
    output [7:0] AN,
    output CA,CB,CC,CD,CE,CF,CG,DP,
    output [7:0] LED
);
    
    wire [6:0] CAs;
    assign CA = ~CAs[0];
    assign CB = ~CAs[1];
    assign CC = ~CAs[2];
    assign CD = ~CAs[3];
    assign CE = ~CAs[4];
    assign CF = ~CAs[5];
    assign CG = ~CAs[6];
    assign DP = 1;
    
    wire CLK1KHZ, CLK1HZ;
        
    // every second, add 1 to a binary number
    create_1HZ seconds(CLK100MHZ, CLK1HZ);
    reg [7:0] binary;
    always @(posedge CLK1HZ) begin
        binary <= binary + 1;
        // if you wanted to reset the counter at a certain number, you could do so here
        // as is, this will automatically overflow at 1111_1111 to go back to 0000_0000
    end
    
    // display binary number on display
    create_1KHZ slow (CLK100MHZ, CLK1KHZ);
    binary_writer writer(CLK1KHZ, binary, CAs, AN);
    
    // also show as LEDs
    assign LED = binary;
endmodule

module binary_writer(
    input CLK,
    input [7:0] to_display,
    output [6:0] CAs, // seven segments
    output reg [7:0] ANs // 8 displays
);
    
    reg [2:0] count; // 3 bits
    reg [3:0] display;
    seven_segment adapter(display, CAs);
    
    always @(posedge CLK) begin
    
        display <= {3'b000, to_display[count]};
        
        // loops through all displays
        if (count == 3'b000) begin
            ANs <= 8'b1111_1110; // ones digit
        end else if (count == 3'b001) begin
            ANs <= 8'b1111_1101; // tens digit
        end else if (count == 3'b010) begin
            ANs <= 8'b1111_1011; // hundreds digit
        end else if (count == 3'b011) begin
            ANs <= 8'b1111_0111; // thousands digit
        end else if (count == 3'b100) begin
            ANs <= 8'b1110_1111; // ten-thousands digit
        end else if (count == 3'b101) begin
            ANs <= 8'b1101_1111; // hundred-thousand digit
        end else if (count == 3'b110) begin
            ANs <= 8'b1011_1111; // millions digit
        end else begin
            ANs <= 8'b0111_1111; // ten millions digit                
        end
        
        // update count
        if (count == 3'b111) begin
            count <= 3'b000;
        end else begin
            count <= count + 3'b001;
        end
    end
    
endmodule