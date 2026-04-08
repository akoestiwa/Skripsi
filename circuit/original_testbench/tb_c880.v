module tb_c880();
  reg [59:0] all_inputs;
  wire [25:0] all_outputs;
  integer i,file_handle, my_seed;

  c880 uut (
    .N1(all_inputs[0]),   .N8(all_inputs[1]),   .N13(all_inputs[2]),  .N17(all_inputs[3]),
    .N26(all_inputs[4]),  .N29(all_inputs[5]),  .N36(all_inputs[6]),  .N42(all_inputs[7]),
    .N51(all_inputs[8]),  .N55(all_inputs[9]),  .N59(all_inputs[10]), .N68(all_inputs[11]),
    .N72(all_inputs[12]), .N73(all_inputs[13]), .N74(all_inputs[14]), .N75(all_inputs[15]),
    .N80(all_inputs[16]), .N85(all_inputs[17]), .N86(all_inputs[18]), .N87(all_inputs[19]),
    .N88(all_inputs[20]), .N89(all_inputs[21]), .N90(all_inputs[22]), .N91(all_inputs[23]),
    .N96(all_inputs[24]), .N101(all_inputs[25]),.N106(all_inputs[26]),.N111(all_inputs[27]),
    .N116(all_inputs[28]),.N121(all_inputs[29]),.N126(all_inputs[30]),.N130(all_inputs[31]),
    .N135(all_inputs[32]),.N138(all_inputs[33]),.N143(all_inputs[34]),.N146(all_inputs[35]),
    .N149(all_inputs[36]),.N152(all_inputs[37]),.N153(all_inputs[38]),.N156(all_inputs[39]),
    .N159(all_inputs[40]),.N165(all_inputs[41]),.N171(all_inputs[42]),.N177(all_inputs[43]),
    .N183(all_inputs[44]),.N189(all_inputs[45]),.N195(all_inputs[46]),.N201(all_inputs[47]),
    .N207(all_inputs[48]),.N210(all_inputs[49]),.N219(all_inputs[50]),.N228(all_inputs[51]),
    .N237(all_inputs[52]),.N246(all_inputs[53]),.N255(all_inputs[54]),.N259(all_inputs[55]),
    .N260(all_inputs[56]),.N261(all_inputs[57]),.N267(all_inputs[58]),.N268(all_inputs[59]),

    .N388(all_outputs[0]), .N389(all_outputs[1]), .N390(all_outputs[2]), .N391(all_outputs[3]),
    .N418(all_outputs[4]), .N419(all_outputs[5]), .N420(all_outputs[6]), .N421(all_outputs[7]),
    .N422(all_outputs[8]), .N423(all_outputs[9]), .N446(all_outputs[10]),.N447(all_outputs[11]),
    .N448(all_outputs[12]),.N449(all_outputs[13]),.N450(all_outputs[14]),.N767(all_outputs[15]),
    .N768(all_outputs[16]),.N850(all_outputs[17]),.N863(all_outputs[18]),.N864(all_outputs[19]),
    .N865(all_outputs[20]),.N866(all_outputs[21]),.N874(all_outputs[22]),.N878(all_outputs[23]),
    .N879(all_outputs[24]),.N880(all_outputs[25])
  );

  initial begin  
    file_handle = $fopen("hasil_c880.txt","w");
    if (file_handle == 0) begin
      $display("error: file tidak bisa dibuka!");
      $finish;
    end

    $fdisplay(file_handle, "Waktu | Input | Output");
    $fdisplay(file_handle, "-----------------------------");
    my_seed = 12345; 
    
    all_inputs = 60'h0; 
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);

    all_inputs = 60'hAAAA_AAAA_AAAA__AAA;
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);

    all_inputs = { 60{1'b1} }; 
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);
    
    for (i=0; i<61; i=i+1) begin
      all_inputs = { $random(my_seed), $random(my_seed) } & { 60{1'b1} };
      $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);
      #10;
    end
  end
endmodule