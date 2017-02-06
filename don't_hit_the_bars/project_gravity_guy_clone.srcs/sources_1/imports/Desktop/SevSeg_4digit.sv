`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2016 05:12:46 PM
// Design Name: 
// Module Name: SevSeg_4digit
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

// LED positions inside 7-segment
//    A 
//  F   B
//    G
//  E   C
//    D      DP

// digit positions on Basys3 :
// in3(left), in2, in1, in0(right)


module SevSeg_4digit(
 input clk,
 input [3:0] in0, in1, in2, in3,        // 4 values for 4 digits (decimal value)
 output a, b, c, d, e, f, g, dp, //individual LED output for the 7-segment along with the digital point
 output [3:0] an   // anode: 4-bit enable signal (active low)
 );
 
// divide system clock (100Mhz for Basys3) by 2^N using a counter, which allows us to multiplex at lower speed
localparam N = 18;
logic [N-1:0] count = {N{1'b0}}; //initial value
always@ (posedge clk)
	count <= count + 1;

 
logic [3:0]digit_val; // 7-bit register to hold the current data on output
logic [3:0]digit_en;  //register for enable vector
 
always_comb
 begin
 digit_en = 4'b1111; //default
 digit_val = in0; //default
 
  case(count[N-1:N-2]) //using only the 2 MSB's of the counter 
    
   2'b00 :  //select first 7Seg.
    begin
     digit_val = in0;
     digit_en = 4'b1110;
    end
    
   2'b01:  //select second 7Seg.
    begin
     digit_val = in1;
     digit_en = 4'b1101;
    end
    
   2'b10:  //select third 7Seg.
    begin
     digit_val = in2;
     digit_en = 4'b1011;
    end
     
   2'b11:  //select forth 7Seg.
    begin
     digit_val = in3;
     digit_en = 4'b0111;
    end
  endcase
 end
 

//Convert digit number to LED vector. LEDs are active low.
logic [6:0] sseg_LEDs; 
always_comb
 begin 
  sseg_LEDs = 7'b1111111; //default
  case(digit_val)
   4'd0 : sseg_LEDs = 7'b1000000; //to display 0
   4'd1 : sseg_LEDs = 7'b1111001; //to display 1
   4'd2 : sseg_LEDs = 7'b0100100; //to display 2
   4'd3 : sseg_LEDs = 7'b0110000; //to display 3
   4'd4 : sseg_LEDs = 7'b0011001; //to display 4
   4'd5 : sseg_LEDs = 7'b0010010; //to display 5
   4'd6 : sseg_LEDs = 7'b0000010; //to display 6
   4'd7 : sseg_LEDs = 7'b1111000; //to display 7
   4'd8 : sseg_LEDs = 7'b0000000; //to display 8
   4'd9 : sseg_LEDs = 7'b0010000; //to display 9
   default : sseg_LEDs = 7'b0111111; //dash
  endcase
 end
 
assign an = digit_en; 
assign {g, f, e, d, c, b, a} = sseg_LEDs; 
assign dp = 1'b1; //turn dp off
 
 
endmodule
