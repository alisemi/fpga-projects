`timescale 1ns / 1ps

/*
Morsecoder is a digital design project regarding the translation of Morse Code to letters in English alphabet and numerals. The morse code which is taken as input is translated to the text version by the logic design in the FPGA board(Basys 3) and then is represented on the 8x8 LED screen of the BETI board. Once a full letter/numeral is taken, it will be shown on the LED screen until the next letter/numeral is fully entered by the user.
	List of Inputs:
	One pushbutton on the Basys3 Board(BTNC <U18> ) to get Morse Code
	One switch to reset the system.
List of Outputs:
	There  are 37 different outputs (26 for letters, 10 for numerals, 1 to indicate an illegal input ) will be represented on the 8x8 LED screen on BETI Board.

REFERENCES
1)	Lines 0-76 of DotMatrix.sv; taken from Mert Aytöre’s CS223 Project; originally in Verilog, re-written in SystemVerilog and added some other functionality with respect to the needs of our project. Source: github.com/mertaytore/cs223project
2)	File SevSeg_4digit.sv; taken from CS223 Fall 2016 Lab Assignment 4; no changes made. Source: dl.dropboxusercontent.com/u/11084576/CS223/SevSeg_4digit.sv

	
Description of the module:
-	Main driver of the system
-	Controls data transfer between modules
-	Inputs are given to here and outputs are taken from this module
-	Main module has the main data flow within the project: It takes inputs through BASYS3, sends them to appropriate modules, takes outputs from them and sends data taken from previous modules to either another module or outputs them. 
-	It has 3 instances of other modules: InputConverter, ControllerFSM, MatrixDriver. InputConverter is used to translate the data which is in Morse code to binary. ControllerFSM is used to interpret the Morse code in binary form as letters or numbers. MatrixDriver takes those letters and numbers, then determines an appropriate representation so that they can be shown in 8x8 Display Module. 

Copyright (C) 2016 M. Ali Semi YENIMOL & Berat BICER

Licensed under the TAPR Open Hardware License (www.tapr.org/OHL)

*/
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
          
    inputConverterV1 ic( bi, clk_en, mr, enable, led, a, b, c, d, e, f, g, dp, an, click);
    ControllerFSM cfsm( clk_en, mr, click, enable, letter);
    MatrixDriver md(clk_en, letter, oe, SH_CP, ST_CP, reset, DS, row);
    
endmodule
