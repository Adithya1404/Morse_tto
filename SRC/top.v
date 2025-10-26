module morse_top(
input wire clk,
input wire rst,
input wire dot_inp, 
input wire dash_inp, 
input wire char_space_inp, 
input wire word_space_inp,
output reg [7:0]sout);


wire [2:0] trans_out;
wire [7:0] serial_out;



trans_fsm trans (.clk(clk),.rst(rst),.dot_inp(dot_inp),.dash_inp(dash_inp),.char_space_inp(char_space_inp),.word_space_inp(word_space_inp),.parallel_out(trans_out));

  rec_fsm rec(.clk(clk),.p_in(trans_out),.rst(rst),.s_out(serial_out));

always @(*) begin
sout = serial_out;
end
endmodule
