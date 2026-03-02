module tb_c1908();
  reg [32:0]  all_inputs;
  wire [24:0] all_outputs;
  integer i, my_seed;

  c1908 uut (
    .N1(all_inputs[0]),    .N4(all_inputs[1]),    .N7(all_inputs[2]),    .N10(all_inputs[3]),
    .N13(all_inputs[4]),   .N16(all_inputs[5]),   .N19(all_inputs[6]),   .N22(all_inputs[7]),
    .N25(all_inputs[8]),   .N28(all_inputs[9]),   .N31(all_inputs[10]),  .N34(all_inputs[11]),
    .N37(all_inputs[12]),  .N40(all_inputs[13]),  .N43(all_inputs[14]),  .N46(all_inputs[15]),
    .N49(all_inputs[16]),  .N53(all_inputs[17]),  .N56(all_inputs[18]),  .N60(all_inputs[19]),
    .N63(all_inputs[20]),  .N66(all_inputs[21]),  .N69(all_inputs[22]),  .N72(all_inputs[23]),
    .N76(all_inputs[24]),  .N79(all_inputs[25]),  .N82(all_inputs[26]),  .N85(all_inputs[27]),
    .N88(all_inputs[28]),  .N91(all_inputs[29]),  .N94(all_inputs[30]),  .N99(all_inputs[31]),
    .N104(all_inputs[32]),

    .N2753(all_outputs[0]),  .N2754(all_outputs[1]),  .N2755(all_outputs[2]),  .N2756(all_outputs[3]),
    .N2762(all_outputs[4]),  .N2767(all_outputs[5]),  .N2768(all_outputs[6]),  .N2779(all_outputs[7]),
    .N2780(all_outputs[8]),  .N2781(all_outputs[9]),  .N2782(all_outputs[10]), .N2783(all_outputs[11]),
    .N2784(all_outputs[12]), .N2785(all_outputs[13]), .N2786(all_outputs[14]), .N2787(all_outputs[15]),
    .N2811(all_outputs[16]), .N2886(all_outputs[17]), .N2887(all_outputs[18]), .N2888(all_outputs[19]),
    .N2889(all_outputs[20]), .N2890(all_outputs[21]), .N2891(all_outputs[22]), .N2892(all_outputs[23]),
    .N2899(all_outputs[24])
  );

  initial begin  
    my_seed = 12345;
    
    all_inputs = 33'h0;
    #10;
  
    all_inputs = {$random(my_seed), $random(my_seed)} & 33'h1_FFFF_FFFF; 
    #10;
    
    all_inputs = 33'h1_AAAA_AAAA;
    #10;

    all_inputs = 33'h1_FFFF_FFFF;
    #10;
  end
endmodule