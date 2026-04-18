module tb_c2670_locked();
  reg [232:0] all_inputs;
  reg [3:0] insert_key_static;
  reg [11:0] insert_key_dynamic;
  reg [11:0] key;
  reg clk, rst_n;

  wire [139:0] all_outputs;
  integer i,my_seed,file_handle;

  top_c2670_locked uut (
    .all_inputs(all_inputs),
    .all_outputs(all_outputs),
    .static_K(insert_key_static),
    .dynamic_K(insert_key_dynamic),
    .clk(clk),
    .key(key),
    .rst_n(rst_n)
  );

  always #5 clk = ~clk;

  initial begin  
    file_handle = $fopen("hasil_c2670_locked.txt","w");
    if (file_handle == 0) begin
      $display("error: file tidak bisa dibuka!");
      $finish;
    end

    $fdisplay(file_handle, "Waktu | Key (static_dynamic) | Input | Output");
    $fdisplay(file_handle, "---------------------------------------------");

    my_seed = 12345;
    
    clk = 0;
    rst_n = 0;
    key = 12'b0000_0100_1100;
    insert_key_static = 4'b0;
    insert_key_dynamic = 4'b0;
    all_inputs = 233'h0;
    #10 rst_n = 1;
    $fdisplay(file_handle, "%5t | %b_%b | %b | %b", $time, insert_key_static, insert_key_dynamic, all_inputs, all_outputs);

    // key benar
    // static = 4'b1001;
    // dynamic 12'b_1011_0001_0110;

    // key salah
    // static = 4'b1011
    // dynamic = 12'b_1101_0111_100

    insert_key_static = 4'b1001;
    insert_key_dynamic = 12'b_1011_0001_0110;
    #120;
    all_inputs = {{116{2'b10}},{1'b1}}; #10;
    $fdisplay(file_handle, "%5t | %b_%b | %b | %b", $time, insert_key_static, insert_key_dynamic, all_inputs, all_outputs);
    all_inputs = {233{1'b1}}; #10;
    $fdisplay(file_handle, "%5t | %b_%b | %b | %b", $time, insert_key_static, insert_key_dynamic, all_inputs, all_outputs);
    
    for (i=0; i<61; i=i+1) begin
      all_inputs = { $random(my_seed), $random(my_seed),
                     $random(my_seed), $random(my_seed),
                     $random(my_seed), $random(my_seed),
                     $random(my_seed), $random(my_seed),
                     $random(my_seed), $random(my_seed),
                     $random(my_seed), $random(my_seed),
                     $random(my_seed), $random(my_seed),
                     $random(my_seed), $random(my_seed)
                   } & { 233{1'b1} };
      #10;
      $fdisplay(file_handle, "%5t | %b_%b | %b | %b", $time, insert_key_static, insert_key_dynamic, all_inputs, all_outputs);
    end
    $fclose(file_handle);
    $stop;
  end
endmodule