`timescale 1ns / 1ps

module tb_c3540();
  reg [49:0] all_inputs;
  wire [21:0] all_outputs;
  
  integer i, my_seed;

  c3540 uut (
    .N1(all_inputs[0]),     .N13(all_inputs[1]),    .N20(all_inputs[2]),    .N33(all_inputs[3]),
    .N41(all_inputs[4]),    .N45(all_inputs[5]),    .N50(all_inputs[6]),    .N58(all_inputs[7]),
    .N68(all_inputs[8]),    .N77(all_inputs[9]),    .N87(all_inputs[10]),   .N97(all_inputs[11]),
    .N107(all_inputs[12]),  .N116(all_inputs[13]),  .N124(all_inputs[14]),  .N125(all_inputs[15]),
    .N128(all_inputs[16]),  .N132(all_inputs[17]),  .N137(all_inputs[18]),  .N143(all_inputs[19]),
    .N150(all_inputs[20]),  .N159(all_inputs[21]),  .N169(all_inputs[22]),  .N179(all_inputs[23]),
    .N190(all_inputs[24]),  .N200(all_inputs[25]),  .N213(all_inputs[26]),  .N222(all_inputs[27]),
    .N223(all_inputs[28]),  .N226(all_inputs[29]),  .N232(all_inputs[30]),  .N238(all_inputs[31]),
    .N244(all_inputs[32]),  .N250(all_inputs[33]),  .N257(all_inputs[34]),  .N264(all_inputs[35]),
    .N270(all_inputs[36]),  .N274(all_inputs[37]),  .N283(all_inputs[38]),  .N294(all_inputs[39]),
    .N303(all_inputs[40]),  .N311(all_inputs[41]),  .N317(all_inputs[42]),  .N322(all_inputs[43]),
    .N326(all_inputs[44]),  .N329(all_inputs[45]),  .N330(all_inputs[46]),  .N343(all_inputs[47]),
    .N349(all_inputs[48]),  .N350(all_inputs[49]),

    .N1713(all_outputs[0]), .N1947(all_outputs[1]), .N3195(all_outputs[2]), .N3833(all_outputs[3]),
    .N3987(all_outputs[4]), .N4028(all_outputs[5]), .N4145(all_outputs[6]), .N4589(all_outputs[7]),
    .N4667(all_outputs[8]), .N4815(all_outputs[9]), .N4944(all_outputs[10]),.N5002(all_outputs[11]),
    .N5045(all_outputs[12]),.N5047(all_outputs[13]),.N5078(all_outputs[14]),.N5102(all_outputs[15]),
    .N5120(all_outputs[16]),.N5121(all_outputs[17]),.N5192(all_outputs[18]),.N5231(all_outputs[19]),
    .N5360(all_outputs[20]),.N5361(all_outputs[21])
  );

  initial begin
    my_seed = 12345;
    
    all_inputs = 50'h0; #10;
    all_inputs = 50'h2AAAAAAAAAAAA; #10;
    all_inputs = 50'h3FFFFFFFFFFFF; #10;

    for (i = 0; i < 97; i = i + 1) begin
      all_inputs = { $random(my_seed), $random(my_seed) } & 50'h3FFFFFFFFFFFF;
      #20;
    end
  end
endmodule