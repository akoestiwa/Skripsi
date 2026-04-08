module nonlinear_gen ( K, TK );
  input   [3:0] K;
  output  [3:0] TK;
  
  assign TK[0] =  (K[3] & ~K[0]) | 
                  (K[1] & K[2] & K[3]) | 
                  (K[0] & K[2] & ~K[3]) | 
                  (K[3] & ~K[1] & ~K[2]);

  assign TK[1] =  (K[0] & K[2] & K[3]) | 
                  (K[0] & K[3] & ~K[1]) | 
                  (K[1] & ~K[0] & ~K[2]) | 
                  (K[1] & ~K[2] & ~K[3]) | 
                  (K[2] & ~K[0] & ~K[1]);

  assign TK[2] =  (K[0] & K[2] & K[3]) | 
                  (K[0] & ~K[1] & ~K[3]) | 
                  (K[1] & ~K[0] & ~K[3]) | 
                  (K[3] & ~K[0] & ~K[2]);

  assign TK[3] =  (K[0] & K[2] & ~K[1]) | 
                  (K[0] & K[3] & ~K[1]) | 
                  (K[1] & K[2] & ~K[0]) | 
                  (K[1] & K[3] & ~K[0]) | 
                  (K[0] & K[1] & ~K[2] & ~K[3]) | 
                  (~K[0] & ~K[1] & ~K[2] & ~K[3]);		
endmodule

