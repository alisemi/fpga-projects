Morsecoder is a digital design project regarding the translation of Morse Code to letters in English alphabet and numerals. The morse code which is taken as input is translated to the text version by the logic design in the FPGA board(Basys 3) and then is represented on the 8x8 LED screen of the BETI board. Once a full letter/numeral is taken, it will be shown on the LED screen until the next letter/numeral is fully entered by the user.
	List of Inputs:
	One pushbutton on the Basys3 Board(BTNC <U18> ) to get Morse Code
	One switch to reset the system.
List of Outputs:
	There  are 37 different outputs (26 for letters, 10 for numerals, 1 to indicate an illegal input ) will be represented on the 8x8 LED screen on BETI Board.

REFERENCES
1)	Lines 0-76 of DotMatrix.sv; taken from Mert Aytöre’s CS223 Project; originally in Verilog, re-written in SystemVerilog and added some other functionality with respect to the needs of our project. Source: github.com/mertaytore/cs223project
2)	File SevSeg_4digit.sv; taken from CS223 Fall 2016 Lab Assignment 4; no changes made. Source: dl.dropboxusercontent.com/u/11084576/CS223/SevSeg_4digit.sv

Copyright (C) 2016 M. Ali Semi YENIMOL & Berat BICER

Licensed under the TAPR Open Hardware License (www.tapr.org/OHL)
