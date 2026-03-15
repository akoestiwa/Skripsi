module tb_c17();
  reg N1,N2,N3,N6,N7;
  wire N22,N23;
  integer i, file_csv; 

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
    file_csv = $fopen("hasil_c17.csv", "w");
    $fdisplay(file_csv, "Time (ns),N1,N2,N3,N6,N7,N22,N23");

    {N1, N2, N3, N6, N7} = 5'b00000;

    for (i=0; i<32; i=i+1) begin
      {N1, N2, N3, N6, N7} = i; 
      #10;
      $fdisplay(file_csv, "%0t,%b,%b,%b,%b,%b,%b,%b", $time, N1, N2, N3, N6, N7, N22, N23);
    end

    $fclose(file_csv);
    $stop; 
  end
endmodule

