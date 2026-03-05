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

module nonlinear_gen_12 ( dynamic_K, dynamic_TK );
  input [11:0] dynamic_K;
	output [11:0] dynamic_TK;

	genvar i;
	generate
		for (i=0; i<3; i=i+1) begin : nonlinear_gen_mul
			nonlinear_gen nonlinear_gen_3 (
				.K(dynamic_K[(i*4)+3 : i*4]),
        .TK(dynamic_TK[(i*4)+3 : i*4])
			);
		end
	endgenerate
endmodule

module dylock_16 ( dynamic_K, static_K, clk, rst_n, static_TK, set );
  input   [11:0]  dynamic_K;
  input   [3:0]   static_K;
  input           clk, rst_n;          
  output  [3:0] static_TK;
  output        set;

  wire [11:0] dynamic_TK;
  localparam [11:0] DYNAMIC_KEY = 12'h0; 
    
  nonlinear_gen_12 keygen (
      .dynamic_K(dynamic_K),
		  .dynamic_TK(dynamic_TK)
  );
    
	reg [3:0] count;
    
  always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
			count <= 4'd0;
      end 
			else begin
            if (dynamic_TK == DYNAMIC_KEY) begin
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
  assign static_TK = static_K;  
endmodule