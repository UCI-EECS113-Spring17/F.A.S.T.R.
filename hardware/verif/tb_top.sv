module tb_top();
    logic clk;
    logic reset;
    logic [31:0] Num1;
    logic [31:0] Num2;
    logic [31:0] Result;

    // instantiate device to be tested
    top dut(clk, reset, Num1, Num2, Result);

    // initialize test
    initial
    begin
        reset <= 1; # 22; reset <= 0;
    end

    // generate clock to sequence tests
    always
    begin
        clk <= 1; # 5; clk <= 0; # 5;
    end
    
    initial begin
    Num1 <= 687;
    Num2 <= 1245;
    
    #100;
    $display("%d x %d = %d",Num1,Num2,Result);
    #100;
    $finish;
    end
endmodule
