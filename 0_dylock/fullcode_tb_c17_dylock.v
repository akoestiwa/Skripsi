module test_tb();
  reg N1,N2,N3,N6,N7;
  reg [3:0]  insert_key_static;
  reg [11:0] insert_key_dynamic;
  reg clk, rst_n;

  wire N22,N23;
  integer i;

  test uut (
    .N1(N1), 
    .N2(N2), 
    .N3(N3), 
    .N6(N6), 
    .N7(N7), 
    .N22(N22), 
    .N23(N23),

    .static_K(insert_key_static),
    .dynamic_K(insert_key_dynamic),
    .clk(clk),
    .rst_n(rst_n)
  );
  
  always #5 clk = ~clk;

  initial begin

    clk = 0;
    rst_n = 0;

    insert_key_static = 4'b0;
    insert_key_dynamic = 12'b0;
    {N1, N2, N3, N6, N7} = 5'b00000;

    #20 rst_n = 1;
	 insert_key_static = 4'b1100;
    insert_key_dynamic = 12'hfff;
	 #130
	 for (i=0; i<32; i=i+1) begin
      {N1, N2, N3, N6, N7} = i; 
      #10;
    end
	 {N1, N2, N3, N6, N7} = 5'b00000;
	 
	 insert_key_static = 4'b1001;
    insert_key_dynamic = 12'b1011_1011_1011;
	 #130
	 for (i=0; i<32; i=i+1) begin
      {N1, N2, N3, N6, N7} = i; 
      #10;
    end
    #130;
	 
    $stop;
  end
endmodule