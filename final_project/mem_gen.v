module mem_addr_gen(
    input [9:0] h_cnt,
    input [9:0] v_cnt,
    input [9:0] x_1,
    input [9:0] y_1,
    input [9:0] x_2,
    input [9:0] y_2,
    output reg [16:0] pixel_addr
    );
    
    reg [16:0] next_pixel_addr;
    
    
    parameter size_1 = 10'd5, size_2 = 10'd10, size_3 = 10'd15, size_4 = 10'd20; 

    parameter left_bound = 10'd82, right_bound = 10'd245, up_bound = 10'd55, down_bound = 10'd240; 
     
    wire [19:0] h_cnt_rs;
    wire [19:0] v_cnt_rs;

    assign h_cnt_rs = h_cnt >> 1; 
    assign v_cnt_rs = v_cnt >> 1; 

    wire in_circle_1 = (h_cnt_rs - x_1) * (h_cnt_rs - x_1) + (v_cnt_rs - y_1) * (v_cnt_rs - y_1) < size_1 * size_1;
    wire in_circle_2 = (h_cnt_rs - x_2) * (h_cnt_rs - x_2) + (v_cnt_rs - y_2) * (v_cnt_rs - y_2) < size_2 * size_2;

    always @ (*) begin
        if(in_circle_1 || in_circle_2) begin
            pixel_addr = 17'd4000;
        end
        else begin
            if(v_cnt_rs < up_bound || h_cnt_rs < left_bound || h_cnt_rs > right_bound) begin
                pixel_addr = 0;
            end
            else begin
                pixel_addr = ((h_cnt_rs)+320*(v_cnt_rs))% 76800;
            end
        end
        
    end
    

    
endmodule
