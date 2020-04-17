`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2020 01:43:38 PM
// Design Name: 
// Module Name: Egg_Timer_TB
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


module Egg_Timer_TB();
reg clk,reset,enable,start,cook_time,minutes,seconds;
reg [2:0] x;
wire [2:0] m_tens,s_tens,m_tens_Down,s_tens_Down,z,load2_temp,load4_temp;
wire [3:0] m_ones,s_ones,m_ones_Down,s_ones_Down,load1_temp,load3_temp;
wire timer_enabled,timer_on;
wire minutes_out,seconds_out;
wire out_1,out_2,out_3;
wire [13:0] stream;
wire speaker;
Egg_Timer DUT (
    //inputs
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .start(start),
    .cook_time(cook_time),
    .minutes(minutes),
    .seconds(seconds),
    //outputs
    .out_1(out_1),.out_2(out_2),.out_3(out_3),
    .stream(stream),
    .speaker(speaker),
    .minutes_out(minutes_out),
    .seconds_out(seconds_out),
    .m_tens(m_tens),
    .s_tens(s_tens),
    .m_ones(m_ones),
    .s_ones(s_ones),
    .load1_temp(load1_temp),
    .load2_temp(load2_temp),
    .load3_temp(load3_temp),
    .load4_temp(load4_temp),
    .m_tens_Down(m_tens_Down),
    .s_tens_Down(s_tens_Down),
    .m_ones_Down(m_ones_Down),
    .s_ones_Down(s_ones_Down),
    .z(z),
    .timer_enabled(timer_enabled),
    .timer_on(timer_on)
);

//System Startup
initial begin 
clk=0;
reset=1; 
enable=0;
start=0;
cook_time=0;
minutes=0;
seconds=0;
x=3'b010;
end

always #20 clk=~clk;

//Setting Cook Time

always @ (reset) begin 
        // Move to Count up State
        if(reset) begin 
        #100;
        reset = 0;
        enable = 1;
        cook_time = 1; // wait up
        #60;
        start = 0; // count up
        #60;
        end
         
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
           #40;
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
           #40;
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
           #200; 
           cook_time=0; // Move to Wait Down and Load
           #200; 
           start=1; 
 end
 


endmodule
