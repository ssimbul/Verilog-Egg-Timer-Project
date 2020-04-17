`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 12:24:04 PM
// Design Name: 
// Module Name: rgb_led
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


module rgb_led(
 input choice_one, choice_two, choice_three,
   output out_r, out_g, out_b
    );
    
    assign out_r = choice_one; // 6 minutes: liquidy yolk and soft white
    assign out_g = choice_two; // 8 minutes: soft yolk but firm enough to hold its own
    assign out_b = choice_three; // 13 minutes: traditional hard boiled egg

endmodule
