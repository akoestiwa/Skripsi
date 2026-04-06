module nonlinear_gen_tb();
  reg   [3:0] K;
  wire  [3:0] TK;
  integer i,file_handle;

  nonlinear_gen uut(
    .K(K),
    .TK(TK)
  );

  initial begin
    file_handle = $fopen("hasil_nonlinear_gen.txt","w");
    if (file_handle == 0) begin
      $display("error: file tidak bisa dibuka!");
      $finish;
    end
  
    $fdisplay(file_handle, "Waktu | K (Input) | TK (Output)");
    $fdisplay(file_handle, "-------------------------------");

    K = 0;
    for (i=0; i<16; i=i+1) begin
      {K[0],K[1],K[2],K[3]} = i; 
      #10;
      $fdisplay(file_handle, "%5t |   %b    | %b", $time, K, TK);
    end

    $fclose(file_handle);
  end
endmodule