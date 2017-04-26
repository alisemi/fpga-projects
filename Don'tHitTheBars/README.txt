This project is a game which is implemented for Basys3 using VHDL language for learning purposes.
It takes inputs from buttons(for game control) and switch(reset) on Basys3, outputs the data on Seven Segment
Display and on a Monitor that supports VGA standart.

User controls an object which moves vertically and some bars come in horizontal direction. User tries object to
avoid from these bars using the up and down buttons on Basys 3. Once one the buttons are pressed the object moves
in the direction of up/down with constant velocity. Object doesn't stop so user must actively controll it. As the
time passes, score of the user increase. When the object hits one of the bars or the object hits the uppermost or
lowermost parts of the screen, game is over and a text indicating this shows up on monitor. At the same time,
score stop to increase so that user can see their scores.

A simple demo can be found here: https://www.youtube.com/watch?v=n7n4a5JxDuQ

It uses 4 modules, one for VGA control, one or Button Debouncer, one for seven segment display on Basys 3, and
one for the top module which also has the game mechanics.

Further Implementation:
-One button instead of two button
-Two player game, where two player shares the screen and played as Co-op
-Random Generation of Bars instead of from ROM


REFERENCE
* vga.vhd and debounce.vhd modules are  taken from VGA project for Basys3 from the user Dries007
via github. Original codes can be found on https://github.com/dries007/Basys3/tree/master/VGA which
is licensed under The MIT License (MIT)

* Two functions draw_char and draw_string are also taken from taken from VGA project for Basys3 from 
the user Dries007 via github. Those functions are used for demo in that project. Original codes can 
be found on https://github.com/dries007/Basys3/tree/master/VGA which is licensed 
under The MIT License (MIT)

* SevSeg_4digit module is written in SystemVerilog and taken from
https://dl.dropboxusercontent.com/u/11084576/CS223/SevSeg_4digit.sv which is used in the Bilkent 
CS 223 course labs and projects.

Note For the failing timing requirements:
Timing requirement is not met after the use of code for drawing strings on vga monitor since critical path
for it is quite long and I didn't want to slow down the clock. However, the program works well because of
the fact that the text "Game Over!" is displayed at the end of a game and it is centered so it is enough 
for the purpose. But for further modification, this problem might be attended to.

Copyright (C) 2017 M. Ali Semi YENIMOL

Licensed under the TAPR Open Hardware License (www.tapr.org/OHL)