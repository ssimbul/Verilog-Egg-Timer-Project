`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2020 07:59:13 PM
// Design Name: 
// Module Name: FSM_UpCount_TB
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


module FSM_UpCount_TB();

reg clk,reset,enable,start,cook_time,minutes,seconds;
wire seconds_out,minutes_out;
wire [2:0] m_tens,s_tens,z;
wire [3:0] m_ones,s_ones;
wire time_enabled;
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
    .seconds_out(seconds_out),
    .minutes_out(minutes_out),
    .m_tens(m_tens),
    .s_tens(s_tens),
    .m_ones(m_ones),
    .s_ones(s_ones),
    .z(z),
    .timer_enabled(timer_enabled)
    );
       
    initial begin 
    clk=0; 
    reset=1;
    enable=0;
    start=0;
    cook_time=0;
    minutes=1;
    seconds=1;

    end
    
    always #10 clk=~clk;
    
    always @ (reset) begin 
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
    end
    
    always begin 
        #40;
            seconds=1;
            minutes=1;
            #100;
            seconds=0;
            minutes=0;
    end
    
  
endmodule
