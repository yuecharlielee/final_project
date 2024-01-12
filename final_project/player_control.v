module player_control(clk, rst, falling, left, right, test_falling, test_left, test_right, x_1, y_1, x_2, y_2);
    input clk, rst, falling, left, right, test_falling, test_left, test_right;

    parameter size_1 = 10'd5, size_2 = 10'd10, size_3 = 10'd15, size_4 = 10'd20; 

    output reg [9:0] x_1, y_1, x_2, y_2;


    reg [9:0] next_x_pos, next_y_pos;
    reg [9:0] next_x_2_pos, next_y_2_pos;
	reg [20:0] x_dis, y_dis;
    reg [9:0] counter, next_counter;
    reg [3:0] state, next_state;

    parameter falling_State = 4'd0, select_State = 4'd1, stop_State = 4'd2;

    always @(posedge clk, posedge rst) begin
        
        if(rst) begin
            counter <= 10'd0;
            x_1 <= 10'd145;
            y_1 <= 10'd50;
            x_2 <= 10'd160;
            y_2 <= 10'd230;
            state <= select_State;
        end
        else begin
            x_1 <= next_x_pos;
            y_1 <= next_y_pos;
            x_2 <= next_x_2_pos;
            y_2 <= next_y_2_pos;
            state <= next_state;
        end
    end

    always @(*) begin
        // next_y_pos = y_pos + 1;
        next_x_2_pos = 10'd160;
        next_y_2_pos = 10'd230;
        case(state)
            select_State:begin
                next_x_pos = x_1;
                next_y_pos = 10'd50;
                if(falling == 1'b1 || test_falling == 1'b1) begin
                    next_state = falling_State;
                end
                else begin
                    next_state = select_State;
                    if(left == 1'b1 || test_left == 1'b1) begin
                        if(x_1 == 10'd82) begin
                            next_x_pos = x_1;
                        end
                        else begin
                            next_x_pos = x_1 - 1;
                        end
                        
                    end
                    else begin
                        if(right == 1'b1 || test_right == 1'b1) begin
                            if(x_1 == 10'd245) begin
                                next_x_pos = x_1;
                            end
                            else begin
                                next_x_pos = x_1 + 1;
                            end
                        end
                        else begin
                            next_x_pos = x_1;
                        end
                    end
                end
            end
            falling_State: begin
                next_x_pos = x_1;
				if(y_1 < 10'd240 - size_1) begin
					x_dis = (x_1 > x_2) ? (x_1 - x_2) * (x_1 - x_2) : (x_2 - x_1) * (x_2 - x_1);
					y_dis = (y_1 > y_2) ? (y_1 - y_2) * (y_1 - x_2) : (y_2 - y_1) * (y_2 - y_1);
					if ((x_dis + y_dis) < ((size_1 + size_2) * (size_1 + size_2))) begin
						if (y_1 <= y_2) begin
							if (x_1 == x_2) begin
								next_y_pos = y_1;
							end
							else if (x_1 > x_2) begin
								next_x_pos = x_1 + 10'd1;
							end
							else if (x_1 < x_2) begin
								next_x_pos = x_1 - 10'd1;
							end
						end
					end
                    else if(y_1 + 10'd3 < 10'd240  - size_1) begin
                        next_y_pos = y_1 + 10'd3; 
                    end
                    else begin
                        next_y_pos = 10'd240  - size_1; 
                    end
                    
                end
                else begin
                    next_y_pos = y_1; 
                end
				

            end
			default: begin
				next_x_pos = x_1;
				next_y_pos = y_1;
			end
        endcase
    end


endmodule