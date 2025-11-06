`timescale 1ns / 1ps
module tb_display_top;
    reg clk;
    reg rst;
    reg dot_inp;
    reg dash_inp;
    reg char_space_inp;
    reg word_space_inp;
    wire [7:0] sout; 
    
    top dut (
        .clk(clk),
        .rst(rst),
        .dot_inp(dot_inp),
        .dash_inp(dash_inp),
        .char_space_inp(char_space_inp),
        .word_space_inp(word_space_inp),
        .sout(sout)
    );
  always #5 clk = ~clk;
    initial begin
    clk = 1; rst = 0;
        $display("TIME: %0t ns | TB: Starting Simulation", $time);
        dot_inp        = 0;
        dash_inp       = 0;
        char_space_inp = 0;
        word_space_inp = 0;
        #10;
        rst            = 1; 
        $display("TIME: %0t ns | TB: Reset complete. System is idle.", $time);
        #20; 
        // R
       dot_inp = 1; #10; dot_inp = 0; #10;
       dash_inp = 1; #10; dash_inp = 0; #10;
       dot_inp = 1; #10; dot_inp = 0; #10;
       char_space_inp = 1; #10; char_space_inp = 0; #50;
       //T
       dash_inp = 1; #10; dash_inp = 0; #10;
       char_space_inp = 1; #10; char_space_inp = 0; #50;
       //L
       dot_inp = 1; #10; dot_inp = 0; #10;
       dash_inp = 1; #10; dash_inp = 0; #10;
       dot_inp = 1; #10; dot_inp = 0; #10;
       dot_inp = 1; #10; dot_inp = 0; #10;
       char_space_inp = 1; #10; char_space_inp = 0; #50;
       word_space_inp = 1; #10;word_space_inp = 0;#80;
        
        //1
       dot_inp = 1; #10; dot_inp = 0; #10;
       dash_inp = 1; #10; dash_inp = 0; #10;
       dash_inp = 1; #10; dash_inp = 0; #10;
       dash_inp = 1; #10; dash_inp = 0; #10;
       dash_inp = 1; #10; dash_inp = 0; #10;
       char_space_inp = 1; #10; char_space_inp = 0; #50;
       word_space_inp = 1; #10;word_space_inp = 0;#80;
        $display("TIME: %0t ns | TB: Simulation finished.", $time);
        $finish;
    end

endmodule
