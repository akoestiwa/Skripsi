module tb_dylock_16();
  reg [3:0]  insert_key_static; // 4'b1001
  reg [11:0] insert_key_dynamic; // 12'b1011_1011_1011;
  reg clk, rst_n;
	
  wire [3:0] static_TK;
  wire set;
  integer i;

  test uut (
    .static_K(insert_key_static),
    .dynamic_K(insert_key_dynamic),
    .clk(clk),
    .rst_n(rst_n),
	  .static_TK(static_TK),
	  .set(set)
  );
  
  always #5 clk = ~clk;

  initial begin

    clk = 0;
    rst_n = 0;
	  insert_key_static = 4'b0;
    insert_key_dynamic = 12'b0;
	  #20 rst_n = 1;
	 
    insert_key_static = 4'b1100;
    insert_key_dynamic = 12'hfff;
    #140;
	  insert_key_static = 4'b1011;
    insert_key_dynamic = 12'b1011_1011_1011;
    #140;
	 
	 $stop;
  end
  
endmodule