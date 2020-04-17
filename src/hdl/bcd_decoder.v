`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2020 03:21:49 PM
// Design Name: 
// Module Name: bcd_decoder
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


module bcd_decoder(
   input [3:0] x,
   output reg[7:0] seg
    );
       
    always @(x)
    begin
        case (x)
            4'b0000: seg = 8'b01000000;
            4'b0001: seg = 8'b01111001;
            4'b0010: seg = 8'b00100100;
            4'b0011: seg = 8'b00110000;
            4'b0100: seg = 8'b00011001;
            4'b0101: seg = 8'b00010010;
            4'b0110: seg = 8'b00000010;
            4'b0111: seg = 8'b01111000;
            4'b1000: seg = 8'b00000000;
            4'b1001: seg = 8'b00010000;
            default: seg = 0;
        endcase 
    end  
endmodule
