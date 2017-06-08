module shifter
  #(parameter amt = 0)
  (input logic [31:0] in,
  output logic [31:0] out
  );
  
  assign out = in << amt;
  
endmodule
