// UUT without faults
module question5 (Y, A, B, C, D);
  input A, B, C, D;
  output Y;
  wire w1, w2, w3, w4, w5, w6, w7;

  nor g1(w1, A, C);
  nor g2(w2, w1, D);
  not g3(w3, w2);
  nand g4(w4, B, D);
  not g5(w5, w4); //X
  nand g6(w6, w3, w5);
  not g7(w7, C);
  nand g8(Y, w6, w7);

endmodule


//UUT with faults
module question5f(Y, A, B, C, D);
  input A, B, C, D;
  output Y;
  wire w1, w2, w3, w4, w5, w6, w7;

  nor g1(w1, A, C);
  nor g2(w2, w1, D);
  not g3(w3, w2);
  nand g4(w4, B, D);
  not g5(w5, w4); //X
  nand g6(w6, w3, w5);
  not g7(w7, C);
  nand g8(Y, w6, w7);

  initial
    //generate a SA0 fault on the input of Gate g5, w4
    #0 force w5 = 1;
endmodule


//TestBench
module tb;
  reg A, B, C, D;
  wire Y, Yf, allout, alloutf;
  integer randSeed;
  integer i;

  assign allout = Y;
  assign alloutf = Yf;

  //create a random stimul and compare UUT outputs
  initial begin

        //compare outputs of good and faulty UUTs
        #5 if (allout != alloutf) $display ("SA 0 fault at w4 detected with test-vector: %5b" , A, B, C, D);

          end


  //for loop
  initial begin
    for (i = 0; i <= 15; i=i+1) begin
        {A, B, C, D}  = i[3:0];
        #5;
      $display ("T=%3d: in=%4b, out=%1b, outf=%1b,    ", $time, {A, B, C, D}, Y, Yf);
        #5;
      end
    end

  question5 uut (.Y(Y), .A(A), .B(B), .C(C), .D(D));
  question5f uutf (.Y(Yf), .A(A), .B(B), .C(C), .D(D));

  initial begin
    $dumpfile("question5.vcd");
    $dumpvars(0, tb);
  end
 endmodule





  
