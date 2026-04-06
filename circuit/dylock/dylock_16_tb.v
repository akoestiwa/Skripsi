module tb_dylock_16();
  reg   [3:0]   insert_key_static; 
  reg   [11:0]  insert_key_dynamic; 
  reg   [11:0]  key;
  reg           clk, rst_n;
	
  wire  [3:0] static_TK;
  wire  [2:0] set;
  integer i;

  dylock_16 uut (
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
    key = 12'b0000_1011_1111;

	  insert_key_static = 4'b0;
    insert_key_dynamic = 12'b0;
	  #20 rst_n = 1;
	 
    insert_key_static = 4'b0;
    insert_key_dynamic = 12'b1111_1010_1100;
    #140;

    insert_key_static = 4'b0;
    insert_key_dynamic = 12'b1011_1001_1010;
    #140;
	 
	 $stop;
  end
endmodule