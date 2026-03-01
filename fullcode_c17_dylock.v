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
                  (K[1] & ~K[2] & K[3]) | 
                  (K[2] & ~K[0] & ~K[1]);

  assign TK[2] =  (K[0] & K[2] & K[3]) | 
                  (K[0] & ~K[1] & ~K[3]) | 
                  (K[1] & ~K[0] & ~K[3]) | 
                  (K[3] & ~K[0] & ~K[2]);

  assign TK[3] =  (K[0] & K[2] & ~K[1]) | 
                  (K[0] & K[3] & ~K[1]) | 
                  (K[1] & ~K[2] & ~K[0]) | 
                  (K[1] & ~K[3] & ~K[0]) | 
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
  localparam [11:0] DYNAMIC_KEY = 12'b1001_1001_1001; 
    
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

module c17_locked (
    input N1, N2, N3, N6, N7,
    output N22, N23,
    input set,       
    input [3:0] static_TK 
  );

  wire N10, N11, N16, N19;
  wire N10_raw, N11_raw, N16_raw, N19_raw, N22_raw, N23_raw;

  nand NAND2_1 (N10_raw, N1, N3);
  nand NAND2_2 (N11_raw, N3, N6);
    
  assign N10 = N10_raw ^ (~set); 
  assign N11 = N11_raw ^ static_TK[0];

  nand NAND2_3 (N16_raw, N2, N11);
  nand NAND2_4 (N19_raw, N11, N7);

  assign N16 = N16_raw ^ static_TK[1];
  assign N19 = N19_raw ^ static_TK[2];

  nand NAND2_5 (N22_raw, N10, N16);
  nand NAND2_6 (N23_raw, N16, N19);

  assign N22 = N22_raw ^ static_TK[3];
  assign N23 = N23_raw;
endmodule

module top_module (
    input N1, N2, N3, N6, N7,
    output N22, N23,

    input [3:0] static_K, 
    input [11:0]  dynamic_K,
    input         clk, rst_n
  );

  wire set;
  wire [3:0] static_TK;
  dylock dylock_inst (
    .dynamic_K (dynamic_K),
    .static_K (static_K),
    .clk (clk),
    .rst_n (rst_n),
    .static_TK (static_TK),
    .set (set)
  );

  c17_locked c17_locked_inst (
    .N1 (N1), 
    .N2 (N2),
    .N3 (N3),
    .N6 (N6),
    .N7 (N7),
    .N22 (N22),
    .N23 (N23),
    .set (set),       
    .static_TK (static_TK) 
  );
endmodule