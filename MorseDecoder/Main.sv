`timescale 1ns / 1ps

module Main(
    input logic clk,
    input logic mr,
    input logic bi,
    output logic oe, //output enable    
    output logic SH_CP, // shift register clk pulse
    output logic ST_CP, // store register clk pulse
    output logic reset, // reset for the shift register
    output logic DS, // digital signal
    output logic [7:0] row,
    output logic [14:0] led,
    output logic a, b, c, d, e, f, g, dp, //individual LED output for the 7-segment along with the digital point
    output logic [3:0] an
    );
    
    logic [5:0] letter;
    logic enable;
    logic [1:0] click;
    
    //Slowing down the clock in order to prevent delays
    int count = 0;
    logic clk_en;
     
   always@ (posedge clk) 
     begin
             count <= count + 1;
             if (count== 2) //D: last value for counter
             count <= 27'b0; //N: length of counter
             if (count==27'b0)
             clk_en <= 1'b1;
             else
             clk_en <= 1'b0;
      end
          
    //inputConverterDriver ic(bi, clk, mr,enable, led, a, b, c, d, e, f, g, dp, an, click);
    inputConverterV1 ic( bi, clk_en, mr, enable, led, a, b, c, d, e, f, g, dp, an, click);
    ControllerFSM cfsm( clk_en, mr, click, enable, letter);
    MatrixDriver md(clk_en, letter, oe, SH_CP, ST_CP, reset, DS, row);
    
endmodule
