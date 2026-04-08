module tb_c432();
  reg [35:0] all_inputs;
  wire [6:0] all_outputs;
  integer i,file_handle, my_seed;

  c432 uut (
    .N1(all_inputs[0]),   .N4(all_inputs[1]),   .N8(all_inputs[2]),   .N11(all_inputs[3]),
    .N14(all_inputs[4]),  .N17(all_inputs[5]),  .N21(all_inputs[6]),  .N24(all_inputs[7]),
    .N27(all_inputs[8]),  .N30(all_inputs[9]),  .N34(all_inputs[10]), .N37(all_inputs[11]),
    .N40(all_inputs[12]), .N43(all_inputs[13]), .N47(all_inputs[14]), .N50(all_inputs[15]),
    .N53(all_inputs[16]), .N56(all_inputs[17]), .N60(all_inputs[18]), .N63(all_inputs[19]),
    .N66(all_inputs[20]), .N69(all_inputs[21]), .N73(all_inputs[22]), .N76(all_inputs[23]),
    .N79(all_inputs[24]), .N82(all_inputs[25]), .N86(all_inputs[26]), .N89(all_inputs[27]),
    .N92(all_inputs[28]), .N95(all_inputs[29]), .N99(all_inputs[30]), .N102(all_inputs[31]),
    .N105(all_inputs[32]), .N108(all_inputs[33]), .N112(all_inputs[34]), .N115(all_inputs[35]),
        
    .N223(all_outputs[0]), .N329(all_outputs[1]), .N370(all_outputs[2]), .N421(all_outputs[3]), 
    .N430(all_outputs[4]), .N431(all_outputs[5]), .N432(all_outputs[6])
  );

  initial begin  
    file_handle = $fopen("hasil_432.txt","w");
    if (file_handle == 0) begin
      $display("error: file tidak bisa dibuka!");
      $finish;
    end

    $fdisplay(file_handle, "Waktu | Input | Output");
    $fdisplay(file_handle, "-----------------------------");
    
    my_seed = 12345; 
    
    all_inputs = 36'h0;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);
    #10;
    
    all_inputs = 36'hAAAA_AAAA_A; 
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);
    #10;

    all_inputs = 36'hFFFF_FFFF_F; 
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);
    #10;
    
    for (i=0; i<61; i=i+1) begin
      all_inputs = { $random(my_seed), $random(my_seed) } & { 36{1'b1} };
      $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);
      #10;
    end
  end
  endmodule