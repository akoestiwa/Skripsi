module tb_c5315();
  reg [177:0] all_inputs;
  wire [122:0] all_outputs;
  integer i,file_handle, my_seed;

  c5315 uut (
    all_inputs[0],  all_inputs[1],  all_inputs[2],  all_inputs[3],  all_inputs[4],  all_inputs[5],  all_inputs[6],  all_inputs[7],  all_inputs[8],  all_inputs[9],
    all_inputs[10], all_inputs[11], all_inputs[12], all_inputs[13], all_inputs[14], all_inputs[15], all_inputs[16], all_inputs[17], all_inputs[18], all_inputs[19],
    all_inputs[20], all_inputs[21], all_inputs[22], all_inputs[23], all_inputs[24], all_inputs[25], all_inputs[26], all_inputs[27], all_inputs[28], all_inputs[29],
    all_inputs[30], all_inputs[31], all_inputs[32], all_inputs[33], all_inputs[34], all_inputs[35], all_inputs[36], all_inputs[37], all_inputs[38], all_inputs[39],
    all_inputs[40], all_inputs[41], all_inputs[42], all_inputs[43], all_inputs[44], all_inputs[45], all_inputs[46], all_inputs[47], all_inputs[48], all_inputs[49],
    all_inputs[50], all_inputs[51], all_inputs[52], all_inputs[53], all_inputs[54], all_inputs[55], all_inputs[56], all_inputs[57], all_inputs[58], all_inputs[59],
    all_inputs[60], all_inputs[61], all_inputs[62], all_inputs[63], all_inputs[64], all_inputs[65], all_inputs[66], all_inputs[67], all_inputs[68], all_inputs[69],
    all_inputs[70], all_inputs[71], all_inputs[72], all_inputs[73], all_inputs[74], all_inputs[75], all_inputs[76], all_inputs[77], all_inputs[78], all_inputs[79],
    all_inputs[80], all_inputs[81], all_inputs[82], all_inputs[83], all_inputs[84], all_inputs[85], all_inputs[86], all_inputs[87], all_inputs[88], all_inputs[89],
    all_inputs[90], all_inputs[91], all_inputs[92], all_inputs[93], all_inputs[94], all_inputs[95], all_inputs[96], all_inputs[97], all_inputs[98], all_inputs[99],
    all_inputs[100],all_inputs[101],all_inputs[102],all_inputs[103],all_inputs[104],all_inputs[105],all_inputs[106],all_inputs[107],all_inputs[108],all_inputs[109],
    all_inputs[110],all_inputs[111],all_inputs[112],all_inputs[113],all_inputs[114],all_inputs[115],all_inputs[116],all_inputs[117],all_inputs[118],all_inputs[119],
    all_inputs[120],all_inputs[121],all_inputs[122],all_inputs[123],all_inputs[124],all_inputs[125],all_inputs[126],all_inputs[127],all_inputs[128],all_inputs[129],
    all_inputs[130],all_inputs[131],all_inputs[132],all_inputs[133],all_inputs[134],all_inputs[135],all_inputs[136],all_inputs[137],all_inputs[138],all_inputs[139],
    all_inputs[140],all_inputs[141],all_inputs[142],all_inputs[143],all_inputs[144],all_inputs[145],all_inputs[146],all_inputs[147],all_inputs[148],all_inputs[149],
    all_inputs[150],all_inputs[151],all_inputs[152],all_inputs[153],all_inputs[154],all_inputs[155],all_inputs[156],all_inputs[157],all_inputs[158],all_inputs[159],
    all_inputs[160],all_inputs[161],all_inputs[162],all_inputs[163],all_inputs[164],all_inputs[165],all_inputs[166],all_inputs[167],all_inputs[168],all_inputs[169],
    all_inputs[170],all_inputs[171],all_inputs[172],all_inputs[173],all_inputs[174],all_inputs[175],all_inputs[176],all_inputs[177],
    
    all_outputs[0],  all_outputs[1],  all_outputs[2],  all_outputs[3],  all_outputs[4],  all_outputs[5],  all_outputs[6],  all_outputs[7],  all_outputs[8],  all_outputs[9],
    all_outputs[10], all_outputs[11], all_outputs[12], all_outputs[13], all_outputs[14], all_outputs[15], all_outputs[16], all_outputs[17], all_outputs[18], all_outputs[19],
    all_outputs[20], all_outputs[21], all_outputs[22], all_outputs[23], all_outputs[24], all_outputs[25], all_outputs[26], all_outputs[27], all_outputs[28], all_outputs[29],
    all_outputs[30], all_outputs[31], all_outputs[32], all_outputs[33], all_outputs[34], all_outputs[35], all_outputs[36], all_outputs[37], all_outputs[38], all_outputs[39],
    all_outputs[40], all_outputs[41], all_outputs[42], all_outputs[43], all_outputs[44], all_outputs[45], all_outputs[46], all_outputs[47], all_outputs[48], all_outputs[49],
    all_outputs[50], all_outputs[51], all_outputs[52], all_outputs[53], all_outputs[54], all_outputs[55], all_outputs[56], all_outputs[57], all_outputs[58], all_outputs[59],
    all_outputs[60], all_outputs[61], all_outputs[62], all_outputs[63], all_outputs[64], all_outputs[65], all_outputs[66], all_outputs[67], all_outputs[68], all_outputs[69],
    all_outputs[70], all_outputs[71], all_outputs[72], all_outputs[73], all_outputs[74], all_outputs[75], all_outputs[76], all_outputs[77], all_outputs[78], all_outputs[79],
    all_outputs[80], all_outputs[81], all_outputs[82], all_outputs[83], all_outputs[84], all_outputs[85], all_outputs[86], all_outputs[87], all_outputs[88], all_outputs[89],
    all_outputs[90], all_outputs[91], all_outputs[92], all_outputs[93], all_outputs[94], all_outputs[95], all_outputs[96], all_outputs[97], all_outputs[98], all_outputs[99],
    all_outputs[100],all_outputs[101],all_outputs[102],all_outputs[103],all_outputs[104],all_outputs[105],all_outputs[106],all_outputs[107],all_outputs[108],all_outputs[109],
    all_outputs[110],all_outputs[111],all_outputs[112],all_outputs[113],all_outputs[114],all_outputs[115],all_outputs[116],all_outputs[117],all_outputs[118],all_outputs[119],
    all_outputs[120],all_outputs[121],all_outputs[122]
  );

  initial begin  
    file_handle = $fopen("hasil_c5315.txt","w");
    if (file_handle == 0) begin
      $display("error: file tidak bisa dibuka!");
      $finish;
    end

    $fdisplay(file_handle, "Waktu | Input | Output");
    $fdisplay(file_handle, "-----------------------------");
    my_seed = 12345; 
    
    all_inputs = 178'h0; 
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);

    all_inputs = { 89{2'b10} };
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);

    all_inputs = { 178{1'b1} }; 
    #10;
    $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);
    
    for (i=0; i<61; i=i+1) begin
      all_inputs = { $random(my_seed), $random(my_seed) } & { 178{1'b1} };
      $fdisplay(file_handle, "%5t | %b | %b", $time, all_inputs, all_outputs);
      #10;
    end
  end
endmodule