module tb_c17_locked();
  reg N1,N2,N3,N6,N7;
  reg [3:0] insert_key_static, insert_key_dynamic, key;
  reg clk, rst_n;

  wire N22,N23;
  integer i,file_handle;

  top_c17_locked uut (
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
    .rst_n(rst_n),
    .key(key)
  );
  
  always #5 clk = ~clk;

  initial begin

    file_handle = $fopen("hasil_c17_locked.txt","w");
    if (file_handle == 0) begin
      $display("error: file tidak bisa dibuka!");
      $finish;
    end

    $fdisplay(file_handle, "Waktu | Key (static_dynamic) | Input | Output");
    $fdisplay(file_handle, "---------------------------------------------");

    clk = 0;
    rst_n = 0;
    key = 4'b0;

    insert_key_static = 4'b0;
    insert_key_dynamic = 4'b0;
    {N1, N2, N3, N6, N7} = 5'b00000;
    $fdisplay(file_handle, "%5t |     %b_%b    | %b%b%b%b%b | %b%b", $time, insert_key_static, insert_key_dynamic, N1,N2,N3,N6,N7 ,N22,N23);
    

    // key salah
    // insert_key_static = 4'b1011;
    // insert_key_dynamic = 4'b0100;
    #10 rst_n = 1;
    insert_key_static = 4'b1001;
    insert_key_dynamic = 4'b1011;
    #120;
    
    for (i=0; i<32; i=i+1) begin
      {N1, N2, N3, N6, N7} = i; 
      #10;
      $fdisplay(file_handle, "%5t |     %b_%b    | %b%b%b%b%b | %b%b", $time, insert_key_static, insert_key_dynamic, N1,N2,N3,N6,N7 ,N22,N23);
    end
	$finish;
  end
  
endmodule