module Keyboard_control(clk, rst, key_down, last_change, been_ready, falling, left, right);
    input wire [511:0] key_down;
    input wire [8:0] last_change;
    input wire been_ready;
    input wire clk, rst;
    
    output reg falling, left, right;
    reg next_falling, next_left, next_right;
    //keyboard input
    parameter [8:0] ENTER_CODES  = 9'b0_0101_1010; // enter => 5A
    parameter [8:0] KEY_CODES_A  = 9'b0_0001_1100; // A => 1C
    parameter [8:0] KEY_CODES_D  = 9'b0_0010_0011; // D => 23

    // always @(posedge clk) begin
    //     if(rst) begin
    //         falling <= 1'b0;
    //         left <= 1'b0;
    //         right <= 1'b0;
    //     end
    //     else begin
    //         falling <= next_falling;
    //         left <= next_left;
    //         right <= next_right;
    //     end
    // end 

    always @(*) begin
        if(been_ready && key_down[last_change] == 1'b1) begin
            if(last_change == ENTER_CODES) begin
                falling = 1'b1;
            end
            else begin
                falling = 1'b0;
            end

            if(last_change == KEY_CODES_A) begin
                left = 1'b1;
            end
            else begin
                left = 1'b0;
            end

            if(last_change == KEY_CODES_D) begin
                right = 1'b1;
            end
            else begin
                right = 1'b0;
            end

        end
        else begin
            falling = 1'b0;
            left = 1'b0;
            right = 1'b0;
        end
    end

endmodule