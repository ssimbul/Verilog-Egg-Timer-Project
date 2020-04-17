`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2020 01:43:36 PM
// Design Name: 
// Module Name: Egg_Timer
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


module Egg_Timer(
    input clk,
    input reset,
    input enable,
    input start,
    input cook_time,
    input minutes,
    input seconds,
    output out_1,out_2,out_3, 
    output reg [13:0] stream = 0, 
    output reg speaker,
    output reg timer_enabled,
    output reg timer_on,
    output reg [7:0] an,
    output reg [7:0] seg
    );
    reg isUpCount;
    reg isDownCount;
    reg load;
    reg [2:0] z; 

    /*UP COUNTER*/
    wire clk_5MHz, clk_1Hz,clk_500Hz;
    clk_5Mhz CLK5MHz(.clk_out(clk_5MHz),.clk_in(clk));     
    CLK1HZ clk1hz (.clk_in(clk5MHz),.enable(enable),.reset(reset),.clk_out(clk_1Hz));
    clock_500Hz clk500hz (.clk_in(clk5MHz),.enable(enable),.reset(reset),.clk_out(clk_500Hz));
    wire thresh1,thresh2,tresh3;
    
    wire [2:0] m_tens;
    wire [2:0] s_tens;
    wire[3:0] m_ones;
    wire[3:0] s_ones;
    wire seconds_out, minutes_out;
    Debouncing debouncedSeconds (.pb_1(seconds), .clk(clk_5MHz), .pb_out(seconds_out));
    Debouncing debouncedMinutes (.pb_1(minutes), .clk(clk_5MHz), .pb_out(minutes_out));
        
    counter_9 SecOnes(.CLK(clk_1Hz),.CE(seconds_out & cook_time & isUpCount ),.SCLR(reset),.THRESH0(thresh1),.Q(s_ones));
    Debouncing debouncedthresh (.pb_1(thresh1), .clk(clk_5MHz), .pb_out(thresh_out));
    counter_5 SecTens (.CLK(clk_1Hz),.CE(thresh_out),.SCLR(reset),.THRESH0(thresh2),.Q(s_tens));
         
    counter_9 MinOnes(.CLK(clk_1Hz),.CE(minutes_out & cook_time),.SCLR(reset),.THRESH0(thresh3),.Q(m_ones));  
    Debouncing debouncedthresh2 (.pb_1(thresh3), .clk(clk_5MHz), .pb_out(thresh_out2)); 
    counter_5 MinTens (.CLK(clk_1Hz),.CE(thresh_out2),.SCLR(reset),.THRESH0(thresh4),.Q(m_tens));
   
    /*DOWN COUNTER*/
    wire threshDown1, threshDown2, threshDown3, threshDown4; // Threshold Outputs of the Counter IPs
    wire [3:0] s_onesDown, m_onesDown; // Hold output of Counters
    wire [2:0]s_tensDown, m_tensDown; // Hold output of Counters

    // Temporary Registers to hold Current User Defined Cook Time Value
    reg[3:0] load1_temp;
    reg[3:0] load3_temp;
    reg[2:0] load2_temp;
    reg[2:0] load4_temp;

    // Preset Load Values that will convert the User Defined Cook Time Value to the 
    // correct time. 
    always @(*) begin 
        case (s_ones)
            4'd0:  load1_temp = 4'd9;
            4'd1:  load1_temp = 4'd8;
            4'd2:  load1_temp = 4'd7;
            4'd3:  load1_temp = 4'd6;
            4'd4:  load1_temp = 4'd5;
            4'd5:  load1_temp = 4'd4;
            4'd6:  load1_temp = 4'd3;
            4'd7:  load1_temp = 4'd2;
            4'd8:  load1_temp = 4'd1;
            4'd9:  load1_temp = 4'd0;
       endcase
           
       case (m_ones)
            4'd0:  load3_temp = 4'd9;
            4'd1:  load3_temp = 4'd8;
            4'd2:  load3_temp = 4'd7;
            4'd3:  load3_temp = 4'd6;
            4'd4:  load3_temp = 4'd5;
            4'd5:  load3_temp = 4'd4;
            4'd6:  load3_temp = 4'd3;
            4'd7:  load3_temp = 4'd2;
            4'd8:  load3_temp = 4'd1;
            4'd9:  load3_temp = 4'd0;
       endcase
       
       case (s_tens)
            4'd0:  load2_temp = 4'd5;
            4'd1:  load2_temp = 4'd4;
            4'd2:  load2_temp = 4'd3;
            4'd3:  load2_temp = 4'd2;
            4'd4:  load2_temp = 4'd1;
            4'd5:  load2_temp = 4'd0;
       endcase  
          
       case (m_tens)
            4'd0:  load4_temp = 4'd5;
            4'd1:  load4_temp = 4'd4;
            4'd2:  load4_temp = 4'd3;
            4'd3:  load4_temp = 4'd2;
            4'd4:  load4_temp = 4'd1;
            4'd5:  load4_temp = 4'd0;
       endcase     
    end   

    /*Cooking Mode Indication using RGB LED*/
    reg choice_one, choice_two, choice_three; // Each one corresponds to a different colour in the RGB LED
    rgb_led RGB (.choice_one(choice_one), .choice_two(choice_two), .choice_three(choice_three),.out_r(out_3),.out_g(out_2),.out_b(out_1));

    always @(*) begin
        if (m_tens == 1 && m_ones == 3) begin // Classic Hard Boiled Egg
            choice_one=1;
            choice_two=0;
            choice_three=0;
        end   
        else if (m_tens == 0 && m_ones == 8) begin // Medium Boiled Egg
            choice_one=1;
            choice_two=1;
            choice_three=0;
        end
        else if (m_tens == 0 && m_ones == 6) begin // Runny Yolk Egg
            choice_one=0;
            choice_two=1;
            choice_three=0;
        end
    end
  
  // Registers to hold Down Counter values
  reg [2:0] m_tens_Down;
  reg [2:0] s_tens_Down;
  reg [3:0] m_ones_Down;
  reg [3:0] s_ones_Down;

    counter_9_down Down_SecOnes (.CLK(clk_1Hz),.CE((start & isDownCount)| load),.SCLR(reset),.LOAD(load),.L(load1_temp),.THRESH0(threshDown1),.Q(s_onesDown));
    counter_5_down Down_SecTens (.CLK(clk_1Hz),.CE(threshDown1 | load),.SCLR(reset),.LOAD(load),.L(load2_temp),.THRESH0(threshDown2),.Q(s_tensDown));
    wire downMinOnesEN = threshDown1 & threshDown2;
    counter_9_down Down_MinOnes (.CLK(clk_1Hz),.CE(downMinOnesEN | load),.SCLR(reset),.LOAD(load),.L(load3_temp),.THRESH0(threshDown3),.Q(m_onesDown));
    wire downMinTensEN = downMinOnesEN & threshDown3;
    counter_5_down Down_MinTens (.CLK(clk_1Hz),.CE(downMinTensEN | load),.SCLR(reset),.LOAD(load),.L(load4_temp),.THRESH0(threshDown4),.Q(m_tensDown));

    wire doneCountDown = threshDown1 & threshDown2 & threshDown3 & threshDown4; // flag to indicate that Count Time is complete

    //  gray code always procedure to make up counter behave as a down counter
    always @(*) begin 
    if (load == 0 & isDownCount) begin
        case (s_onesDown)
            4'd0:  s_ones_Down = 4'd9;
            4'd1:  s_ones_Down = 4'd8;
            4'd2:  s_ones_Down = 4'd7;
            4'd3:  s_ones_Down = 4'd6;
            4'd4:  s_ones_Down = 4'd5;
            4'd5:  s_ones_Down = 4'd4;
            4'd6:  s_ones_Down = 4'd3;
            4'd7:  s_ones_Down = 4'd2;
            4'd8:  s_ones_Down = 4'd1;
            4'd9:  s_ones_Down = 4'd0;
       endcase
           
       case (m_onesDown)
            4'd0:  m_ones_Down = 4'd9;
            4'd1:  m_ones_Down = 4'd8;
            4'd2:  m_ones_Down = 4'd7;
            4'd3:  m_ones_Down = 4'd6;
            4'd4:  m_ones_Down = 4'd5;
            4'd5:  m_ones_Down = 4'd4;
            4'd6:  m_ones_Down = 4'd3;
            4'd7:  m_ones_Down = 4'd2;
            4'd8:  m_ones_Down = 4'd1;
            4'd9:  m_ones_Down = 4'd0;
       endcase
       
       case (s_tensDown)
            4'd0:  s_tens_Down = 4'd5;
            4'd1:  s_tens_Down = 4'd4;
            4'd2:  s_tens_Down = 4'd3;
            4'd3:  s_tens_Down = 4'd2;
            4'd4:  s_tens_Down = 4'd1;
            4'd5:  s_tens_Down = 4'd0;
       endcase  
          
       case (m_tensDown)
            4'd0:  m_tens_Down = 4'd5;
            4'd1:  m_tens_Down = 4'd4;
            4'd2:  m_tens_Down = 4'd3;
            4'd3:  m_tens_Down = 4'd2;
            4'd4:  m_tens_Down = 4'd1;
            4'd5:  m_tens_Down = 4'd0;
       endcase    
    end       
    end   

/* FSM Block */
// State Registers
reg[2:0] state, nxt_st;
// FSM States
parameter ready = 0, wait_up = 1, wait_down = 2, count_up = 3, count_down = 4; 
       
// Next-State Logic based of group's State Graph
always @ (state or cook_time or reset or start or enable or doneCountDown) begin
case (state) 
    ready: begin
        if (enable & cook_time) nxt_st <= wait_up;
        else if (enable & ~cook_time) nxt_st <= wait_down; 
        else nxt_st <= ready;
    end
               
    wait_up: begin
        if (~start) nxt_st <= count_up; 
        else if(reset) nxt_st <= ready; 
        else nxt_st <=wait_up;
    end
               
    wait_down: begin
        if (start) nxt_st <= count_down; 
        else if(reset) nxt_st <= ready; 
        else nxt_st <= wait_down;
    end
               
    count_up: begin
        if (~cook_time) nxt_st <= wait_down; 
        else if (cook_time & ~start & enable) nxt_st <= count_up; 
        else nxt_st <= ready;
    end
               
    count_down: begin
        if (cook_time) nxt_st <= wait_up; 
        else if (cook_time & ~start & enable) nxt_st <= count_up; 
        else if(reset|doneCountDown) nxt_st <= ready;
    end
               
    default: nxt_st <= ready;
endcase
end
       
// Register Definition
always @ (posedge clk_5MHz or posedge reset) begin
    if (reset) state <= ready; 
    else state <= nxt_st;
end

// Registers to hold Time to show on Seven Segment Display
reg [3:0] M_ONES, S_ONES;
reg [2:0] M_TENS, S_TENS;  

// Output Logic
always @ (*) begin 
case (state) 
    ready: begin
        z <= 0;
        isUpCount <=0; 
        timer_enabled<=0;
        isDownCount<=0;
        load <=0;
        
        M_TENS <= m_tens;
        M_ONES <= m_ones;
        S_TENS <= s_tens;
        S_ONES <= s_ones;   
    end

    wait_up: begin
        z <= 1; 
        isUpCount <=0; 
        timer_enabled<=1;
        isDownCount<=0;
        load <=0;
        
        M_TENS <= m_tens;
        M_ONES <= m_ones;
        S_TENS <= s_tens;
        S_ONES <= s_ones;
    end
               
    wait_down: begin
        z <= 2;
        isUpCount <=0;  
        timer_enabled<=1;
        isDownCount<=0;
        load <=1;
        
        M_TENS <= m_tens_Down;
        M_ONES <= m_ones_Down;
        S_TENS <= s_tens_Down;
        S_ONES <= s_ones_Down;
    end
               
    count_up: begin
        z <= 3;
        isUpCount <=1;
        timer_enabled<=1;
        isDownCount<=0;
        load <=0;
        
        M_TENS <= m_tens;
        M_ONES <= m_ones;
        S_TENS <= s_tens;
        S_ONES <= s_ones;
    end
               
    count_down: begin
        z <= 4;
        isUpCount <=0;
        isDownCount<=1;
        load <=0;
        
        M_TENS <= m_tens_Down;
        M_ONES <= m_ones_Down;
        S_TENS <= s_tens_Down;
        S_ONES <= s_ones_Down;
    end
               
    default: z <= 0;
endcase
end

/* LED Pattern that shifts to the left when counting up, and right when counting down */
reg [3:0] shifted = 0;

always @ (posedge clk_500Hz) begin    
    if (shifted >= 13) begin
        shifted <= 0;
    end
 
    if (isDownCount) begin 
        stream <= 1 << shifted;
    end
    else if (isUpCount) begin
        stream <= 2**13 >> shifted;
    end
    else begin
        stream=0; 
    end
           
    shifted <= shifted + 1;
end
    

   wire spk;
   tick_music tick (.clk(clk_5MHz),.enable(isDownCount),.reset(reset),.clk_out(spk));
 
    always @ (posedge clk_1Hz) begin 
        if (isDownCount) begin 
            timer_on=~timer_on;
            speaker = ~speaker;
        end
        else if (doneCountDown) begin
            timer_on=0;
            speaker = 0;
        end
        else begin
            timer_on=0;
            speaker = 0;
        end
    end
    

// 7 Segment Logic Output
wire [7:0] seg1,seg2,seg3,seg4;

bcd_decoder sec1(.x(M_TENS),.seg(seg1));
bcd_decoder sec2(.x(M_ONES),.seg(seg2));
bcd_decoder sec3(.x(S_TENS),.seg(seg3));
bcd_decoder sec4(.x(S_ONES),.seg(seg4));
reg [7:0] an1 = 8'b11111110, an2 = 8'b11111101, an3 = 8'b11111011, an4 = 8'b11110111;
reg [1:0] count = 0;

always @ (count) begin 
    case (count)
        0: begin
                seg = seg1; 
                an = an1;
           end
           
        1: begin
                seg = seg2; 
                an = an2;
           end
           
        2: begin
                seg = seg3; 
                an = an3;
           end
           
        3: begin
                seg = seg4; 
                an = an4;
           end
           
  default: begin 
               seg = seg1; 
               an = an1;
           end
    endcase
end 

always @ (posedge clk_500Hz) begin
    if (count == 3)
        count <= 0;
    else
        count <= count + 1;
end

endmodule
