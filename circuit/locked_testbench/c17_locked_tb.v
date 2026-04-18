module tb_c17_locked();
  reg [4:0] all_inputs;
  reg [3:0] insert_key_static, insert_key_dynamic, key;
  reg clk, rst_n;

  wire [1:0] all_outputs;
  integer i,file_handle;

  top_c17_locked uut (
    .all_inputs (all_inputs), 
    .all_outputs (all_outputs), 

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
    {all_inputs} = { 5{1'b0} };
    $fdisplay(file_handle, "%5t |     %b_%b    | %b | %b", $time, insert_key_static, insert_key_dynamic, all_inputs ,all_outputs);
    

    // key salah
    // key_static = 4'b1011;
    // key_dynamic = 4'b0100;

    // key benar
    // key_static = 4'b1001;
    // key_dynamic = 4'b1011;

    #10 rst_n = 1;
    insert_key_static = 4'b1001;
    insert_key_dynamic = 4'b1011;
    #120;
    
    for (i=0; i<32; i=i+1) begin
      {all_inputs} = i;
      #10;
      $fdisplay(file_handle, "%5t |     %b_%b    | %b | %b", $time, insert_key_static, insert_key_dynamic, all_inputs ,all_outputs);
    end
	$finish;
  end
endmodule