module tb_c17_locked();
  reg N1,N2,N3,N6,N7;
  reg [3:0]  insert_key_static = 4'b0000;
  reg [11:0] insert_key_dynamic = 12'b1001_1001_1001;
  reg clk, rst_n;

  wire N22,N23;
  integer i;

  top_module uut (
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

    insert_key_static = 4'b0000;
    insert_key_dynamic = 12'b1001_1001_1001;
    {N1, N2, N3, N6, N7} = 5'b00000;

    #20 rst_n = 1;

    #150;
    
    for (i=0; i<32; i=i+1) begin
      {N1, N2, N3, N6, N7} = i; 
      #10;
    end
  end

  $finish;
endmodule