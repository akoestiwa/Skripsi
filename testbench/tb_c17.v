timescale 1ns / 1ps

module tb_c17();
  reg N1,N2,N3,N6,N7;
  wire N22,N23;
  integer i;

  c17 uut (
    .N1(N1), 
    .N2(N2), 
    .N3(N3), 
    .N6(N6), 
    .N7(N7), 
    .N22(N22), 
    .N23(N23)
  );

  initial begin
    {N1, N2, N3, N6, N7} = 5'b00000;

    for (i=0; i<32; i=i+1) begin
      {N1, N2, N3, N6, N7} = i; 
      #10;
    end
  end
endmodule