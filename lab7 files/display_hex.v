`timescale 1ns / 1ps

module display_hex(
    input CLK100MHZ,
    input [5:0] SW,
    output [7:0] AN,
    output CA,CB,CC,CD,CE,CF,CG,DP
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
    
    wire CLK1KHZ;
        
    // every second, add 1 to a binary number
    create_1HZ seconds(CLK100MHZ, CLK1HZ);
    
    // display binary number on display
    create_1KHZ slow (CLK100MHZ, CLK1KHZ);
    hex_writer writer(CLK1KHZ, SW, CAs, AN);
endmodule

module hex_writer(
    input CLK,
    input [5:0] SW,
    output [6:0] CAs, // seven segments
    output reg [7:0] ANs // 8 displays
);
    
    reg [2:0] count; // 3 bits
    reg [3:0] display;
    seven_segment adapter(display, CAs);
    
    always @(posedge CLK) begin        
        // loops through all displays
        if (count == 3'b000) begin
            ANs <= 8'b1111_1110; // ones digit
            display <= {SW[3], SW[2], SW[1], SW[0]};
        end else if (count == 3'b001) begin
            ANs <= 8'b1111_1101; // tens digit
            display <= {2'b00, SW[5], SW[4]};
        end else begin
            ANs <= 8'b1111_1111; // turn displays off
        end
        
        // update count
        if (count == 3'b111) begin
            count <= 3'b000;
        end else begin
            count <= count + 3'b001;
        end
    end
    
endmodule