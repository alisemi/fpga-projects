`timescale 1ns / 1ps

module ControllerFSM(
    input logic clk,
    input logic reset,
    input logic [1:0] click,
    input logic enable,
    output logic [5:0] letter
    );
    typedef enum logic [5:0] { D_START, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S,T, U, V, W, X, Y, Z,U_DASH, R_DASH, O_DOT, O_DASH, INVALID, D0, D1, D2, D3, D4, D5, D6, D7, D8, D9 } statetype;
        statetype state, nextstate;

    //state register
    always_ff @(posedge clk, posedge reset)
    begin
        if(reset) state <= D_START;
        else begin if(enable)  state <= nextstate; end
    end
        
    //next state logic
    always_comb
        case(state)
        D_START:
            begin
            if( click == 2'b01 ) nextstate = E;
            if( click == 2'b10 ) nextstate = T;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
            end
        E: 
        begin
            if( click == 2'b01 ) nextstate = I;
            if( click == 'b10 ) nextstate = A;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        T: 
        begin
            if( click == 2'b01 ) nextstate = N;
            if( click == 2'b10 ) nextstate = M;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        I: 
        begin
            if( click == 2'b01 ) nextstate = S;
            if( click == 2'b10 ) nextstate = U;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        A: 
        begin
            if( click == 01 ) nextstate = R;
            if( click == 10 ) nextstate = W;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        N: 
        begin            
            if( click == 01 ) nextstate = D;
            if( click == 10 ) nextstate = K;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        M: 
        begin
            if( click == 01 ) nextstate = G;
            if( click == 10 ) nextstate = O;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        S: 
        begin
            if( click == 01 ) nextstate = H;
            if( click == 10 ) nextstate = V;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        U: 
        begin
            if( click == 01 ) nextstate = F;
            if( click == 10 ) nextstate = U_DASH;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        R: 
        begin
            if( click == 01 ) nextstate = L;
            if( click == 10 ) nextstate = R_DASH;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        W: 
        begin
            if( click == 01 ) nextstate = P;
            if( click == 10 ) nextstate = J;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        D: 
        begin
            if( click == 01 ) nextstate = B;
            if( click == 10 ) nextstate = X;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        K: 
        begin
            if( click == 01 ) nextstate = C;
            if( click == 10 ) nextstate = Y;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        G: 
        begin
            if( click == 01 ) nextstate = Z;
            if( click == 10 ) nextstate = Q;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        O: 
        begin
            if( click == 01 ) nextstate = O_DOT;
            if( click == 10 ) nextstate = O_DASH;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        H: 
        begin
            if( click == 01 ) nextstate = D5;
            if( click == 10 ) nextstate = D4;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        V: 
        begin
            if( click == 01 ) nextstate = INVALID;
            if( click == 10 ) nextstate = D3;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        F: 
        begin
            if( click == 01 ) nextstate = INVALID;
            if( click == 10 ) nextstate = INVALID;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;  
        end
        U_DASH: 
        begin
            if( click == 01 ) nextstate = INVALID;
            if( click == 10 ) nextstate = D2;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START; 
        end
        L: 
        begin
            if( click == 01 ) nextstate = INVALID;
            if( click == 10 ) nextstate = INVALID;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;  
        end
        R_DASH: 
        begin
            if( click == 01 ) nextstate = INVALID;
            if( click == 10 ) nextstate = INVALID;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        P: 
        begin
            if( click == 01 ) nextstate = INVALID;
            if( click == 10 ) nextstate = INVALID;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;  
        end
        J: 
        begin
            if( click == 01 ) nextstate = INVALID;
            if( click == 10 ) nextstate = D1;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        B: 
        begin
            if( click == 01 ) nextstate = D6;
            if( click == 10 ) nextstate = INVALID;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        X: 
        begin
            if( click == 01 ) nextstate = INVALID;
            if( click == 10 ) nextstate = INVALID;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        C: 
        begin
            if( click == 01 ) nextstate = INVALID;
            if( click == 10 ) nextstate = INVALID;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        Y: 
        begin
            if( click == 01 ) nextstate = INVALID;
            if( click == 10 ) nextstate = INVALID;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        Z: 
        begin
            if( click == 01 ) nextstate = D7;
            if( click == 10 ) nextstate = INVALID;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        Q: 
        begin
            if( click == 01 ) nextstate = INVALID;
            if( click == 10 ) nextstate = INVALID;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        O_DOT: 
        begin
            if( click == 01 ) nextstate = D8;
            if( click == 10 ) nextstate = INVALID;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        O_DASH: 
        begin
            if( click == 01 ) nextstate = D9;
            if( click == 10 ) nextstate = D0;
            if( click != 2'b01 && click != 2'b10 ) nextstate = D_START;
        end
        D5: 
            if( click == 00) nextstate = D_START;
            else nextstate = INVALID;
        D4: 
            if( click == 00) nextstate = D_START;
            else nextstate = INVALID;
        D3: 
            if( click == 00) nextstate = D_START;
            else nextstate = INVALID;      
        D2: 
            if( click == 00) nextstate = D_START;
            else nextstate = INVALID;      
        D1: 
            if( click == 00) nextstate = D_START;
            else nextstate = INVALID;      
        D6: 
            if( click == 00) nextstate = D_START;
            else nextstate = INVALID;      
        D7: 
            if( click == 00) nextstate = D_START;
            else nextstate = INVALID;
        D8: 
            if( click == 00) nextstate = D_START;
            else nextstate = INVALID;   
        D9: 
            if( click == 00) nextstate = D_START;
            else nextstate = INVALID;       
        D0: 
            if( click == 00) nextstate = D_START;
            else nextstate = INVALID;                                
        INVALID:
            if( click == 00) nextstate = D_START;
            else nextstate = INVALID;                                            
      endcase
      
     //output logic
     always_comb
     if( click == 00 && enable)//If there is space 
        case(state)
            D_START: letter = 6'b000_000;
            A: letter = 6'b000_001;
            B: letter = 6'b000_010;
            C: letter = 6'b000_011;
            D: letter = 6'b000_100;
            E: letter = 6'b000_101;
            F: letter = 6'b000_110;
            G: letter = 6'b000_111;
            H: letter = 6'b001_000;
            I: letter = 6'b001_001;
            J: letter = 6'b001_010;
            K: letter = 6'b001_011;
            L: letter = 6'b001_100;
            M: letter = 6'b001_101;
            N: letter = 6'b001_110;
            O: letter = 6'b001_111;
            P: letter = 6'b010_000;
            Q: letter = 6'b010_001;
            R: letter = 6'b010_010;
            S: letter = 6'b010_011;
            T: letter = 6'b010_100;
            U: letter = 6'b010_101;
            V: letter = 6'b010_110;
            W: letter = 6'b010_111;
            X: letter = 6'b011_000;
            Y: letter = 6'b011_001;
            Z: letter = 6'b011_010;   
            D0: letter = 6'b100_000;
            D1: letter = 6'b100_001;
            D2: letter = 6'b100_010;
            D3: letter = 6'b100_011;
            D4: letter = 6'b100_100;
            D5: letter = 6'b100_100;
            D6: letter = 6'b100_101;
            D7: letter = 6'b100_110;
            D8: letter = 6'b100_111;
            D9: letter = 6'b101_000;
            INVALID: letter = 6'b111_111;
        endcase
endmodule
