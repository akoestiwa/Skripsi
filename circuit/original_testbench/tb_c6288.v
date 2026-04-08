module tb_c6288();
  reg [31:0] all_inputs;
  wire [31:0] all_outputs;
  integer i,file_handle, my_seed;

  c6288 uut (
    .N1(all_inputs[0]),    .N18(all_inputs[1]),   .N35(all_inputs[2]),   .N52(all_inputs[3]),
    .N69(all_inputs[4]),   .N86(all_inputs[5]),   .N103(all_inputs[6]),  .N120(all_inputs[7]),
    .N137(all_inputs[8]),  .N154(all_inputs[9]),  .N171(all_inputs[10]), .N188(all_inputs[11]),
    .N205(all_inputs[12]), .N222(all_inputs[13]), .N239(all_inputs[14]), .N256(all_inputs[15]),
    .N273(all_inputs[16]), .N290(all_inputs[17]), .N307(all_inputs[18]), .N324(all_inputs[19]),
    .N341(all_inputs[20]), .N358(all_inputs[21]), .N375(all_inputs[22]), .N392(all_inputs[23]),
    .N409(all_inputs[24]), .N426(all_inputs[25]), .N443(all_inputs[26]), .N460(all_inputs[27]),
    .N477(all_inputs[28]), .N494(all_inputs[29]), .N511(all_inputs[30]), .N528(all_inputs[31]),

    .N545(all_outputs[0]),   .N1581(all_outputs[1]),  .N1901(all_outputs[2]),  .N2223(all_outputs[3]),
    .N2548(all_outputs[4]),  .N2877(all_outputs[5]),  .N3211(all_outputs[6]),  .N3552(all_outputs[7]),
    .N3895(all_outputs[8]),  .N4241(all_outputs[9]),  .N4591(all_outputs[10]), .N4946(all_outputs[11]),
    .N5308(all_outputs[12]), .N5672(all_outputs[13]), .N5971(all_outputs[14]), .N6123(all_outputs[15]),
    .N6150(all_outputs[16]), .N6160(all_outputs[17]), .N6170(all_outputs[18]), .N6180(all_outputs[19]),
    .N6190(all_outputs[20]), .N6200(all_outputs[21]), .N6210(all_outputs[22]), .N6220(all_outputs[23]),
    .N6230(all_outputs[24]), .N6240(all_outputs[25]), .N6250(all_outputs[26]), .N6260(all_outputs[27]),
    .N6270(all_outputs[28]), .N6280(all_outputs[29]), .N6287(all_outputs[30]), .N6288(all_outputs[31])
  );

  initial begin  
    file_handle = $fopen("hasil_c6288.txt","w");
    if (file_handle == 0) begin
      $display("error: file tidak bisa dibuka!");
      $finish;
    end

    $fdisplay(file_handle, "Waktu | Input | Output");
    $fdisplay(file_handle, "-----------------------------");
    my_seed = 12345; 
    
    all_inputs = 32'h0; 
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);

    all_inputs = { 16{2'b10} };
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);

    all_inputs = { 32{1'b1} }; 
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);
    
    for (i=0; i<61; i=i+1) begin
      all_inputs = { $random(my_seed), $random(my_seed) } & { 32{1'b1} };
      $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);
      #10;
    end
  end
endmodule