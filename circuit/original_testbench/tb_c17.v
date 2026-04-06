module tb_c17();
  reg N1,N2,N3,N6,N7;
  wire N22,N23;
  integer i, file_handle; 

  c17 uut (
    .N1(N1), 
    .N2(N2), 
    .N3(N3), 
    .N6(N6), 
    .N7(N7), 
    .N22(N22), 
    .N23(N23)
  );

  initial begin
    file_handle = $fopen("hasil_c17_locked.txt","w");
    if (file_handle == 0) begin
      $display("error: file tidak bisa dibuka!");
      $finish;
    end

    $fdisplay(file_handle, "Waktu | Key (static_dynamic) | Input | Output");
    $fdisplay(file_handle, "---------------------------------------------");

    {N1, N2, N3, N6, N7} = 5'b00000;

    for (i=0; i<32; i=i+1) begin
      {N1, N2, N3, N6, N7} = i; 
      #10;
      $fdisplay(file_csv, "%0t,%b,%b,%b,%b,%b,%b,%b", $time, N1, N2, N3, N6, N7, N22, N23);
    end

    $fdisplay(file_handle, "%5t | %b_%b | %b | %b", $time, insert_key_static, insert_key_dynamic, all_inputs, all_outputs);
    
    $fclose(file_handle);
    $stop;
  end
endmodule

