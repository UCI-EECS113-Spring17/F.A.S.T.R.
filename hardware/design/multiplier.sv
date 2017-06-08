module multiplier #(parameter WIDTH = 32)(
  input logic [WIDTH-1:0] SrcA,
  input logic [WIDTH-1:0] SrcB,
  output logic [WIDTH-1:0] MultResult
  );
  
  logic [WIDTH-1:0][WIDTH-1:0] masks;
  logic [WIDTH-1:0][WIDTH-1:0] shifts;
    
  generate
	genvar k;
	  for(k = 0; k < WIDTH; k++) begin
	    assign masks[k] = SrcA & {WIDTH{SrcB[k]}};
	    assign shifts[k] = masks[k] << k;
	  end
	endgenerate
	
  logic [(WIDTH/ 2)-1:0][WIDTH-1:0] add1;
  logic [(WIDTH/ 4)-1:0][WIDTH-1:0] add2;
  logic [(WIDTH/ 8)-1:0][WIDTH-1:0] add3;
  logic [(WIDTH/16)-1:0][WIDTH-1:0] add4;
	
	generate
	//genvar k;
	  for(k = 0; k < WIDTH/2; k++) begin
	    assign add1[k] = shifts[2*k] + shifts[2*k+1];
	  end
	endgenerate
	
	generate
	//genvar k;
	  for(k = 0; k < WIDTH/4; k++) begin
	    assign add2[k] = add1[2*k] + add1[2*k+1];
	  end
	endgenerate
	
	generate
	//genvar k;
	  for(k = 0; k < WIDTH/8; k++) begin
	    assign add3[k] = add2[2*k] + add2[2*k+1];
	  end
	endgenerate
	
	generate
	//genvar k;
	  for(k = 0; k < WIDTH/16; k++) begin
	    assign add4[k] = add3[2*k] + add3[2*k+1];
	  end
	endgenerate
	
	assign MultResult = add4[0] + add4[1];
  
endmodule
