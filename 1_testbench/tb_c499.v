module tb_c499();
  reg [40:0] all_inputs;
  wire [31:0] all_outputs;
  integer i, my_seed;

  c499 uut (
    .N1(all_inputs[0]),   .N5(all_inputs[1]),   .N9(all_inputs[2]),   .N13(all_inputs[3]),
    .N17(all_inputs[4]),  .N21(all_inputs[5]),  .N25(all_inputs[6]),  .N29(all_inputs[7]),
    .N33(all_inputs[8]),  .N37(all_inputs[9]),  .N41(all_inputs[10]), .N45(all_inputs[11]),
    .N49(all_inputs[12]), .N53(all_inputs[13]), .N57(all_inputs[14]), .N61(all_inputs[15]),
    .N65(all_inputs[16]), .N69(all_inputs[17]), .N73(all_inputs[18]), .N77(all_inputs[19]),
    .N81(all_inputs[20]), .N85(all_inputs[21]), .N89(all_inputs[22]), .N93(all_inputs[23]),
    .N97(all_inputs[24]), .N101(all_inputs[25]), .N105(all_inputs[26]), .N109(all_inputs[27]),
    .N113(all_inputs[28]), .N117(all_inputs[29]), .N121(all_inputs[30]), .N125(all_inputs[31]),
    .N129(all_inputs[32]), .N130(all_inputs[33]), .N131(all_inputs[34]), .N132(all_inputs[35]),
    .N133(all_inputs[36]), .N134(all_inputs[37]), .N135(all_inputs[38]), .N136(all_inputs[39]),
    .N137(all_inputs[40]),

    .N724(all_outputs[0]),  .N725(all_outputs[1]),  .N726(all_outputs[2]),  .N727(all_outputs[3]),
    .N728(all_outputs[4]),  .N729(all_outputs[5]),  .N730(all_outputs[6]),  .N731(all_outputs[7]),
    .N732(all_outputs[8]),  .N733(all_outputs[9]),  .N734(all_outputs[10]), .N735(all_outputs[11]),
    .N736(all_outputs[12]), .N737(all_outputs[13]), .N738(all_outputs[14]), .N739(all_outputs[15]),
    .N740(all_outputs[16]), .N741(all_outputs[17]), .N742(all_outputs[18]), .N743(all_outputs[19]),
    .N744(all_outputs[20]), .N745(all_outputs[21]), .N746(all_outputs[22]), .N747(all_outputs[23]),
    .N748(all_outputs[24]), .N749(all_outputs[25]), .N750(all_outputs[26]), .N751(all_outputs[27]),
    .N752(all_outputs[28]), .N753(all_outputs[29]), .N754(all_outputs[30]), .N755(all_outputs[31])
  );

  initial begin
    my_seed = 12345;
    all_inputs = {41{1'b0}};
    #10;

    all_inputs = {$random(my_seed), $random(my_seed)} & {41{1'b1}};
    #10;

    all_inputs = 41'hAAAA_AAAA_AA;
    #10;

    all_inputs = {41{1'b1}};
    #10;
  end
endmodule