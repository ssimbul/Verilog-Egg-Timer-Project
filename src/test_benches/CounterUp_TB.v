`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2020 02:02:06 PM
// Design Name: 
// Module Name: CounterUp_TB
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


module CounterUp_TB();

reg clk,reset,enable,cook_time,minutes,seconds;

wire minutes_out,seconds_out;
wire [2:0] m_tens,s_tens;
wire [3:0] s_ones,m_ones;


Egg_Timer DUT(
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .cook_time(cook_time),
    .minutes(minutes),
    .seconds(seconds),
    .minutes_out(minutes_out),
    .seconds_out(seconds_out),
    .m_tens(m_tens),
    .s_tens(s_tens),
    .m_ones(m_ones),
    .s_ones(s_ones)
);

initial begin 
    clk =0;
    reset=1;
    enable=1;
    cook_time=0;
    minutes=0;
    seconds=0;
end

always #20 clk=~clk;

always begin 
    #20 reset=0;
    #20 cook_time=1; 
    seconds=1;
    minutes=1;
    #100;
    seconds=0;
    minutes=0;
    #40;
    seconds=1;
    minutes=1;
    #100;
    seconds=0;
    minutes=0;
end

endmodule
