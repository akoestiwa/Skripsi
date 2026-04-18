module top_c17_locked (
    input [4:0] all_inputs,
    output [1:0] all_outputs,
    input [3:0] static_K, dynamic_K, key,
    input       clk, rst_n
  );

  wire set;
  wire [3:0] static_TK;

  dylock_8 dylock_inst (
    .dynamic_K (dynamic_K),
    .static_K (static_K),
    .key (key),
    .clk (clk),
    .rst_n (rst_n),
    .static_TK (static_TK),
    .set (set)
  );

  c17_locked c17_locked_inst (
    .all_inputs (all_inputs), 
    .all_outputs (all_outputs),
    .set (set),       
    .static_TK (static_TK) 
  );
endmodule

module nonlinear_gen ( K, TK );
  input   [3:0] K;
  output  [3:0] TK;
  
  assign TK[0] =  (K[3] & ~K[0]) | 
                  (K[1] & K[2] & K[3]) | 
                  (K[0] & K[2] & ~K[3]) | 
                  (K[3] & ~K[1] & ~K[2]);

  assign TK[1] =  (K[0] & K[2] & K[3]) | 
                  (K[0] & K[3] & ~K[1]) | 
                  (K[1] & ~K[0] & ~K[2]) | 
                  (K[1] & ~K[2] & ~K[3]) | 
                  (K[2] & ~K[0] & ~K[1]);

  assign TK[2] =  (K[0] & K[2] & K[3]) | 
                  (K[0] & ~K[1] & ~K[3]) | 
                  (K[1] & ~K[0] & ~K[3]) | 
                  (K[3] & ~K[0] & ~K[2]);

  assign TK[3] =  (K[0] & K[2] & ~K[1]) | 
                  (K[0] & K[3] & ~K[1]) | 
                  (K[1] & K[2] & ~K[0]) | 
                  (K[1] & K[3] & ~K[0]) | 
                  (K[0] & K[1] & ~K[2] & ~K[3]) | 
                  (~K[0] & ~K[1] & ~K[2] & ~K[3]);		
endmodule

module dylock ( K, key, clk, rst_n, set );
  input   [3:0]  K, key;
  input          clk, rst_n;
  output         set;
  
  wire    [3:0] TK;
  reg     [3:0] count;
   
  nonlinear_gen keygen (
      .K(K),
	    .TK(TK)
  );
    
  always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
			  count <= 4'd0;
      end 
			else begin
        if ( TK == key ) begin
          if (count < 4'd12)
            count <= count + 1'b1;
          else
            count <= count;
          end 
        else
          count <= 4'd0; 
			end
  end
  assign set = (count == 4'd12);
endmodule

module dylock_8 ( static_K, dynamic_K, key, clk, rst_n, static_TK, set);
  input   [3:0] static_K, dynamic_K, key;
  input         clk, rst_n;
  output  [3:0] static_TK;
  output        set;

  wire    [3:0] dynamic_TK;

  dylock dylock_inst (
    .K (dynamic_K),
    .key (key),
    .clk (clk),
    .rst_n (rst_n),
    .set (set)
  );
  assign static_TK = static_K;
endmodule

module c17_locked ( all_inputs, all_outputs, set,static_TK );
  
  // input bus
  input [4:0] all_inputs;
  output [1:0] all_outputs;
  
  // input
  wire N1,N2,N3,N6,N7;
  assign N1 = all_inputs[0];
  assign N2 = all_inputs[1];
  assign N3 = all_inputs[2];
  assign N6 = all_inputs[3];
  assign N7 = all_inputs[4];
  
  // output
  wire N22,N23;
  assign all_outputs[0] = N22;
  assign all_outputs[1] = N23;

  // wire rangkaian
  wire N10,N11,N16,N19;
  
  // input dylock
  input set;
  input [3:0] static_TK;

  // wire kunci
  wire N11_locked, N6_locked, N7_locked, N16_locked, N19_locked;
  
  // rangkaian c17
  nand NAND2_1 (N10, N1, N3);
  nand NAND2_2 (N11, N3, N6_locked);
  nand NAND2_3 (N16, N2, N11_locked);
  nand NAND2_4 (N19, N11_locked, N7_locked);
  nand NAND2_5 (N22, N10, N16_locked);
  nand NAND2_6 (N23, N16_locked, N19_locked);

  // rangkaian kunci (static_K = static_TK = 1001)
  xor static_lock_0 (N6_locked, N6, ~static_TK[0]);
  xor static_lock_1 (N7_locked, N7, static_TK[1]);
  xor static_lock_2 (N16_locked, N16, static_TK[2]);
  xor static_lock_3 (N19_locked, N19, ~static_TK[3]);
  xor dynamic_lock (N11_locked, N11, ~set);
endmodule