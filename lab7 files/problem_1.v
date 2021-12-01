`timescale 1ns / 1ps

module blink_LEDs(
     input CLK100MHZ,
     output [2:1] JC,
     output [1:0] LED
);

    assign JC = LED;
    wire CLK1HZ, CLK1KHZ;
    create_1KHZ slow (CLK100MHZ, CLK1KHZ);
    create_1HZ slower (CLK100MHZ, CLK1HZ);
    
    blink_2on_1off seconds(CLK1HZ, LED[0]);
    blink_1on_2off millis(CLK1KHZ, LED[1]);

endmodule

module blink_1on_2off(
    input CLK,
    output [0:0] LED
);

    reg[1:0] count;
    
    assign LED[0] = ~count[0] & ~count[1]; // only on at 00
    always @ (posedge CLK) begin        
        // go 0, 1, 2, 0... || 00, 01, 10, 00...
        if (count == 2'b10) begin 
            count <= 2'b00;
        end else begin
            count <= count + 2'b01;
        end
    end
 
endmodule

module blink_2on_1off(
    input CLK,
    output [0:0] LED
 );
 
    reg[1:0] count;
    
    assign LED[0] = count[0] | count[1]; // only off at 00 
    always @ (posedge CLK) begin        
        // go 0, 1, 2, 0... || 00, 01, 10, 00...
        if (count == 2'b10) begin 
            count <= 2'b00;
        end else begin
            count <= count + 2'b01;
        end
    end
 
endmodule

module create_1HZ(
    input CLK_100MHZ,
    output reg CLK_1HZ
);
    
    // creates 1HZ clock from a 100MHZ clock
    // 1HZ clock has a period of 1 second = 1000ms
    // 100MHz is 100,000,000 cycles
    // log2(10,0000,000) = 26.6, so 27 bits needed for counter
    reg[26:0] ctr;
    
    always @ (posedge CLK_100MHZ) begin
        if (ctr == 49_999_999) begin
            CLK_1HZ <= 1'b1;
            ctr <= ctr + 1;            
        end
        else if (ctr == 99_999_999) begin
            CLK_1HZ <= 1'b0;
            ctr <= 0;
        end
        else begin
            ctr <= ctr + 1;
        end
    end
endmodule


module create_1KHZ(
    input CLK_100MHZ,
    output reg CLK_1KHZ
);

    // 100MHZ -> 1MHZ = /100, 1MHZ -> 1KHZ = /1000, so 100MHZ -> 1KHZ is 100,000 cycle period
    // log(100000) = 16.6, so 17 bits needed
    reg[16:0] count;
    
    always @(posedge CLK_100MHZ) begin
        if (count == 49999) begin
            CLK_1KHZ <= 1'b1;
            count <= count + 1;
        end else if (count == 99999) begin
            CLK_1KHZ <= 1'b0;
            count <= 0;
        end else begin
            count <= count + 1;
        end
    end
endmodule
