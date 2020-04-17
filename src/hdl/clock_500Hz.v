`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2020 04:52:11 PM
// Design Name: 
// Module Name: clock_500Hz
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


module clock_500Hz(
input clk_in,enable,reset,
output reg clk_out
);

integer count_500Hz = 0;

always @(posedge clk_in) begin

     if (reset) begin
        clk_out <= 0;
        count_500Hz <= 0;
     end

      if (enable) begin
               if (count_500Hz == 5000) begin
                   clk_out <= ~clk_out;
                   count_500Hz <= 0;
               end
               else
                   count_500Hz <= count_500Hz + 1;
           end
      end
endmodule
