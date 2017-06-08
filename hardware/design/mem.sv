module mem #(parameter n = 32,
  parameter logn = 6)(
  input logic clk,
  input logic [31:0] writeData,
  input logic [31:0] writeAddr,
  input logic [31:0] readAddr,
  output logic [31:0] readData
  );

  logic [31:0]memData[1:0][n-1:0][n-1:0];
  logic [n-1:0][n-1:0][31:0] outData;
  logic [n-1:0][n-1:0][logn-1:0][n-1:0][31:0] adds;
  logic [n-1:0][n-1:0][n-1:0][31:0] mults;
  
  initial begin
    $readmemh("memfile.dat",memData); // initialize memory
  end
  
  //  FIX THIS LATER!!! indexing is weird
  //always_ff @(posedge clk) begin
  //  memData[writeAddr] <= writeData;
  //end
  
  //assign readData = memData[readAddr];
  

  generate
	genvar i, j, k, l;
	  for(i = 0; i < n; i++) begin
      for(j = 0; j < n; j++) begin
        assign outData[2][i][j] = adds[i][j][logn-1][0];
        for(k = 0; k < n; k++) begin
          multiplier mult(memData[0][k][i],memData[1][j][k],mults[i][j][k]);
          assign adds[i][j][0][k] = mults[i][j][k];
          logic [31:0] TESTadds;
          assign TESTadds = adds[i][j][0][k];
        end
        for(k = 1; k < logn; k++) begin
          for(l = 0; l < n/(2**k); l++) begin
            assign adds[i][j][k][l] = adds[i][j][k-1][l*2] + adds[i][j][k-1][l*2+1];
            logic [31:0] TESTadds;
            assign TESTadds = adds[i][j][k][l];
          end
        end
      end
	  end
	endgenerate

endmodule