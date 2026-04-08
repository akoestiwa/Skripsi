module tb_c7552();
  reg [206:0] all_inputs;
  wire [107:0] all_outputs;
  integer i,file_handle, my_seed;

  c7552 uut (
    // Inputs (207 bit) - Dipetakan sesuai urutan definisi modul
    .N1(all_inputs[0]),     .N5(all_inputs[1]),     .N9(all_inputs[2]),     .N12(all_inputs[3]),
    .N15(all_inputs[4]),    .N18(all_inputs[5]),    .N23(all_inputs[6]),    .N26(all_inputs[7]),
    .N29(all_inputs[8]),    .N32(all_inputs[9]),    .N35(all_inputs[10]),   .N38(all_inputs[11]),
    .N41(all_inputs[12]),   .N44(all_inputs[13]),   .N47(all_inputs[14]),   .N50(all_inputs[15]),
    .N53(all_inputs[16]),   .N54(all_inputs[17]),   .N55(all_inputs[18]),   .N56(all_inputs[19]),
    .N57(all_inputs[20]),   .N58(all_inputs[21]),   .N59(all_inputs[22]),   .N60(all_inputs[23]),
    .N61(all_inputs[24]),   .N62(all_inputs[25]),   .N63(all_inputs[26]),   .N64(all_inputs[27]),
    .N65(all_inputs[28]),   .N66(all_inputs[29]),   .N69(all_inputs[30]),   .N70(all_inputs[31]),
    .N73(all_inputs[32]),   .N74(all_inputs[33]),   .N75(all_inputs[34]),   .N76(all_inputs[35]),
    .N77(all_inputs[36]),   .N78(all_inputs[37]),   .N79(all_inputs[38]),   .N80(all_inputs[39]),
    .N81(all_inputs[40]),   .N82(all_inputs[41]),   .N83(all_inputs[42]),   .N84(all_inputs[43]),
    .N85(all_inputs[44]),   .N86(all_inputs[45]),   .N87(all_inputs[46]),   .N88(all_inputs[47]),
    .N89(all_inputs[48]),   .N94(all_inputs[49]),   .N97(all_inputs[50]),   .N100(all_inputs[51]),
    .N103(all_inputs[52]),  .N106(all_inputs[53]),  .N109(all_inputs[54]),  .N110(all_inputs[55]),
    .N111(all_inputs[56]),  .N112(all_inputs[57]),  .N113(all_inputs[58]),  .N114(all_inputs[59]),
    .N115(all_inputs[60]),  .N118(all_inputs[61]),  .N121(all_inputs[62]),  .N124(all_inputs[63]),
    .N127(all_inputs[64]),  .N130(all_inputs[65]),  .N133(all_inputs[66]),  .N134(all_inputs[67]),
    .N135(all_inputs[68]),  .N138(all_inputs[69]),  .N141(all_inputs[70]),  .N144(all_inputs[71]),
    .N147(all_inputs[72]),  .N150(all_inputs[73]),  .N151(all_inputs[74]),  .N152(all_inputs[75]),
    .N153(all_inputs[76]),  .N154(all_inputs[77]),  .N155(all_inputs[78]),  .N156(all_inputs[79]),
    .N157(all_inputs[80]),  .N158(all_inputs[81]),  .N159(all_inputs[82]),  .N160(all_inputs[83]),
    .N161(all_inputs[84]),  .N162(all_inputs[85]),  .N163(all_inputs[86]),  .N164(all_inputs[87]),
    .N165(all_inputs[88]),  .N166(all_inputs[89]),  .N167(all_inputs[90]),  .N168(all_inputs[91]),
    .N169(all_inputs[92]),  .N170(all_inputs[93]),  .N171(all_inputs[94]),  .N172(all_inputs[95]),
    .N173(all_inputs[96]),  .N174(all_inputs[97]),  .N175(all_inputs[98]),  .N176(all_inputs[99]),
    .N177(all_inputs[100]), .N178(all_inputs[101]), .N179(all_inputs[102]), .N180(all_inputs[103]),
    .N181(all_inputs[104]), .N182(all_inputs[105]), .N183(all_inputs[106]), .N184(all_inputs[107]),
    .N185(all_inputs[108]), .N186(all_inputs[109]), .N187(all_inputs[110]), .N188(all_inputs[111]),
    .N189(all_inputs[112]), .N190(all_inputs[113]), .N191(all_inputs[114]), .N192(all_inputs[115]),
    .N193(all_inputs[116]), .N194(all_inputs[117]), .N195(all_inputs[118]), .N196(all_inputs[119]),
    .N197(all_inputs[120]), .N198(all_inputs[121]), .N199(all_inputs[122]), .N200(all_inputs[123]),
    .N201(all_inputs[124]), .N202(all_inputs[125]), .N203(all_inputs[126]), .N204(all_inputs[127]),
    .N205(all_inputs[128]), .N206(all_inputs[129]), .N207(all_inputs[130]), .N208(all_inputs[131]),
    .N209(all_inputs[132]), .N210(all_inputs[133]), .N211(all_inputs[134]), .N212(all_inputs[135]),
    .N213(all_inputs[136]), .N214(all_inputs[137]), .N215(all_inputs[138]), .N216(all_inputs[139]),
    .N217(all_inputs[140]), .N218(all_inputs[141]), .N219(all_inputs[142]), .N220(all_inputs[143]),
    .N221(all_inputs[144]), .N222(all_inputs[145]), .N223(all_inputs[146]), .N224(all_inputs[147]),
    .N225(all_inputs[148]), .N226(all_inputs[149]), .N227(all_inputs[150]), .N228(all_inputs[151]),
    .N229(all_inputs[152]), .N230(all_inputs[153]), .N231(all_inputs[154]), .N232(all_inputs[155]),
    .N233(all_inputs[156]), .N234(all_inputs[157]), .N235(all_inputs[158]), .N236(all_inputs[159]),
    .N237(all_inputs[160]), .N238(all_inputs[161]), .N239(all_inputs[162]), .N240(all_inputs[163]),
    .N242(all_inputs[164]), .N245(all_inputs[165]), .N248(all_inputs[166]), .N251(all_inputs[167]),
    .N254(all_inputs[168]), .N257(all_inputs[169]), .N260(all_inputs[170]), .N263(all_inputs[171]),
    .N267(all_inputs[172]), .N271(all_inputs[173]), .N274(all_inputs[174]), .N277(all_inputs[175]),
    .N280(all_inputs[176]), .N283(all_inputs[177]), .N286(all_inputs[178]), .N289(all_inputs[179]),
    .N293(all_inputs[180]), .N296(all_inputs[181]), .N299(all_inputs[182]), .N303(all_inputs[183]),
    .N307(all_inputs[184]), .N310(all_inputs[185]), .N313(all_inputs[186]), .N316(all_inputs[187]),
    .N319(all_inputs[188]), .N322(all_inputs[189]), .N325(all_inputs[190]), .N328(all_inputs[191]),
    .N331(all_inputs[192]), .N334(all_inputs[193]), .N337(all_inputs[194]), .N340(all_inputs[195]),
    .N343(all_inputs[196]), .N346(all_inputs[197]), .N349(all_inputs[198]), .N352(all_inputs[199]),
    .N355(all_inputs[200]), .N358(all_inputs[201]), .N361(all_inputs[202]), .N364(all_inputs[203]),
    .N367(all_inputs[204]), .N382(all_inputs[205]), .N241_I(all_inputs[206]),

    // Outputs (108 bit)
    .N387(all_outputs[0]),   .N388(all_outputs[1]),   .N478(all_outputs[2]),   .N482(all_outputs[3]),
    .N484(all_outputs[4]),   .N486(all_outputs[5]),   .N489(all_outputs[6]),   .N492(all_outputs[7]),
    .N501(all_outputs[8]),   .N505(all_outputs[9]),   .N507(all_outputs[10]),  .N509(all_outputs[11]),
    .N511(all_outputs[12]),  .N513(all_outputs[13]),  .N515(all_outputs[14]),  .N517(all_outputs[15]),
    .N519(all_outputs[16]),  .N535(all_outputs[17]),  .N537(all_outputs[18]),  .N539(all_outputs[19]),
    .N541(all_outputs[20]),  .N543(all_outputs[21]),  .N545(all_outputs[22]),  .N547(all_outputs[23]),
    .N549(all_outputs[24]),  .N551(all_outputs[25]),  .N553(all_outputs[26]),  .N556(all_outputs[27]),
    .N559(all_outputs[28]),  .N561(all_outputs[29]),  .N563(all_outputs[30]),  .N565(all_outputs[31]),
    .N567(all_outputs[32]),  .N569(all_outputs[33]),  .N571(all_outputs[34]),  .N573(all_outputs[35]),
    .N582(all_outputs[36]),  .N643(all_outputs[37]),  .N707(all_outputs[38]),  .N813(all_outputs[39]),
    .N881(all_outputs[40]),  .N882(all_outputs[41]),  .N883(all_outputs[42]),  .N884(all_outputs[43]),
    .N885(all_outputs[44]),  .N889(all_outputs[45]),  .N945(all_outputs[46]),  .N1110(all_outputs[47]),
    .N1111(all_outputs[48]), .N1112(all_outputs[49]), .N1113(all_outputs[50]), .N1114(all_outputs[51]),
    .N1489(all_outputs[52]), .N1490(all_outputs[53]), .N1781(all_outputs[54]), .N10025(all_outputs[55]),
    .N10101(all_outputs[56]),.N10102(all_outputs[57]),.N10103(all_outputs[58]),.N10104(all_outputs[59]),
    .N10109(all_outputs[60]),.N10110(all_outputs[61]),.N10111(all_outputs[62]),.N10112(all_outputs[63]),
    .N10350(all_outputs[64]),.N10351(all_outputs[65]),.N10352(all_outputs[66]),.N10353(all_outputs[67]),
    .N10574(all_outputs[68]),.N10575(all_outputs[69]),.N10576(all_outputs[70]),.N10628(all_outputs[71]),
    .N10632(all_outputs[72]),.N10641(all_outputs[73]),.N10704(all_outputs[74]),.N10706(all_outputs[75]),
    .N10711(all_outputs[76]),.N10712(all_outputs[77]),.N10713(all_outputs[78]),.N10714(all_outputs[79]),
    .N10715(all_outputs[80]),.N10716(all_outputs[81]),.N10717(all_outputs[82]),.N10718(all_outputs[83]),
    .N10729(all_outputs[84]),.N10759(all_outputs[85]),.N10760(all_outputs[86]),.N10761(all_outputs[87]),
    .N10762(all_outputs[88]),.N10763(all_outputs[89]),.N10827(all_outputs[90]),.N10837(all_outputs[91]),
    .N10838(all_outputs[92]),.N10839(all_outputs[93]),.N10840(all_outputs[94]),.N10868(all_outputs[95]),
    .N10869(all_outputs[96]),.N10870(all_outputs[97]),.N10871(all_outputs[98]),.N10905(all_outputs[99]),
    .N10906(all_outputs[100]),.N10907(all_outputs[101]),.N10908(all_outputs[102]),.N11333(all_outputs[103]),
    .N11334(all_outputs[104]),.N11340(all_outputs[105]),.N11342(all_outputs[106]),.N241_O(all_outputs[107])
  );

  initial begin  
    file_handle = $fopen("hasil_c7552.txt","w");
    if (file_handle == 0) begin
      $display("error: file tidak bisa dibuka!");
      $finish;
    end

    $fdisplay(file_handle, "Waktu | Input | Output");
    $fdisplay(file_handle, "-----------------------------");
    my_seed = 12345; 
    
    all_inputs = 207'h0; 
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);

    all_inputs = { {103{2'b10}},1'b1 }; 
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);

    all_inputs = { 207{1'b1} }; 
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);
    
    for (i=0; i<61; i=i+1) begin
      all_inputs = { $random(my_seed), $random(my_seed), $random(my_seed), 
                     $random(my_seed), $random(my_seed), $random(my_seed), 
                     $random(my_seed) };
      $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);
      #10;
    end
  end
endmodule