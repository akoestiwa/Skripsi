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