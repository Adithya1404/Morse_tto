module trans_fsm(
    dot_inp, 
    dash_inp, 
    char_space_inp, 
    word_space_inp,
    parallel_out, 
    clk,
    rst
);

input dot_inp;
input dash_inp;
input char_space_inp;
input word_space_inp;
input clk;
input rst;

reg [3:0] state = 4'b0000; 

output reg [2:0] parallel_out;


parameter [3:0] s_idle       = 4'b0000;
parameter [3:0] s_dot        = 4'b0001;
parameter [3:0] s_dash       = 4'b0010;

parameter [3:0] s_char_1     = 4'b0100;
parameter [3:0] s_char_2     = 4'b0101;
parameter [3:0] s_char_3     = 4'b0110;

parameter [3:0] s_word_1     = 4'b1000;
parameter [3:0] s_word_2     = 4'b1001;
parameter [3:0] s_word_3     = 4'b1010;
parameter [3:0] s_word_4     = 4'b1011;
parameter [3:0] s_word_5     = 4'b1100;
parameter [3:0] s_word_6     = 4'b1101;
parameter [3:0] s_word_7     = 4'b1110;


always@(posedge clk or negedge rst)
begin
    if(!rst) begin
        state <= s_idle;
        parallel_out <= 'd0;
    end
    else begin
        case(state)
            s_idle:
            begin
                parallel_out <= 3'b000; // Inter-element space
                if (dot_inp)
                    state <= s_dot;
                else if (dash_inp)
                    state <= s_dash;
                else if (char_space_inp)
                    state <= s_char_1; // Start the 3-cycle character space
                else if (word_space_inp)
                    state <= s_word_1; // Start the 7-cycle word space
                else
                    state <= s_idle;
            end

            // Single-cycle states for dot and dash
            s_dot:  begin parallel_out <= 3'b001; state <= s_idle; end
            s_dash: begin parallel_out <= 3'b010; state <= s_idle; end

            // --- Character Space Sequence (3 cycles) ---
            s_char_1: begin parallel_out <= 3'b000; state <= s_char_2; end
            s_char_2: begin parallel_out <= 3'b000; state <= s_char_3; end
            s_char_3: begin parallel_out <= 3'b011; state <= s_idle;   end // Return to idle

            // --- Word Space Sequence (7 cycles) ---
            s_word_1: begin parallel_out <= 3'b000; state <= s_word_2; end
            s_word_2: begin parallel_out <= 3'b000; state <= s_word_3; end
            s_word_3: begin parallel_out <= 3'b000; state <= s_word_4; end
            s_word_4: begin parallel_out <= 3'b000; state <= s_word_5; end
            s_word_5: begin parallel_out <= 3'b000; state <= s_word_6; end
            s_word_6: begin parallel_out <= 3'b000; state <= s_word_7; end
            s_word_7: begin parallel_out <= 3'b100; state <= s_idle;   end // Return to idle
            
            default:
                state <= s_idle;
        endcase
    end
end
endmodule
