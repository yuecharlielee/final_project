`include "global.v"

module player_control(clk, rst, falling, left, right, test_falling, test_left, test_right, 
    x_0, x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9, 
    y_0, y_1, y_2, y_3, y_4, y_5, y_6, y_7, y_8, y_9, 
    s_0, s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9,
    finish
    );
    input clk, rst, falling, left, right, test_falling, test_left, test_right;

    parameter size_1 = 10'd5, size_2 = 10'd10, size_3 = 10'd15, size_4 = 10'd20; 

    output reg [11:0] x_0, x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9;
    output reg [11:0] y_0, y_1, y_2, y_3, y_4, y_5, y_6, y_7, y_8, y_9;
    output reg [11:0] s_0, s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9;

    reg [11:0] next_x_0, next_x_1, next_x_2, next_x_3, next_x_4, next_x_5, next_x_6, next_x_7, next_x_8, next_x_9;
    reg [11:0] next_y_0, next_y_1, next_y_2, next_y_3, next_y_4, next_y_5, next_y_6, next_y_7, next_y_8, next_y_9; 
    reg [11:0] next_s_0, next_s_1, next_s_2, next_s_3, next_s_4, next_s_5, next_s_6, next_s_7, next_s_8, next_s_9;
    reg [11:0] next_x_pos, next_y_pos;
    reg [11:0] x_pos, y_pos;

    reg [9:0] counter, next_counter;
    
    reg [3:0] state, next_state;

    reg [11:0] ball_size, next_ball_size;

    output wire finish;
    assign finish = (counter == 10'd10) ? 1 : 0;
    //parameter falling_State = 4'd0, select_State = 4'd1;

    always @(posedge clk) begin

        if(rst) begin
            counter <= 10'd0;
            state <= `select_state;

            x_pos <= 10'd170;
            y_pos <= 10'd50;
            s_0 <= `ball_size_3;
            
            x_1 <= `start_pos_x;
            y_1 <= `start_pos_y;
            s_1 <= `ball_size_0;

            x_2 <= `start_pos_x;
            y_2 <= `start_pos_y;
            s_2 <= `ball_size_0;

            x_3 <= `start_pos_x;
            y_3 <= `start_pos_y;
            s_3 <= `ball_size_0;

            x_4 <= `start_pos_x;
            y_4 <= `start_pos_y;
            s_4 <= `ball_size_0;

            x_5 <= `start_pos_x;
            y_5 <= `start_pos_y;
            s_5 <= `ball_size_0;

            x_6 <= `start_pos_x;
            y_6 <= `start_pos_y;
            s_6 <= `ball_size_0;

            x_7 <= `start_pos_x;
            y_7 <= `start_pos_y;
            s_7 <= `ball_size_0;

            x_8 <= `start_pos_x;
            y_8 <= `start_pos_y;
            s_8 <= `ball_size_0;

            x_9 <= `start_pos_x;
            y_9 <= `start_pos_y;
            s_9 <= `ball_size_0;

            x_pos <= 10'd170;
            y_pos <= `up_bound;

        end
        else begin
            x_0 <= next_x_0;
            y_0 <= next_y_0;
            s_0 <= next_s_0;
            x_1 <= next_x_1;
            y_1 <= next_y_1;
            s_1 <= next_s_1;
            x_2 <= next_x_2;
            y_2 <= next_y_2;
            s_2 <= next_s_2;
            x_3 <= next_x_3;
            y_3 <= next_y_3;
            s_3 <= next_s_3;
            x_4 <= next_x_4;
            y_4 <= next_y_4;
            s_4 <= next_s_4;
            x_5 <= next_x_5;
            y_5 <= next_y_5;
            s_5 <= next_s_5;
            x_6 <= next_x_6;
            y_6 <= next_y_6;
            s_6 <= next_s_6;
            x_7 <= next_x_7;
            y_7 <= next_y_7;
            s_7 <= next_s_7;
            x_8 <= next_x_8;
            y_8 <= next_y_8;
            s_8 <= next_s_8;
            x_9 <= next_x_9;
            y_9 <= next_y_9;
            s_9 <= next_s_9;
            state <= next_state;
            counter <= next_counter;

            x_pos <= next_x_pos;
            y_pos <= next_y_pos;

        end
    end

    always @(*) begin
        case(state)
            `select_state:begin
                next_y_pos = `up_bound - ball_size;
                if(falling == 1'b1 || test_falling == 1'b1) begin
                    next_state = `falling_state;
                    next_x_pos = x_pos;
                end
                else begin
                    next_state = `select_state;
                    if(left == 1'b1 || test_left == 1'b1) begin
                        if(x_pos == `left_bound + ball_size) begin
                            next_x_pos = x_pos;
                        end
                        else begin
                            next_x_pos = x_pos - 1;
                        end
                    end
                    else begin
                        if(right == 1'b1 || test_right == 1'b1) begin
                            if(x_pos == `right_bound - ball_size) begin
                                next_x_pos = x_pos;
                            end
                            else begin
                                next_x_pos = x_pos + 1;
                            end
                        end
                        else begin
                            next_x_pos = x_pos;
                        end
                    end
                end
                next_counter = counter;
            end
            `falling_state: begin
                next_x_pos = x_pos;
                if(y_pos < 10'd240 - ball_size) begin
                    next_state = `falling_state;
                    if(y_pos + 10'd3 < 10'd240  - ball_size) begin
                        next_y_pos = y_pos + 10'd3; 
                    end
                    else begin
                        next_y_pos = 10'd240  - ball_size; 
                    end
                end
                else begin
                    next_state = `finish_state;                 
                    next_y_pos = y_pos; 
                end
                next_counter = counter;
            end
            default: begin
                next_state = `select_state;
                next_x_pos = 10'd170;
                next_counter = counter + 1;
                next_y_pos = `up_bound - ball_size;
            end
        endcase
    end


    always @(*) begin
        case(counter)
            10'd0:begin
                next_x_0 = x_pos;
                next_y_0 = y_pos;
                next_x_1 = x_1;
                next_y_1 = y_1;
                next_x_2 = x_2;
                next_y_2 = y_2;
                next_x_3 = x_3;
                next_y_3 = y_3;
                next_x_4 = x_4;
                next_y_4 = y_4;
                next_x_5 = x_5;
                next_y_5 = y_5;
                next_x_6 = x_6;
                next_y_6 = y_6;
                next_x_7 = x_7;
                next_y_7 = y_7;
                next_x_8 = x_8;
                next_y_8 = y_8;
                next_x_9 = x_9;
                next_y_9 = y_9;
            end
            10'd1:begin
                next_x_0 = x_0;
                next_y_0 = y_0;
                next_x_1 = x_pos;
                next_y_1 = y_pos;
                next_x_2 = x_2;
                next_y_2 = y_2;
                next_x_3 = x_3;
                next_y_3 = y_3;
                next_x_4 = x_4;
                next_y_4 = y_4;
                next_x_5 = x_5;
                next_y_5 = y_5;
                next_x_6 = x_6;
                next_y_6 = y_6;
                next_x_7 = x_7;
                next_y_7 = y_7;
                next_x_8 = x_8;
                next_y_8 = y_8;
                next_x_9 = x_9;
                next_y_9 = y_9;
            end
            10'd2:begin
                next_x_0 = x_0;
                next_y_0 = y_0;
                next_x_1 = x_1;
                next_y_1 = y_1;
                next_x_2 = x_pos;
                next_y_2 = y_pos;
                next_x_3 = x_3;
                next_y_3 = y_3;
                next_x_4 = x_4;
                next_y_4 = y_4;
                next_x_5 = x_5;
                next_y_5 = y_5;
                next_x_6 = x_6;
                next_y_6 = y_6;
                next_x_7 = x_7;
                next_y_7 = y_7;
                next_x_8 = x_8;
                next_y_8 = y_8;
                next_x_9 = x_9;
                next_y_9 = y_9;
            end
            10'd3:begin
                next_x_0 = x_0;
                next_y_0 = y_0;
                next_x_1 = x_1;
                next_y_1 = y_1;
                next_x_2 = x_2;
                next_y_2 = y_2;
                next_x_3 = x_pos;
                next_y_3 = y_pos;
                next_x_4 = x_4;
                next_y_4 = y_4;
                next_x_5 = x_5;
                next_y_5 = y_5;
                next_x_6 = x_6;
                next_y_6 = y_6;
                next_x_7 = x_7;
                next_y_7 = y_7;
                next_x_8 = x_8;
                next_y_8 = y_8;
                next_x_9 = x_9;
                next_y_9 = y_9;
            end
            10'd4:begin
                next_x_0 = x_0;
                next_y_0 = y_0;
                next_x_1 = x_1;
                next_y_1 = y_1;
                next_x_2 = x_2;
                next_y_2 = y_2;
                next_x_3 = x_3;
                next_y_3 = y_3;
                next_x_4 = x_pos;
                next_y_4 = y_pos;
                next_x_5 = x_5;
                next_y_5 = y_5;
                next_x_6 = x_6;
                next_y_6 = y_6;
                next_x_7 = x_7;
                next_y_7 = y_7;
                next_x_8 = x_8;
                next_y_8 = y_8;
                next_x_9 = x_9;
                next_y_9 = y_9;
            end
            10'd5:begin
                next_x_0 = x_0;
                next_y_0 = y_0;
                next_x_1 = x_1;
                next_y_1 = y_1;
                next_x_2 = x_2;
                next_y_2 = y_2;
                next_x_3 = x_3;
                next_y_3 = y_3;
                next_x_4 = x_4;
                next_y_4 = y_4;
                next_x_5 = x_pos;
                next_y_5 = y_pos;
                next_x_6 = x_6;
                next_y_6 = y_6;
                next_x_7 = x_7;
                next_y_7 = y_7;
                next_x_8 = x_8;
                next_y_8 = y_8;
                next_x_9 = x_9;
                next_y_9 = y_9;
            end
            10'd6:begin
                next_x_0 = x_0;
                next_y_0 = y_0;
                next_x_1 = x_1;
                next_y_1 = y_1;
                next_x_2 = x_2;
                next_y_2 = y_2;
                next_x_3 = x_3;
                next_y_3 = y_3;
                next_x_4 = x_4;
                next_y_4 = y_4;
                next_x_5 = x_5;
                next_y_5 = y_5;
                next_x_6 = x_pos;
                next_y_6 = y_pos;
                next_x_7 = x_7;
                next_y_7 = y_7;
                next_x_8 = x_8;
                next_y_8 = y_8;
                next_x_9 = x_9;
                next_y_9 = y_9;
            end
            10'd7:begin
                next_x_0 = x_0;
                next_y_0 = y_0;
                next_x_1 = x_1;
                next_y_1 = y_1;
                next_x_2 = x_2;
                next_y_2 = y_2;
                next_x_3 = x_3;
                next_y_3 = y_3;
                next_x_4 = x_4;
                next_y_4 = y_4;
                next_x_5 = x_5;
                next_y_5 = y_5;
                next_x_6 = x_6;
                next_y_6 = y_6;
                next_x_7 = x_pos;
                next_y_7 = y_pos;
                next_x_8 = x_8;
                next_y_8 = y_8;
                next_x_9 = x_9;
                next_y_9 = y_9;
            end
            10'd8:begin
                next_x_0 = x_0;
                next_y_0 = y_0;
                next_x_1 = x_1;
                next_y_1 = y_1;
                next_x_2 = x_2;
                next_y_2 = y_2;
                next_x_3 = x_3;
                next_y_3 = y_3;
                next_x_4 = x_4;
                next_y_4 = y_4;
                next_x_5 = x_5;
                next_y_5 = y_5;
                next_x_6 = x_6;
                next_y_6 = y_6;
                next_x_7 = x_7;
                next_y_7 = y_7;
                next_x_8 = x_pos;
                next_y_8 = y_pos;
                next_x_9 = x_9;
                next_y_9 = y_9;
            end
            10'd9:begin
                next_x_0 = x_0;
                next_y_0 = y_0;
                next_x_1 = x_1;
                next_y_1 = y_1;
                next_x_2 = x_2;
                next_y_2 = y_2;
                next_x_3 = x_3;
                next_y_3 = y_3;
                next_x_4 = x_4;
                next_y_4 = y_4;
                next_x_5 = x_5;
                next_y_5 = y_5;
                next_x_6 = x_6;
                next_y_6 = y_6;
                next_x_7 = x_7;
                next_y_7 = y_7;
                next_x_8 = x_8;
                next_y_8 = y_8;
                next_x_9 = x_pos;
                next_y_9 = y_pos;
            end
            default:begin
                next_x_0 = x_0;
                next_y_0 = y_0;
                next_x_1 = x_1;
                next_y_1 = y_1;
                next_x_2 = x_2;
                next_y_2 = y_2;
                next_x_3 = x_3;
                next_y_3 = y_3;
                next_x_4 = x_4;
                next_y_4 = y_4;
                next_x_5 = x_5;
                next_y_5 = y_5;
                next_x_6 = x_6;
                next_y_6 = y_6;
                next_x_7 = x_7;
                next_y_7 = y_7;
                next_x_8 = x_8;
                next_y_8 = y_8;
                next_x_9 = x_9;
                next_y_9 = y_9;
            end
        endcase
    end


    always @(*) begin
        case(counter)
            10'd0:begin
                ball_size = `ball_size_3;

                next_s_0 = `ball_size_3;
                next_s_1 = s_1;
                next_s_2 = s_2;
                next_s_3 = s_3;
                next_s_4 = s_4;
                next_s_5 = s_5;
                next_s_6 = s_6;
                next_s_7 = s_7;
                next_s_8 = s_8;
                next_s_9 = s_9;
            end
            10'd1:begin
                ball_size = `ball_size_2;

                next_s_0 = s_0;
                next_s_1 = `ball_size_2;
                next_s_2 = s_2;
                next_s_3 = s_3;
                next_s_4 = s_4;
                next_s_5 = s_5;
                next_s_6 = s_6;
                next_s_7 = s_7;
                next_s_8 = s_8;
                next_s_9 = s_9;

            end
            10'd2:begin
                ball_size = `ball_size_3;

                next_s_0 = s_0;
                next_s_1 = s_1;
                next_s_2 = `ball_size_3;
                next_s_3 = s_3;
                next_s_4 = s_4;
                next_s_5 = s_5;
                next_s_6 = s_6;
                next_s_7 = s_7;
                next_s_8 = s_8;
                next_s_9 = s_9;
            end
            10'd3:begin
                ball_size = `ball_size_4;

                next_s_0 = s_0;
                next_s_1 = s_1;
                next_s_2 = s_2;
                next_s_3 = `ball_size_4;
                next_s_4 = s_4;
                next_s_5 = s_5;
                next_s_6 = s_6;
                next_s_7 = s_7;
                next_s_8 = s_8;
                next_s_9 = s_9;
            end
            10'd4:begin
                ball_size = `ball_size_1;

                next_s_0 = s_0;
                next_s_1 = s_1;
                next_s_2 = s_2;
                next_s_3 = s_3;
                next_s_4 = `ball_size_1;
                next_s_5 = s_5;
                next_s_6 = s_6;
                next_s_7 = s_7;
                next_s_8 = s_8;
                next_s_9 = s_9;
            end
            10'd5:begin
                ball_size = `ball_size_2;

                next_s_0 = s_0;
                next_s_1 = s_1;
                next_s_2 = s_2;
                next_s_3 = s_3;
                next_s_4 = s_4;
                next_s_5 = `ball_size_2;
                next_s_6 = s_6;
                next_s_7 = s_7;
                next_s_8 = s_8;
                next_s_9 = s_9;
            end
            10'd6:begin
                ball_size = `ball_size_3;

                next_s_0 = s_0;
                next_s_1 = s_1;
                next_s_2 = s_2;
                next_s_3 = s_3;
                next_s_4 = s_4;
                next_s_5 = s_5;
                next_s_6 = `ball_size_3;
                next_s_7 = s_7;
                next_s_8 = s_8;
                next_s_9 = s_9;
            end
            10'd7:begin
                ball_size = `ball_size_4;

                next_s_0 = s_0;
                next_s_1 = s_1;
                next_s_2 = s_2;
                next_s_3 = s_3;
                next_s_4 = s_4;
                next_s_5 = s_5;
                next_s_6 = s_6;
                next_s_7 = `ball_size_4;
                next_s_8 = s_8;
                next_s_9 = s_9;
            end
            10'd8:begin
                ball_size = `ball_size_2;

                next_s_0 = s_0;
                next_s_1 = s_1;
                next_s_2 = s_2;
                next_s_3 = s_3;
                next_s_4 = s_4;
                next_s_5 = s_5;
                next_s_6 = s_6;
                next_s_7 = s_7;
                next_s_8 = `ball_size_2;
                next_s_9 = s_9;
            end
            10'd9:begin
                ball_size = `ball_size_3;

                next_s_0 = s_0;
                next_s_1 = s_1;
                next_s_2 = s_2;
                next_s_3 = s_3;
                next_s_4 = s_4;
                next_s_5 = s_5;
                next_s_6 = s_6;
                next_s_7 = s_7;
                next_s_8 = s_8;
                next_s_9 = `ball_size_3;
            end
            default:begin
                ball_size = `ball_size_0;

                next_s_0 = s_0;
                next_s_1 = s_1;
                next_s_2 = s_2;
                next_s_3 = s_3;
                next_s_4 = s_4;
                next_s_5 = s_5;
                next_s_6 = s_6;
                next_s_7 = s_7;
                next_s_8 = s_8;
                next_s_9 = s_9;
            end
        endcase
    end
endmodule