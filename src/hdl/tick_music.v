`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 02:54:30 PM
// Design Name: 
// Module Name: tick_music
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


module tick_music(
input clk,
input enable,
input reset,
output reg clk_out
    );
    integer count =0;
    always @ (posedge clk) begin
    if (reset) begin
                clk_out <= 0;
                count <=0;
             end
             
             if (enable) begin
                       if (count == 12500) begin
                           clk_out <= ~clk_out;
                           count <= 0;
                       end
                       else
                           count <= count + 1;
                   end
      end
endmodule
