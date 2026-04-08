module tb_c1335();
  reg [40:0] all_inputs;
  wire [31:0] all_outputs;
  integer i,file_handle, my_seed;

  c1335 uut (
    .N1(all_inputs[0]),   .N8(all_inputs[1]),   .N15(all_inputs[2]),  .N22(all_inputs[3]),
    .N29(all_inputs[4]),  .N36(all_inputs[5]),  .N43(all_inputs[6]),  .N50(all_inputs[7]),
    .N57(all_inputs[8]),  .N64(all_inputs[9]),  .N71(all_inputs[10]), .N78(all_inputs[11]),
    .N85(all_inputs[12]), .N92(all_inputs[13]), .N99(all_inputs[14]), .N106(all_inputs[15]),
    .N113(all_inputs[16]),.N120(all_inputs[17]),.N127(all_inputs[18]),.N134(all_inputs[19]),
    .N141(all_inputs[20]),.N148(all_inputs[21]),.N155(all_inputs[22]),.N162(all_inputs[23]),
    .N169(all_inputs[24]),.N176(all_inputs[25]),.N183(all_inputs[26]),.N190(all_inputs[27]),
    .N197(all_inputs[28]),.N204(all_inputs[29]),.N211(all_inputs[30]),.N218(all_inputs[31]),
    .N225(all_inputs[32]),.N226(all_inputs[33]),.N227(all_inputs[34]),.N228(all_inputs[35]),
    .N229(all_inputs[36]),.N230(all_inputs[37]),.N231(all_inputs[38]),.N232(all_inputs[39]),
    .N233(all_inputs[40]),

    .N1324(all_outputs[0]), .N1325(all_outputs[1]), .N1326(all_outputs[2]), .N1327(all_outputs[3]),
    .N1328(all_outputs[4]), .N1329(all_outputs[5]), .N1330(all_outputs[6]), .N1331(all_outputs[7]),
    .N1332(all_outputs[8]), .N1333(all_outputs[9]), .N1334(all_outputs[10]),.N1335(all_outputs[11]),
    .N1336(all_outputs[12]),.N1337(all_outputs[13]),.N1338(all_outputs[14]),.N1339(all_outputs[15]),
    .N1340(all_outputs[16]),.N1341(all_outputs[17]),.N1342(all_outputs[18]),.N1343(all_outputs[19]),
    .N1344(all_outputs[20]),.N1345(all_outputs[21]),.N1346(all_outputs[22]),.N1347(all_outputs[23]),
    .N1348(all_outputs[24]),.N1349(all_outputs[25]),.N1350(all_outputs[26]),.N1351(all_outputs[27]),
    .N1352(all_outputs[28]),.N1353(all_outputs[29]),.N1354(all_outputs[30]),.N1355(all_outputs[31])
  );

  initial begin  
    file_handle = $fopen("hasil_c1335.txt","w");
    if (file_handle == 0) begin
      $display("error: file tidak bisa dibuka!");
      $finish;
    end

    $fdisplay(file_handle, "Waktu | Input | Output");
    $fdisplay(file_handle, "-----------------------------");
    my_seed = 12345; 
    
    all_inputs = 41'h0; 
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);

    all_inputs = 41'b1010_1010_1010_1010_1010_1010_1010_1010_1010_1010_1;
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);

    all_inputs = { 41{1'b1} }; 
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);
    
    for (i=0; i<61; i=i+1) begin
      all_inputs = { $random(my_seed), $random(my_seed) } & { 41{1'b1} };
      $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);
      #10;
    end
  end
endmodule