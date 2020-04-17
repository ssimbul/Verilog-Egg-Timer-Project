`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2020 08:53:30 PM
// Design Name: 
// Module Name: FSM_DownCount_TB
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


module FSM_DownCount_TB();
 
reg clk,reset,enable,start,cook_time;
reg [3:0] load1,load3;
reg [2:0] load2,load4;
wire [2:0] m_tens_Down,s_tens_Down,z,load2_temp,load4_temp;
wire [3:0] m_ones_Down,s_ones_Down,load1_temp,load3_temp;
wire timer_enabled,timer_on;

Egg_Timer DUT (
    //inputs
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .start(start),
    .cook_time(cook_time),
    .load1(load1),
    .load2(load2),
    .load3(load3),
    .load4(load4),
    //outputs
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

  initial begin 
    clk=0; 
    reset=1;
    enable=0;
    start=0;
    cook_time=0;
    load1=4;
    load2=4;
    load3=4;
    load4=2;
    end
    
    
     always #10 clk=~clk;
       
       always @ (reset) begin 
           if(reset) begin 
           #100;
           reset = 0;
           enable=1;
           cook_time = 0; // wait down
           #60;
           start = 1; // count down
           #60;
           end
      end
          
endmodule
