module tb_c17_locked_8();
  reg N1,N2,N3,N6,N7;
  reg [3:0]   insert_key_static;  // 4'b1001
  reg [3:0]   insert_key_dynamic; // 4'b1011
  reg [3:0]   key;                // 4'b0000
  reg clk, rst_n;

  wire N22,N23;
  integer i;

  c17_locked_8 uut (
    .N1(N1), 
    .N2(N2), 
    .N3(N3), 
    .N6(N6), 
    .N7(N7), 
    .N22(N22), 
    .N23(N23),

    .static_K(insert_key_static),
    .dynamic_K(insert_key_dynamic),
    .key(key),
    .clk(clk),
    .rst_n(rst_n)
  );
  
  always #5 clk = ~clk;

  initial begin
    
    clk = 0;                            // inisiasi nilai
    rst_n = 0;
    {N1, N2, N3, N6, N7} = 5'b00000;
    insert_key_static = 4'b0;
    insert_key_dynamic = 4'b0;

    #20 rst_n = 1;                      // start

    insert_key_static = 4'b0101;        // kedua kunci salah tanpa menunggu
    insert_key_dynamic = 4'b0001;
    for (i=0; i<32; i=i+1) begin
      {N1, N2, N3, N6, N7} = i; 
      #10;
    end  
    {N1, N2, N3, N6, N7} = 5'b00000;
    
    insert_key_static = 4'b0101;        // kedua kunci salah dengan menunggu
    insert_key_dynamic = 4'b0001;
    #120
    for (i=0; i<32; i=i+1) begin
      {N1, N2, N3, N6, N7} = i; 
      #10;
    end  
    {N1, N2, N3, N6, N7} = 5'b00000;

    insert_key_static = 4'b0101;        // kunci dinamis benar dengan menunggu
    insert_key_dynamic = 4'b0;
    #120
    for (i=0; i<32; i=i+1) begin
      {N1, N2, N3, N6, N7} = i; 
      #10;
    end  
    {N1, N2, N3, N6, N7} = 5'b00000;

    insert_key_static = 4'b1001;        // kunci statis dan dinamis benar dengan menunggu
    insert_key_dynamic = 4'b1011;
    #120
    for (i=0; i<32; i=i+1) begin
      {N1, N2, N3, N6, N7} = i; 
      #10;
    end  
    {N1, N2, N3, N6, N7} = 5'b00000;

    
	$finish;
  end
  insert_key_static = 4'b1001;
    insert_key_dynamic = 12'b1001_1001_1001;
endmodule