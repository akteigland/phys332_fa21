`timescale 1ns / 1ps

module write_to_7seg(
    input CLK100MHZ,
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
    create_1KHZ slow (CLK100MHZ, CLK1KHZ);
    write_1234 writer(CLK1KHZ, CAs, AN);
        
endmodule

module write_1234(
    input CLK,
    output [6:0] CAs, // seven segments
    output reg [7:0] ANs // 8 displays
);
    
    reg [2:0] count; // 3 bits
    reg [3:0] display;
    seven_segment adapter(display, CAs);
    
    always @(posedge CLK) begin
        if (count == 3'b000) begin
            ANs <= 8'b1111_0111; // thousands digit
            display <= 1;
        end else if (count == 3'b001) begin
            ANs <= 8'b1111_1011; // hundreds digit
            display <= 2;
        end else if (count == 3'b010) begin
            ANs <= 8'b1111_1101; // tens digit
            display <= 3;
        end else if (count == 3'b011) begin
            ANs <= 8'b1111_1110; // ones digit
            display <= 4;
        end else begin // turn all off for 4-7 (dims)
            ANs <= 8'b1111_1111; // turn off entire display
        end
        
        // update count
        if (count == 3'b111) begin
            count <= 3'b000;
        end else begin
            count <= count + 3'b001;
        end
    end
    
endmodule
