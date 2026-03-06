module tb_c2670();
  reg [232:0] all_inputs;
  wire [139:0] all_outputs;
  
  integer i, my_seed;

  c2670 uut (
    .N1(all_inputs[0]),     .N2(all_inputs[1]),     .N3(all_inputs[2]),     .N4(all_inputs[3]),
    .N5(all_inputs[4]),     .N6(all_inputs[5]),     .N7(all_inputs[6]),     .N8(all_inputs[7]),
    .N11(all_inputs[8]),    .N14(all_inputs[9]),    .N15(all_inputs[10]),   .N16(all_inputs[11]),
    .N19(all_inputs[12]),   .N20(all_inputs[13]),   .N21(all_inputs[14]),   .N22(all_inputs[15]),
    .N23(all_inputs[16]),   .N24(all_inputs[17]),   .N25(all_inputs[18]),   .N26(all_inputs[19]),
    .N27(all_inputs[20]),   .N28(all_inputs[21]),   .N29(all_inputs[22]),   .N32(all_inputs[23]),
    .N33(all_inputs[24]),   .N34(all_inputs[25]),   .N35(all_inputs[26]),   .N36(all_inputs[27]),
    .N37(all_inputs[28]),   .N40(all_inputs[29]),   .N43(all_inputs[30]),   .N44(all_inputs[31]),
    .N47(all_inputs[32]),   .N48(all_inputs[33]),   .N49(all_inputs[34]),   .N50(all_inputs[35]),
    .N51(all_inputs[36]),   .N52(all_inputs[37]),   .N53(all_inputs[38]),   .N54(all_inputs[39]),
    .N55(all_inputs[40]),   .N56(all_inputs[41]),   .N57(all_inputs[42]),   .N60(all_inputs[43]),
    .N61(all_inputs[44]),   .N62(all_inputs[45]),   .N63(all_inputs[46]),   .N64(all_inputs[47]),
    .N65(all_inputs[48]),   .N66(all_inputs[49]),   .N67(all_inputs[50]),   .N68(all_inputs[51]),
    .N69(all_inputs[52]),   .N72(all_inputs[53]),   .N73(all_inputs[54]),   .N74(all_inputs[55]),
    .N75(all_inputs[56]),   .N76(all_inputs[57]),   .N77(all_inputs[58]),   .N78(all_inputs[59]),
    .N79(all_inputs[60]),   .N80(all_inputs[61]),   .N81(all_inputs[62]),   .N82(all_inputs[63]),
    .N85(all_inputs[64]),   .N86(all_inputs[65]),   .N87(all_inputs[66]),   .N88(all_inputs[67]),
    .N89(all_inputs[68]),   .N90(all_inputs[69]),   .N91(all_inputs[70]),   .N92(all_inputs[71]),
    .N93(all_inputs[72]),   .N94(all_inputs[73]),   .N95(all_inputs[74]),   .N96(all_inputs[75]),
    .N99(all_inputs[76]),   .N100(all_inputs[77]),  .N101(all_inputs[78]),  .N102(all_inputs[79]),
    .N103(all_inputs[80]),  .N104(all_inputs[81]),  .N105(all_inputs[82]),  .N106(all_inputs[83]),
    .N107(all_inputs[84]),  .N108(all_inputs[85]),  .N111(all_inputs[86]),  .N112(all_inputs[87]),
    .N113(all_inputs[88]),  .N114(all_inputs[89]),  .N115(all_inputs[90]),  .N116(all_inputs[91]),
    .N117(all_inputs[92]),  .N118(all_inputs[93]),  .N119(all_inputs[94]),  .N120(all_inputs[95]),
    .N123(all_inputs[96]),  .N124(all_inputs[97]),  .N125(all_inputs[98]),  .N126(all_inputs[99]),
    .N127(all_inputs[100]), .N128(all_inputs[101]), .N129(all_inputs[102]), .N130(all_inputs[103]),
    .N131(all_inputs[104]), .N132(all_inputs[105]), .N135(all_inputs[106]), .N136(all_inputs[107]),
    .N137(all_inputs[108]), .N138(all_inputs[109]), .N139(all_inputs[110]), .N140(all_inputs[111]),
    .N141(all_inputs[112]), .N142(all_inputs[113]), .N219(all_inputs[114]), .N224(all_inputs[115]),
    .N227(all_inputs[116]), .N230(all_inputs[117]), .N231(all_inputs[118]), .N234(all_inputs[119]),
    .N237(all_inputs[120]), .N241(all_inputs[121]), .N246(all_inputs[122]), .N253(all_inputs[123]),
    .N256(all_inputs[124]), .N259(all_inputs[125]), .N262(all_inputs[126]), .N263(all_inputs[127]),
    .N266(all_inputs[128]), .N269(all_inputs[129]), .N272(all_inputs[130]), .N275(all_inputs[131]),
    .N278(all_inputs[132]), .N281(all_inputs[133]), .N284(all_inputs[134]), .N287(all_inputs[135]),
    .N290(all_inputs[136]), .N294(all_inputs[137]), .N297(all_inputs[138]), .N301(all_inputs[139]),
    .N305(all_inputs[140]), .N309(all_inputs[141]), .N313(all_inputs[142]), .N316(all_inputs[143]),
    .N319(all_inputs[144]), .N322(all_inputs[145]), .N325(all_inputs[146]), .N328(all_inputs[147]),
    .N331(all_inputs[148]), .N334(all_inputs[149]), .N337(all_inputs[150]), .N340(all_inputs[151]),
    .N343(all_inputs[152]), .N346(all_inputs[153]), .N349(all_inputs[154]), .N352(all_inputs[155]),
    .N355(all_inputs[156]), 
    .N143_I(all_inputs[157]), .N144_I(all_inputs[158]), .N145_I(all_inputs[159]), .N146_I(all_inputs[160]),
    .N147_I(all_inputs[161]), .N148_I(all_inputs[162]), .N149_I(all_inputs[163]), .N150_I(all_inputs[164]),
    .N151_I(all_inputs[165]), .N152_I(all_inputs[166]), .N153_I(all_inputs[167]), .N154_I(all_inputs[168]),
    .N155_I(all_inputs[169]), .N156_I(all_inputs[170]), .N157_I(all_inputs[171]), .N158_I(all_inputs[172]),
    .N159_I(all_inputs[173]), .N160_I(all_inputs[174]), .N161_I(all_inputs[175]), .N162_I(all_inputs[176]),
    .N163_I(all_inputs[177]), .N164_I(all_inputs[178]), .N165_I(all_inputs[179]), .N166_I(all_inputs[180]),
    .N167_I(all_inputs[181]), .N168_I(all_inputs[182]), .N169_I(all_inputs[183]), .N170_I(all_inputs[184]),
    .N171_I(all_inputs[185]), .N172_I(all_inputs[186]), .N173_I(all_inputs[187]), .N174_I(all_inputs[188]),
    .N175_I(all_inputs[189]), .N176_I(all_inputs[190]), .N177_I(all_inputs[191]), .N178_I(all_inputs[192]),
    .N179_I(all_inputs[193]), .N180_I(all_inputs[194]), .N181_I(all_inputs[195]), .N182_I(all_inputs[196]),
    .N183_I(all_inputs[197]), .N184_I(all_inputs[198]), .N185_I(all_inputs[199]), .N186_I(all_inputs[200]),
    .N187_I(all_inputs[201]), .N188_I(all_inputs[202]), .N189_I(all_inputs[203]), .N190_I(all_inputs[204]),
    .N191_I(all_inputs[205]), .N192_I(all_inputs[206]), .N193_I(all_inputs[207]), .N194_I(all_inputs[208]),
    .N195_I(all_inputs[209]), .N196_I(all_inputs[210]), .N197_I(all_inputs[211]), .N198_I(all_inputs[212]),
    .N199_I(all_inputs[213]), .N200_I(all_inputs[214]), .N201_I(all_inputs[215]), .N202_I(all_inputs[216]),
    .N203_I(all_inputs[217]), .N204_I(all_inputs[218]), .N205_I(all_inputs[219]), .N206_I(all_inputs[220]),
    .N207_I(all_inputs[221]), .N208_I(all_inputs[222]), .N209_I(all_inputs[223]), .N210_I(all_inputs[224]),
    .N211_I(all_inputs[225]), .N212_I(all_inputs[226]), .N213_I(all_inputs[227]), .N214_I(all_inputs[228]),
    .N215_I(all_inputs[229]), .N216_I(all_inputs[230]), .N217_I(all_inputs[231]), .N218_I(all_inputs[232]),

    .N398(all_outputs[0]),   .N400(all_outputs[1]),   .N401(all_outputs[2]),   .N419(all_outputs[3]),
    .N420(all_outputs[4]),   .N456(all_outputs[5]),   .N457(all_outputs[6]),   .N458(all_outputs[7]),
    .N487(all_outputs[8]),   .N488(all_outputs[9]),   .N489(all_outputs[10]),  .N490(all_outputs[11]),
    .N491(all_outputs[12]),  .N492(all_outputs[13]),  .N493(all_outputs[14]),  .N494(all_outputs[15]),
    .N792(all_outputs[16]),  .N799(all_outputs[17]),  .N805(all_outputs[18]),  .N1026(all_outputs[19]),
    .N1028(all_outputs[20]), .N1029(all_outputs[21]), .N1269(all_outputs[22]), .N1277(all_outputs[23]),
    .N1448(all_outputs[24]), .N1726(all_outputs[25]), .N1816(all_outputs[26]), .N1817(all_outputs[27]),
    .N1818(all_outputs[28]), .N1819(all_outputs[29]), .N1820(all_outputs[30]), .N1821(all_outputs[31]),
    .N1969(all_outputs[32]), .N1970(all_outputs[33]), .N1971(all_outputs[34]), .N2010(all_outputs[35]),
    .N2012(all_outputs[36]), .N2014(all_outputs[37]), .N2016(all_outputs[38]), .N2018(all_outputs[39]),
    .N2020(all_outputs[40]), .N2022(all_outputs[41]), .N2387(all_outputs[42]), .N2388(all_outputs[43]),
    .N2389(all_outputs[44]), .N2390(all_outputs[45]), .N2496(all_outputs[46]), .N2643(all_outputs[47]),
    .N2644(all_outputs[48]), .N2891(all_outputs[49]), .N2925(all_outputs[50]), .N2970(all_outputs[51]),
    .N2971(all_outputs[52]), .N3038(all_outputs[53]), .N3079(all_outputs[54]), .N3546(all_outputs[55]),
    .N3671(all_outputs[56]), .N3803(all_outputs[57]), .N3804(all_outputs[58]), .N3809(all_outputs[59]),
    .N3851(all_outputs[60]), .N3875(all_outputs[61]), .N3881(all_outputs[62]), .N3882(all_outputs[63]),
    .N143_O(all_outputs[64]), .N144_O(all_outputs[65]), .N145_O(all_outputs[66]), .N146_O(all_outputs[67]),
    .N147_O(all_outputs[68]), .N148_O(all_outputs[69]), .N149_O(all_outputs[70]), .N150_O(all_outputs[71]),
    .N151_O(all_outputs[72]), .N152_O(all_outputs[73]), .N153_O(all_outputs[74]), .N154_O(all_outputs[75]),
    .N155_O(all_outputs[76]), .N156_O(all_outputs[77]), .N157_O(all_outputs[78]), .N158_O(all_outputs[79]),
    .N159_O(all_outputs[80]), .N160_O(all_outputs[81]), .N161_O(all_outputs[82]), .N162_O(all_outputs[83]),
    .N163_O(all_outputs[84]), .N164_O(all_outputs[85]), .N165_O(all_outputs[86]), .N166_O(all_outputs[87]),
    .N167_O(all_outputs[88]), .N168_O(all_outputs[89]), .N169_O(all_outputs[90]), .N170_O(all_outputs[91]),
    .N171_O(all_outputs[92]), .N172_O(all_outputs[93]), .N173_O(all_outputs[94]), .N174_O(all_outputs[95]),
    .N175_O(all_outputs[96]), .N176_O(all_outputs[97]), .N177_O(all_outputs[98]), .N178_O(all_outputs[99]),
    .N179_O(all_outputs[100]),.N180_O(all_outputs[101]),.N181_O(all_outputs[102]),.N182_O(all_outputs[103]),
    .N183_O(all_outputs[104]),.N184_O(all_outputs[105]),.N185_O(all_outputs[106]),.N186_O(all_outputs[107]),
    .N187_O(all_outputs[108]),.N188_O(all_outputs[109]),.N189_O(all_outputs[110]),.N190_O(all_outputs[111]),
    .N191_O(all_outputs[112]),.N192_O(all_outputs[113]),.N193_O(all_outputs[114]),.N194_O(all_outputs[115]),
    .N195_O(all_outputs[116]),.N196_O(all_outputs[117]),.N197_O(all_outputs[118]),.N198_O(all_outputs[119]),
    .N199_O(all_outputs[120]),.N200_O(all_outputs[121]),.N201_O(all_outputs[122]),.N202_O(all_outputs[123]),
    .N203_O(all_outputs[124]),.N204_O(all_outputs[125]),.N205_O(all_outputs[126]),.N206_O(all_outputs[127]),
    .N207_O(all_outputs[128]),.N208_O(all_outputs[129]),.N209_O(all_outputs[130]),.N210_O(all_outputs[131]),
    .N211_O(all_outputs[132]),.N212_O(all_outputs[133]),.N213_O(all_outputs[134]),.N214_O(all_outputs[135]),
    .N215_O(all_outputs[136]),.N216_O(all_outputs[137]),.N217_O(all_outputs[138]),.N218_O(all_outputs[139])
  );

  initial begin
    my_seed = 12345;
    
    all_inputs = 233'h0; #10;
    all_inputs = {233{1'b1}}; #10;

    for (i = 0; i < 97; i = i + 1) begin
      all_inputs = { 
        $random(my_seed), $random(my_seed), $random(my_seed), $random(my_seed),
        $random(my_seed), $random(my_seed), $random(my_seed), $random(my_seed) 
      } & {233{1'b1}};
      #10;
    end
  end

endmodule