`timescale 1ns/1ns

module TestBench(); //OUT, DATA_IN, ILeft, IRight, S, CLK_tb
  parameter n = 8;
  reg CLK_tb, ILeft, IRight;
  reg [1:0] S;
  reg [(n - 1):0] DATA_IN_tb;
  wire [(n - 1):0] OUT_tb;
  
  initial begin
    CLK_tb = 0; 
    ILeft = 1'b0;
    IRight = 1'b0;
    
    #10 S = 2'b00;
    #20 S = 2'b01; DATA_IN_tb = 8'hFF;
    #20 S = 2'b10;  // Shift left
    #70 S = 2'b11;  //Shift right
    #150 $finish;
  end
  
  initial begin
    $monitor("Time=%d, In_left=%b, In_right=%b, Sel=%b, DataIn=%h, Qout=%h", $time, ILeft, IRight, S, DATA_IN_tb, OUT_tb);
  end
  
  always @(CLK_tb)
    #10 CLK_tb <= ~CLK_tb;
    
  ShiftRegister DUT(.OUT(OUT_tb), .DATA_IN(DATA_IN_tb), .Ileft(ILeft), .Iright(IRight), .SEL(S), .CLK(CLK_tb));
  
endmodule

    
    
    