module dylock ( K, key, clk, rst_n, set );
  input   [3:0]  K, key;
  input          clk, rst_n;
  output         set;
  
  wire    [3:0] TK;
  reg     [3:0] count;
   
  nonlinear_gen keygen (
      .K(K),
	    .TK(TK)
  );
    
  always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
			  count <= 4'd0;
      end 
			else begin
        if ( TK == key ) begin
          if (count < 4'd12)
            count <= count + 1'b1;
          else
            count <= count;
          end 
        else
          count <= 4'd0; 
			end
  end
  assign set = (count == 4'd12);
endmodule

module dylock_16 ( static_K, dynamic_K, key, clk, rst_n, static_TK, set);
  input   [3:0]   static_K;
  input   [11:0]  dynamic_K, key;
  input           clk, rst_n;
  output  [3:0]   static_TK;
  output  [2:0]        set;

  wire    [11:0]  dynamic_TK;

  genvar i;
	generate
		for (i=0; i<3; i=i+1) begin : dylock_mul
			dylock dylock_3 (
        .K (dynamic_K [(i*4)+3 : i*4]),
        .key (key [(i*4)+3 : i*4]),
        .clk (clk),
        .rst_n (rst_n),
        .set (set [i])
			);
		end
	endgenerate

  assign static_TK = static_K;
endmodule

module c499_locked (N1,N5,N9,N13,N17,N21,N25,N29,N33,N37,
             N41,N45,N49,N53,N57,N61,N65,N69,N73,N77,
             N81,N85,N89,N93,N97,N101,N105,N109,N113,N117,
             N121,N125,N129,N130,N131,N132,N133,N134,N135,N136,
             N137,N724,N725,N726,N727,N728,N729,N730,N731,N732,
             N733,N734,N735,N736,N737,N738,N739,N740,N741,N742,
             N743,N744,N745,N746,N747,N748,N749,N750,N751,N752,
             N753,N754,N755, set, static_TK);

  input N1,N5,N9,N13,N17,N21,N25,N29,N33,N37,
        N41,N45,N49,N53,N57,N61,N65,N69,N73,N77,
        N81,N85,N89,N93,N97,N101,N105,N109,N113,N117,
        N121,N125,N129,N130,N131,N132,N133,N134,N135,N136,
        N137;

  output N724,N725,N726,N727,N728,N729,N730,N731,N732,N733,
         N734,N735,N736,N737,N738,N739,N740,N741,N742,N743,
         N744,N745,N746,N747,N748,N749,N750,N751,N752,N753,
         N754,N755;

  wire N250,N251,N252,N253,N254,N255,N256,N257,N258,N259,
       N260,N261,N262,N263,N264,N265,N266,N267,N268,N269,
       N270,N271,N272,N273,N274,N275,N276,N277,N278,N279,
       N280,N281,N282,N283,N284,N285,N286,N287,N288,N289,
       N290,N293,N296,N299,N302,N305,N308,N311,N314,N315,
       N316,N317,N318,N319,N320,N321,N338,N339,N340,N341,
       N342,N343,N344,N345,N346,N347,N348,N349,N350,N351,
       N352,N353,N354,N367,N380,N393,N406,N419,N432,N445,
       N554,N555,N556,N557,N558,N559,N560,N561,N562,N563,
       N564,N565,N566,N567,N568,N569,N570,N571,N572,N573,
       N574,N575,N576,N577,N578,N579,N580,N581,N582,N583,
       N584,N585,N586,N587,N588,N589,N590,N591,N592,N593,
       N594,N595,N596,N597,N598,N599,N600,N601,N602,N607,
       N620,N625,N630,N635,N640,N645,N650,N655,N692,N693,
       N694,N695,N696,N697,N698,N699,N700,N701,N702,N703,
       N704,N705,N706,N707,N708,N709,N710,N711,N712,N713,
       N714,N715,N716,N717,N718,N719,N720,N721,N722,N723;

  // declare lock
  input [2:0] set;
  input [3:0] static_TK;

  wire N554_locked, N556_locked, N574_locked, N576_locked, N594_locked, N602_locked, N692_locked;

  xor XOR2_1 (N250, N1, N5);
  xor XOR2_2 (N251, N9, N13);
  xor XOR2_3 (N252, N17, N21);
  xor XOR2_4 (N253, N25, N29);
  xor XOR2_5 (N254, N33, N37);
  xor XOR2_6 (N255, N41, N45);
  xor XOR2_7 (N256, N49, N53);
  xor XOR2_8 (N257, N57, N61);
  xor XOR2_9 (N258, N65, N69);
  xor XOR2_10 (N259, N73, N77);
  xor XOR2_11 (N260, N81, N85);
  xor XOR2_12 (N261, N89, N93);
  xor XOR2_13 (N262, N97, N101);
  xor XOR2_14 (N263, N105, N109);
  xor XOR2_15 (N264, N113, N117);
  xor XOR2_16 (N265, N121, N125);
  and AND2_17 (N266, N129, N137);
  and AND2_18 (N267, N130, N137);
  and AND2_19 (N268, N131, N137);
  and AND2_20 (N269, N132, N137);
  and AND2_21 (N270, N133, N137);
  and AND2_22 (N271, N134, N137);
  and AND2_23 (N272, N135, N137);
  and AND2_24 (N273, N136, N137);
  xor XOR2_25 (N274, N1, N17);
  xor XOR2_26 (N275, N33, N49);
  xor XOR2_27 (N276, N5, N21);
  xor XOR2_28 (N277, N37, N53);
  xor XOR2_29 (N278, N9, N25);
  xor XOR2_30 (N279, N41, N57);
  xor XOR2_31 (N280, N13, N29);
  xor XOR2_32 (N281, N45, N61);
  xor XOR2_33 (N282, N65, N81);
  xor XOR2_34 (N283, N97, N113);
  xor XOR2_35 (N284, N69, N85);
  xor XOR2_36 (N285, N101, N117);
  xor XOR2_37 (N286, N73, N89);
  xor XOR2_38 (N287, N105, N121);
  xor XOR2_39 (N288, N77, N93);
  xor XOR2_40 (N289, N109, N125);
  xor XOR2_41 (N290, N250, N251);
  xor XOR2_42 (N293, N252, N253);
  xor XOR2_43 (N296, N254, N255);
  xor XOR2_44 (N299, N256, N257);
  xor XOR2_45 (N302, N258, N259);
  xor XOR2_46 (N305, N260, N261);
  xor XOR2_47 (N308, N262, N263);
  xor XOR2_48 (N311, N264, N265);
  xor XOR2_49 (N314, N274, N275);
  xor XOR2_50 (N315, N276, N277);
  xor XOR2_51 (N316, N278, N279);
  xor XOR2_52 (N317, N280, N281);
  xor XOR2_53 (N318, N282, N283);
  xor XOR2_54 (N319, N284, N285);
  xor XOR2_55 (N320, N286, N287);
  xor XOR2_56 (N321, N288, N289);
  xor XOR2_57 (N338, N290, N293);
  xor XOR2_58 (N339, N296, N299);
  xor XOR2_59 (N340, N290, N296);
  xor XOR2_60 (N341, N293, N299);
  xor XOR2_61 (N342, N302, N305);
  xor XOR2_62 (N343, N308, N311);
  xor XOR2_63 (N344, N302, N308);
  xor XOR2_64 (N345, N305, N311);
  xor XOR2_65 (N346, N266, N342);
  xor XOR2_66 (N347, N267, N343);
  xor XOR2_67 (N348, N268, N344);
  xor XOR2_68 (N349, N269, N345);
  xor XOR2_69 (N350, N270, N338);
  xor XOR2_70 (N351, N271, N339);
  xor XOR2_71 (N352, N272, N340);
  xor XOR2_72 (N353, N273, N341);
  xor XOR2_73 (N354, N314, N346);
  xor XOR2_74 (N367, N315, N347);
  xor XOR2_75 (N380, N316, N348);
  xor XOR2_76 (N393, N317, N349);
  xor XOR2_77 (N406, N318, N350);
  xor XOR2_78 (N419, N319, N351);
  xor XOR2_79 (N432, N320, N352);
  xor XOR2_80 (N445, N321, N353);
  not NOT1_81 (N554, N354);
  not NOT1_82 (N555, N367);
  not NOT1_83 (N556, N380);
  not NOT1_84 (N557, N354);
  not NOT1_85 (N558, N367);
  not NOT1_86 (N559, N393);
  not NOT1_87 (N560, N354);
  not NOT1_88 (N561, N380);
  not NOT1_89 (N562, N393);
  not NOT1_90 (N563, N367);
  not NOT1_91 (N564, N380);
  not NOT1_92 (N565, N393);
  not NOT1_93 (N566, N419);
  not NOT1_94 (N567, N445);
  not NOT1_95 (N568, N419);
  not NOT1_96 (N569, N432);
  not NOT1_97 (N570, N406);
  not NOT1_98 (N571, N445);
  not NOT1_99 (N572, N406);
  not NOT1_100 (N573, N432);
  not NOT1_101 (N574, N406);
  not NOT1_102 (N575, N419);
  not NOT1_103 (N576, N432);
  not NOT1_104 (N577, N406);
  not NOT1_105 (N578, N419);
  not NOT1_106 (N579, N445);
  not NOT1_107 (N580, N406);
  not NOT1_108 (N581, N432);
  not NOT1_109 (N582, N445);
  not NOT1_110 (N583, N419);
  not NOT1_111 (N584, N432);
  not NOT1_112 (N585, N445);
  not NOT1_113 (N586, N367);
  not NOT1_114 (N587, N393);
  not NOT1_115 (N588, N367);
  not NOT1_116 (N589, N380);
  not NOT1_117 (N590, N354);
  not NOT1_118 (N591, N393);
  not NOT1_119 (N592, N354);
  not NOT1_120 (N593, N380);
  and AND4_121 (N594, N554_locked, N555, N556_locked, N393);
  and AND4_122 (N595, N557, N558, N380, N559);
  and AND4_123 (N596, N560, N367, N561, N562);
  and AND4_124 (N597, N354, N563, N564, N565);
  and AND4_125 (N598, N574_locked, N575, N576_locked, N445);
  and AND4_126 (N599, N577, N578, N432, N579);
  and AND4_127 (N600, N580, N419, N581, N582);
  and AND4_128 (N601, N406, N583, N584, N585);
  or OR4_129 (N602, N594_locked, N595, N596, N597);
  or OR4_130 (N607, N598, N599, N600, N601);
  and AND5_131 (N620, N406, N566, N432, N567, N602_locked);
  and AND5_132 (N625, N406, N568, N569, N445, N602_locked);
  and AND5_133 (N630, N570, N419, N432, N571, N602_locked);
  and AND5_134 (N635, N572, N419, N573, N445, N602_locked);
  and AND5_135 (N640, N354, N586, N380, N587, N607);
  and AND5_136 (N645, N354, N588, N589, N393, N607);
  and AND5_137 (N650, N590, N367, N380, N591, N607);
  and AND5_138 (N655, N592, N367, N593, N393, N607);
  and AND2_139 (N692, N354, N620);
  and AND2_140 (N693, N367, N620);
  and AND2_141 (N694, N380, N620);
  and AND2_142 (N695, N393, N620);
  and AND2_143 (N696, N354, N625);
  and AND2_144 (N697, N367, N625);
  and AND2_145 (N698, N380, N625);
  and AND2_146 (N699, N393, N625);
  and AND2_147 (N700, N354, N630);
  and AND2_148 (N701, N367, N630);
  and AND2_149 (N702, N380, N630);
  and AND2_150 (N703, N393, N630);
  and AND2_151 (N704, N354, N635);
  and AND2_152 (N705, N367, N635);
  and AND2_153 (N706, N380, N635);
  and AND2_154 (N707, N393, N635);
  and AND2_155 (N708, N406, N640);
  and AND2_156 (N709, N419, N640);
  and AND2_157 (N710, N432, N640);
  and AND2_158 (N711, N445, N640);
  and AND2_159 (N712, N406, N645);
  and AND2_160 (N713, N419, N645);
  and AND2_161 (N714, N432, N645);
  and AND2_162 (N715, N445, N645);
  and AND2_163 (N716, N406, N650);
  and AND2_164 (N717, N419, N650);
  and AND2_165 (N718, N432, N650);
  and AND2_166 (N719, N445, N650);
  and AND2_167 (N720, N406, N655);
  and AND2_168 (N721, N419, N655);
  and AND2_169 (N722, N432, N655);
  and AND2_170 (N723, N445, N655);
  xor XOR2_171 (N724, N1, N692_locked);
  xor XOR2_172 (N725, N5, N693);
  xor XOR2_173 (N726, N9, N694);
  xor XOR2_174 (N727, N13, N695);
  xor XOR2_175 (N728, N17, N696);
  xor XOR2_176 (N729, N21, N697);
  xor XOR2_177 (N730, N25, N698);
  xor XOR2_178 (N731, N29, N699);
  xor XOR2_179 (N732, N33, N700);
  xor XOR2_180 (N733, N37, N701);
  xor XOR2_181 (N734, N41, N702);
  xor XOR2_182 (N735, N45, N703);
  xor XOR2_183 (N736, N49, N704);
  xor XOR2_184 (N737, N53, N705);
  xor XOR2_185 (N738, N57, N706);
  xor XOR2_186 (N739, N61, N707);
  xor XOR2_187 (N740, N65, N708);
  xor XOR2_188 (N741, N69, N709);
  xor XOR2_189 (N742, N73, N710);
  xor XOR2_190 (N743, N77, N711);
  xor XOR2_191 (N744, N81, N712);
  xor XOR2_192 (N745, N85, N713);
  xor XOR2_193 (N746, N89, N714);
  xor XOR2_194 (N747, N93, N715);
  xor XOR2_195 (N748, N97, N716);
  xor XOR2_196 (N749, N101, N717);
  xor XOR2_197 (N750, N105, N718);
  xor XOR2_198 (N751, N109, N719);
  xor XOR2_199 (N752, N113, N720);
  xor XOR2_200 (N753, N117, N721);
  xor XOR2_201 (N754, N121, N722);
  xor XOR2_202 (N755, N125, N723);

  // static dynamic lock
  xor static_lock_0 (N554_locked, N554, ~static_TK[0]);
  xor static_lock_1 (N556_locked, N556, static_TK[1]);
  xor static_lock_2 (N574_locked, N574, static_TK[2]);
  xor static_lock_3 (N576_locked, N576, ~static_TK[3]);
  xor dynamic_lock_0 (N594_locked, N594, ~set[0]);
  xor dynamic_lock_1 (N602_locked, N602, ~set[1]);
  xor dynamic_lock_2 (N692_locked, N692, ~set[2]);
endmodule

module top_c499_locked(
    input [40:0] all_inputs,
    output [31:0] all_outputs,
    input [3:0]  static_K,
    input [11:0] dynamic_K, key,
    input        clk, rst_n
  );
  
  wire [2:0] set;
  wire [3:0] static_TK;

  dylock_16 dylock_inst (
    .dynamic_K (dynamic_K),
    .static_K (static_K),
    .key (key),
    .clk (clk),
    .rst_n (rst_n),
    .static_TK (static_TK),
    .set (set)
  );

  c499_locked c499_locked_inst (
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
    .N752(all_outputs[28]), .N753(all_outputs[29]), .N754(all_outputs[30]), .N755(all_outputs[31]),
    .set (set),       
    .static_TK (static_TK) 
  );
endmodule