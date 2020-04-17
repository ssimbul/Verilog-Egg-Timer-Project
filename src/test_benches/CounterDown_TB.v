`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2020 04:11:29 PM
// Design Name: 
// Module Name: CounterDown_TB
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


module CounterDown_TB();

reg clk, reset, enable, start, cook_time, minutes, seconds;

wire seconds_out_Down, minutes_out_Down;
wire[2:0] m_tens_Down, s_tens_Down;
wire[3:0] m_ones_Down, s_ones_Down;
Egg_Timer DUT(
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .start(start), 
    .m_tens_Down(m_tens_Down),
    .s_tens_Down(s_tens_Down),
    .m_ones_Down(m_ones_Down),
    .s_ones_Down(s_ones_Down)
);

initial begin 
    clk =0;
    reset=1;
    enable=1;
    start=0;
end

always #20 clk=~clk;

always begin 
    #20 reset=0;
    #50 start=1;
end
endmodule
