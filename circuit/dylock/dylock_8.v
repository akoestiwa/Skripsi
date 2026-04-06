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