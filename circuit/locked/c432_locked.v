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

module c432_locked (N1,N4,N8,N11,N14,N17,N21,N24,N27,N30,
             N34,N37,N40,N43,N47,N50,N53,N56,N60,N63,
             N66,N69,N73,N76,N79,N82,N86,N89,N92,N95,
             N99,N102,N105,N108,N112,N115,N223,N329,N370,N421,
             N430,N431,N432, set,static_TK);

  input N1,N4,N8,N11,N14,N17,N21,N24,N27,N30,
        N34,N37,N40,N43,N47,N50,N53,N56,N60,N63,
        N66,N69,N73,N76,N79,N82,N86,N89,N92,N95,
        N99,N102,N105,N108,N112,N115;

  output N223,N329,N370,N421,N430,N431,N432;

  wire N118,N119,N122,N123,N126,N127,N130,N131,N134,N135,
       N138,N139,N142,N143,N146,N147,N150,N151,N154,N157,
       N158,N159,N162,N165,N168,N171,N174,N177,N180,N183,
       N184,N185,N186,N187,N188,N189,N190,N191,N192,N193,
       N194,N195,N196,N197,N198,N199,N203,N213,N224,N227,
       N230,N233,N236,N239,N242,N243,N246,N247,N250,N251,
       N254,N255,N256,N257,N258,N259,N260,N263,N264,N267,
       N270,N273,N276,N279,N282,N285,N288,N289,N290,N291,
       N292,N293,N294,N295,N296,N300,N301,N302,N303,N304,
       N305,N306,N307,N308,N309,N319,N330,N331,N332,N333,
       N334,N335,N336,N337,N338,N339,N340,N341,N342,N343,
       N344,N345,N346,N347,N348,N349,N350,N351,N352,N353,
       N354,N355,N356,N357,N360,N371,N372,N373,N374,N375,
       N376,N377,N378,N379,N380,N381,N386,N393,N399,N404,
       N407,N411,N414,N415,N416,N417,N418,N419,N420,N422,
       N425,N428,N429;
  
  // declare lock
  input [2:0] set;
  input [3:0] static_TK;

  wire N158_locked, N184_locked, N186_locked, N188_locked, N330_locked, N343_locked, N357_locked;

  not NOT1_1 (N118, N1);
  not NOT1_2 (N119, N4);
  not NOT1_3 (N122, N11);
  not NOT1_4 (N123, N17);
  not NOT1_5 (N126, N24);
  not NOT1_6 (N127, N30);
  not NOT1_7 (N130, N37);
  not NOT1_8 (N131, N43);
  not NOT1_9 (N134, N50);
  not NOT1_10 (N135, N56);
  not NOT1_11 (N138, N63);
  not NOT1_12 (N139, N69);
  not NOT1_13 (N142, N76);
  not NOT1_14 (N143, N82);
  not NOT1_15 (N146, N89);
  not NOT1_16 (N147, N95);
  not NOT1_17 (N150, N102);
  not NOT1_18 (N151, N108);
  nand NAND2_19 (N154, N118, N4);
  nor NOR2_20 (N157, N8, N119);
  nor NOR2_21 (N158, N14, N119);
  nand NAND2_22 (N159, N122, N17);
  nand NAND2_23 (N162, N126, N30);
  nand NAND2_24 (N165, N130, N43);
  nand NAND2_25 (N168, N134, N56);
  nand NAND2_26 (N171, N138, N69);
  nand NAND2_27 (N174, N142, N82);
  nand NAND2_28 (N177, N146, N95);
  nand NAND2_29 (N180, N150, N108);
  nor NOR2_30 (N183, N21, N123);
  nor NOR2_31 (N184, N27, N123);
  nor NOR2_32 (N185, N34, N127);
  nor NOR2_33 (N186, N40, N127);
  nor NOR2_34 (N187, N47, N131);
  nor NOR2_35 (N188, N53, N131);
  nor NOR2_36 (N189, N60, N135);
  nor NOR2_37 (N190, N66, N135);
  nor NOR2_38 (N191, N73, N139);
  nor NOR2_39 (N192, N79, N139);
  nor NOR2_40 (N193, N86, N143);
  nor NOR2_41 (N194, N92, N143);
  nor NOR2_42 (N195, N99, N147);
  nor NOR2_43 (N196, N105, N147);
  nor NOR2_44 (N197, N112, N151);
  nor NOR2_45 (N198, N115, N151);
  and AND9_46 (N199, N154, N159, N162, N165, N168, N171, N174, N177, N180);
  not NOT1_47 (N203, N199);
  not NOT1_48 (N213, N199);
  not NOT1_49 (N223, N199);
  xor XOR2_50 (N224, N203, N154);
  xor XOR2_51 (N227, N203, N159);
  xor XOR2_52 (N230, N203, N162);
  xor XOR2_53 (N233, N203, N165);
  xor XOR2_54 (N236, N203, N168);
  xor XOR2_55 (N239, N203, N171);
  nand NAND2_56 (N242, N1, N213);
  xor XOR2_57 (N243, N203, N174);
  nand NAND2_58 (N246, N213, N11);
  xor XOR2_59 (N247, N203, N177);
  nand NAND2_60 (N250, N213, N24);
  xor XOR2_61 (N251, N203, N180);
  nand NAND2_62 (N254, N213, N37);
  nand NAND2_63 (N255, N213, N50);
  nand NAND2_64 (N256, N213, N63);
  nand NAND2_65 (N257, N213, N76);
  nand NAND2_66 (N258, N213, N89);
  nand NAND2_67 (N259, N213, N102);
  nand NAND2_68 (N260, N224, N157);
  nand NAND2_69 (N263, N224, N158_locked);
  nand NAND2_70 (N264, N227, N183);
  nand NAND2_71 (N267, N230, N185);
  nand NAND2_72 (N270, N233, N187);
  nand NAND2_73 (N273, N236, N189);
  nand NAND2_74 (N276, N239, N191);
  nand NAND2_75 (N279, N243, N193);
  nand NAND2_76 (N282, N247, N195);
  nand NAND2_77 (N285, N251, N197);
  nand NAND2_78 (N288, N227, N184_locked);
  nand NAND2_79 (N289, N230, N186_locked);
  nand NAND2_80 (N290, N233, N188_locked);
  nand NAND2_81 (N291, N236, N190);
  nand NAND2_82 (N292, N239, N192);
  nand NAND2_83 (N293, N243, N194);
  nand NAND2_84 (N294, N247, N196);
  nand NAND2_85 (N295, N251, N198);
  and AND9_86 (N296, N260, N264, N267, N270, N273, N276, N279, N282, N285);
  not NOT1_87 (N300, N263);
  not NOT1_88 (N301, N288);
  not NOT1_89 (N302, N289);
  not NOT1_90 (N303, N290);
  not NOT1_91 (N304, N291);
  not NOT1_92 (N305, N292);
  not NOT1_93 (N306, N293);
  not NOT1_94 (N307, N294);
  not NOT1_95 (N308, N295);
  not NOT1_96 (N309, N296);
  not NOT1_97 (N319, N296);
  not NOT1_98 (N329, N296);
  xor XOR2_99 (N330, N309, N260);
  xor XOR2_100 (N331, N309, N264);
  xor XOR2_101 (N332, N309, N267);
  xor XOR2_102 (N333, N309, N270);
  nand NAND2_103 (N334, N8, N319);
  xor XOR2_104 (N335, N309, N273);
  nand NAND2_105 (N336, N319, N21);
  xor XOR2_106 (N337, N309, N276);
  nand NAND2_107 (N338, N319, N34);
  xor XOR2_108 (N339, N309, N279);
  nand NAND2_109 (N340, N319, N47);
  xor XOR2_110 (N341, N309, N282);
  nand NAND2_111 (N342, N319, N60);
  xor XOR2_112 (N343, N309, N285);
  nand NAND2_113 (N344, N319, N73);
  nand NAND2_114 (N345, N319, N86);
  nand NAND2_115 (N346, N319, N99);
  nand NAND2_116 (N347, N319, N112);
  nand NAND2_117 (N348, N330_locked, N300);
  nand NAND2_118 (N349, N331, N301);
  nand NAND2_119 (N350, N332, N302);
  nand NAND2_120 (N351, N333, N303);
  nand NAND2_121 (N352, N335, N304);
  nand NAND2_122 (N353, N337, N305);
  nand NAND2_123 (N354, N339, N306);
  nand NAND2_124 (N355, N341, N307);
  nand NAND2_125 (N356, N343_locked, N308);
  and AND9_126 (N357, N348, N349, N350, N351, N352, N353, N354, N355, N356);
  not NOT1_127 (N360, N357_locked);
  not NOT1_128 (N370, N357_locked);
  nand NAND2_129 (N371, N14, N360);
  nand NAND2_130 (N372, N360, N27);
  nand NAND2_131 (N373, N360, N40);
  nand NAND2_132 (N374, N360, N53);
  nand NAND2_133 (N375, N360, N66);
  nand NAND2_134 (N376, N360, N79);
  nand NAND2_135 (N377, N360, N92);
  nand NAND2_136 (N378, N360, N105);
  nand NAND2_137 (N379, N360, N115);
  nand NAND4_138 (N380, N4, N242, N334, N371);
  nand NAND4_139 (N381, N246, N336, N372, N17);
  nand NAND4_140 (N386, N250, N338, N373, N30);
  nand NAND4_141 (N393, N254, N340, N374, N43);
  nand NAND4_142 (N399, N255, N342, N375, N56);
  nand NAND4_143 (N404, N256, N344, N376, N69);
  nand NAND4_144 (N407, N257, N345, N377, N82);
  nand NAND4_145 (N411, N258, N346, N378, N95);
  nand NAND4_146 (N414, N259, N347, N379, N108);
  not NOT1_147 (N415, N380);
  and AND8_148 (N416, N381, N386, N393, N399, N404, N407, N411, N414);
  not NOT1_149 (N417, N393);
  not NOT1_150 (N418, N404);
  not NOT1_151 (N419, N407);
  not NOT1_152 (N420, N411);
  nor NOR2_153 (N421, N415, N416);
  nand NAND2_154 (N422, N386, N417);
  nand NAND4_155 (N425, N386, N393, N418, N399);
  nand NAND3_156 (N428, N399, N393, N419);
  nand NAND4_157 (N429, N386, N393, N407, N420);
  nand NAND4_158 (N430, N381, N386, N422, N399);
  nand NAND4_159 (N431, N381, N386, N425, N428);
  nand NAND4_160 (N432, N381, N422, N425, N429);

  // static dynamic lock
  xor static_lock_0 (N158_locked, N158, ~static_TK[0]);
  xor static_lock_1 (N184_locked, N184, static_TK[1]);
  xor static_lock_2 (N186_locked, N186, static_TK[2]);
  xor static_lock_3 (N188_locked, N188, ~static_TK[3]);
  xor dynamic_lock_0 (N330_locked, N330, ~set[0]);
  xor dynamic_lock_1 (N343_locked, N343, ~set[1]);
  xor dynamic_lock_2 (N357_locked, N357, ~set[2]);
endmodule

module test(
    input [35:0] all_inputs,
    output [6:0] all_outputs,
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

  c432_locked c432_locked_inst (
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
    .N430(all_outputs[4]), .N431(all_outputs[5]), .N432(all_outputs[6]),
    .set (set),       
    .static_TK (static_TK) 
  );
endmodule