`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2020 01:56:26 PM
// Design Name: 
// Module Name: CLK1HZ
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


module CLK1HZ(
    input clk_in,
    input enable,
    input reset,
    output reg clk_out
    );
    
    integer count_1Hz = 0;
    
    always @(posedge clk_in) begin
    
         if (reset) begin
            clk_out <= 0;
            count_1Hz <= 0;
         end
         
         if (enable) begin
                   if (count_1Hz == 250000) begin
                       clk_out <= ~clk_out;
                       count_1Hz <= 0;
                   end
                   else
                       count_1Hz <= count_1Hz + 1;
               end
    end
endmodule
