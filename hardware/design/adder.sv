module adder(
  input logic [31:0] SrcA,
  input logic [31:0] SrcB,
  output logic [31:0] AddrResult
  );
  
  assign AddrResult = SrcA + SrcB;
  
endmodule
