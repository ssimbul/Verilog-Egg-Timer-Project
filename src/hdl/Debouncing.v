`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2020 02:29:02 PM
// Design Name: 
// Module Name: Debouncing
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

module DFlipFlopAsynchReset(
    input D,
    input clk,
    input asynch_reset,
    output reg Q
    );
    
    always @ (posedge clk or posedge asynch_reset)
    begin
        if (asynch_reset) Q <= 0; else Q <= D;
    end
    
endmodule

module Debouncing(
   input pb_1, // input push button signal
   input clk,
   output pb_out // output push button signal
    );
    
wire slow_clk_en; // wire that holds the low frequency clock enable signal (need slow clock for debouncing)
wire Q1, Q2, Q2_bar; // wires to hold output of the two D Flip Flops
    
clock_enable slowclken (clk, pb_1, slow_clk_en);
    
DFlipFlopAsynchReset D1(.clk(clk), .asynch_reset(slow_clk_en), .D(pb_1), .Q(Q1));
DFlipFlopAsynchReset D2(.clk(clk), .asynch_reset(slow_clk_en), .D(Q1), .Q(Q2));
    
 assign Q2_bar = ~Q2;
 assign pb_out = Q1 & Q2_bar;
 
 endmodule
    
module clock_enable (input clk,pb_1, output reg slow_clk_en);
    reg[26:0] counter = 0;
    reg count;
        always @ (posedge clk, negedge pb_1)
        begin
            if (pb_1 == 0)begin
                counter <= 0;
            end
            else begin
                count <= (counter >= 249999) ? 1'b1:1'b0;
            end
         slow_clk_en = (counter == 249999) ? 1'b1:1'b0;
        end
endmodule
