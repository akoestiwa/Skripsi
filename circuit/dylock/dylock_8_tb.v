module tb_dylock_8();
  reg   [3:0] insert_key_static;
  reg   [3:0] insert_key_dynamic; 
  reg   [3:0] key;
  reg         clk, rst_n;
	
  wire  [3:0] static_TK;
  wire        set;
  integer i;

  dylock_8 uut (
    .static_K (insert_key_static),
    .dynamic_K (insert_key_dynamic),
    .key (key),
    .clk (clk),
    .rst_n (rst_n),
	  .static_TK (static_TK),
	  .set (set)
  );
  
  always #5 clk = ~clk;

  initial begin

    clk = 0;
    rst_n = 0;
    key = 4'b1110;

	  insert_key_static = 4'b0;
    insert_key_dynamic = 4'b0;
	  #20 rst_n = 1;
	 
    insert_key_dynamic = 4'b1010;
    #120; 

    insert_key_dynamic = 4'b1101;
    #120; 
    
    $stop;

  end
endmodule