module c17_locked ( N1,N2,N3,N6,N7,N22,N23, set,static_TK );
  input N1,N2,N3,N6,N7;
  output N22,N23;

  wire N10,N11,N16,N19;

  input set;
  input [3:0] static_TK;

  wire N11_locked, N6_locked, N7_locked;
  
  xor static_lock_0 (N6_locked, N6, static_TK[1:0]);
  nand NAND2_1 (N10, N1, N3);
  nand NAND2_2 (N11, N3, N6_locked);
  
  xor dynamic_lock (N11_locked, N11, ~set);
  nand NAND2_3 (N16, N2, N11_locked);

  xor static_lock_1 (N7_locked, N7, static_TK[3:2]);
  nand NAND2_4 (N19, N11_locked, N7_locked);
  
  nand NAND2_5 (N22, N10, N16);
  nand NAND2_6 (N23, N16, N19);
endmodule

module top_module (
    input N1, N2, N3, N6, N7,
    output N22, N23,

    input [3:0] static_K, 
    input [11:0]  dynamic_K,
    input         clk, rst_n
  );

  wire set;
  wire [3:0] static_TK;
  dylock_16 dylock_inst (
    .dynamic_K (dynamic_K),
    .static_K (static_K),
    .clk (clk),
    .rst_n (rst_n),
    .static_TK (static_TK),
    .set (set)
  );

  c17_locked c17_locked_inst (
    .N1 (N1), 
    .N2 (N2),
    .N3 (N3),
    .N6 (N6),
    .N7 (N7),
    .N22 (N22),
    .N23 (N23),
    .set (set),       
    .static_TK (static_TK) 
  );
endmodule

/*
Node ID  | Type   | CC0   | CC1   | CO   
----------------------------------------
1        | PI     | 1     | 1     | 5    
2        | PI     | 1     | 1     | 6    
3        | PI     | 1     | 1     | 5    
6        | PI     | 1     | 1     | 7       static[2] & static[3]
7        | PI     | 1     | 1     | 6       static[0] & static[1]
10       | NAND   | 3     | 2     | 3       
11       | NAND   | 3     | 2     | 5       dynamic 
16       | NAND   | 4     | 2     | 3    
19       | NAND   | 4     | 2     | 3    
22       | NAND   | 5     | 4     | 0    
23       | NAND   | 5     | 5     | 0    
*/