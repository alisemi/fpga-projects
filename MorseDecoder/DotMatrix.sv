`timescale 1ns / 1ps
/*

-	Sends appropriate signals to 8x8 Display module to make it online.
-	Since the 8x8 Display Module has 8 rows and each row has a 24 bit data, for each frame, we need 192 bit data in total. This data is taken from MatrixDriver module.

For each row, there are 3 8-bit color shift registers: red, green and blue respectly, which at each clock cycle, they shift one bit of the data in serial in-parallel out format. To be able to light the 8x8 Display module, in first 24 cycles, we need to send data to the first register so that at each cycle, data can be shifted through the last register. Therefore, for the first 24 clock cycles, we send a clock signal, SH_CP,  and a 1 bit data, DS, at each cycle: shiftRed, shiftGreen, shiftBlue respectly. In the meantime, we need the store registers and output registers within color registers be offline so that we can see a full frame. Thus, in the first 24 clock cycle, clock for the store registers, ST_CP, is 1’b0 and enable signal, OE, for the output registers are 1’b1 since its an active-low signal. When the data is taken and shifted, we need to send them to store registers with a clock signal, ST_CP. For the next 24 cycles, we set SH_CP to 1’b0 since we don’t need anymore data, ST_CP to 1’b1 and OE to 1’b1 so that we delay the output until all the data is stored. When the store process is complete, we enable the output registers by setting OE signal to 1’b0. When we are done with a row, we go to the next row and repeat this process again. Finally, when all the rows are done, a frame appears on the 8x8 Display Module.

Copyright (C) 2016 M. Ali Semi YENIMOL & Berat BICER

Licensed under the TAPR Open Hardware License (www.tapr.org/OHL)
*/
module DotMatrix( input logic clk,
    input logic [7:0][23:0] in_data,
    output logic oe, //output enable	
    output logic SH_CP, // shift register clk pulse
    output logic ST_CP, // store register clk pulse
    output logic reset, // reset for the shift register
    output logic DS, // digital signal
    output logic [7:0] row);
    
    logic f,e;
    logic [1:0] counter;
    logic [8:0] i = 1; // data sinyalinin ileticisi
    logic [2:0] a = 0;
    logic [9:0] d = 0;
    
    logic [7:0][23:0] data = in_data;
    logic [24:1] message;
    
    always@(posedge clk)
    begin
        counter <= counter + 1;
        f <= counter[1]; // SHCP
        e <= ~f;
    end
    
    always@(posedge e)
        i = i + 9'b000000001;
        
    always@(*)
    begin
        if (i < 9'b000000100) // baslangıçta i 4'e gelene kadar sisteme reset atıyor.
            reset<=0;
        else
            reset<=1;
            
        if (i>9'b000000011 && i<9'b000011100) //4'le 27 arasında data akışı seri olarak devam ediyor
            DS<=message[i-9'b000000011];
        else 
            DS<=0;
            
        if (i<9'b000011100) //i 28'e geldiğinde data akış tamamlanıyor. 24 bit data alınmı oluyor. bu sureden sonra clk durduluyor yeni data akışına kadar.
        begin
                SH_CP<=f;             
                ST_CP<=e;
        end
            
        else
        begin
                SH_CP<=0;
                ST_CP<=1;
        end
    end
            always @(posedge f)//clk un durduğu surede OE=0 yani output registerin çıktığında aktif durumda.
            begin
                if (i>9'b000011100 && i<9'b110011101)
                    oe<=0;
                else
                    oe<=1;
            end        
    
            always @(posedge f) //bir satır tamamlandığında a bir arttırılıyor 2. satıra geçmek için.
            begin    
                if (i==9'b110011110)
                    begin
                    a = a+1;
                    //i <=9'b0;
                    end
            end
        
    always_ff@(posedge clk)
        message <= data[a];
                     
    always_comb
        case(a)
            3'b000: row = 8'b0000_0001;
            3'b001: row = 8'b0000_0010;
            3'b010: row = 8'b0000_0100;
            3'b011: row = 8'b0000_1000;
            3'b100: row = 8'b0001_0000;
            3'b101: row = 8'b0010_0000;
            3'b110: row = 8'b0100_0000;
            3'b111: row = 8'b1000_0000;
            default: row = 8'b0000_0000;            
        endcase
                   
endmodule
