module top#(parameter n = 10)(
    input  logic clk, reset,
    input  logic [31:0] inA,
    input  logic [31:0] inB,
    output logic [31:0] Result
    );
    
    logic [31:0] SrcA, SrcB, Res;
    
    always_ff @(posedge clk) begin
      SrcA <= inA;
      SrcB <= inB;
      
      Result <= Res;
    end
    
    mem matrixData();
    
    multiplier mult(SrcA, SrcB, Res);
endmodule
