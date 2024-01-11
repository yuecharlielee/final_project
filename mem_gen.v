`include "global.v"

module mem_addr_gen(
    h_cnt, v_cnt, valid,
    x_0, x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9, 
    y_0, y_1, y_2, y_3, y_4, y_5, y_6, y_7, y_8, y_9, 
    s_0, s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9,
    pixel_addr, pixel_back,
    vgaRed, vgaGreen, vgaBlue
    );
    
    input [9:0] h_cnt;
    input [9:0] v_cnt;
    input valid;

    input [11:0] x_0, x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9;
    input [11:0] y_0, y_1, y_2, y_3, y_4, y_5, y_6, y_7, y_8, y_9;
    input [11:0] s_0, s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9;

    input [11:0] pixel_back;


    output reg [16:0] pixel_addr;
    output reg [3:0] vgaRed, vgaGreen, vgaBlue;


    
    wire [19:0] h_cnt_rs;
    wire [19:0] v_cnt_rs;

    assign h_cnt_rs = h_cnt >> 1; 
    assign v_cnt_rs = v_cnt >> 1; 

    reg [19:0] area_s_0, area_s_1, area_s_2, area_s_3, area_s_4, area_s_5, area_s_6, area_s_7, area_s_8, area_s_9;  

    wire in_circle_0 = s_0 != 0 && ((h_cnt_rs - x_0) * (h_cnt_rs - x_0) + (v_cnt_rs - y_0) * (v_cnt_rs - y_0) < area_s_0);
    wire in_circle_1 = s_1 != 0 && ((h_cnt_rs - x_1) * (h_cnt_rs - x_1) + (v_cnt_rs - y_1) * (v_cnt_rs - y_1) < area_s_1);
    wire in_circle_2 = s_2 != 0 && ((h_cnt_rs - x_2) * (h_cnt_rs - x_2) + (v_cnt_rs - y_2) * (v_cnt_rs - y_2) < area_s_2);
    wire in_circle_3 = s_3 != 0 && ((h_cnt_rs - x_3) * (h_cnt_rs - x_3) + (v_cnt_rs - y_3) * (v_cnt_rs - y_3) < area_s_3);
    wire in_circle_4 = s_4 != 0 && ((h_cnt_rs - x_4) * (h_cnt_rs - x_4) + (v_cnt_rs - y_4) * (v_cnt_rs - y_4) < area_s_4);
    wire in_circle_5 = s_5 != 0 && ((h_cnt_rs - x_5) * (h_cnt_rs - x_5) + (v_cnt_rs - y_5) * (v_cnt_rs - y_5) < area_s_5);
    wire in_circle_6 = s_6 != 0 && ((h_cnt_rs - x_6) * (h_cnt_rs - x_6) + (v_cnt_rs - y_6) * (v_cnt_rs - y_6) < area_s_6);
    wire in_circle_7 = s_7 != 0 && ((h_cnt_rs - x_7) * (h_cnt_rs - x_7) + (v_cnt_rs - y_7) * (v_cnt_rs - y_7) < area_s_7);
    wire in_circle_8 = s_8 != 0 && ((h_cnt_rs - x_8) * (h_cnt_rs - x_8) + (v_cnt_rs - y_8) * (v_cnt_rs - y_8) < area_s_8); 
    wire in_circle_9 = s_9 != 0 && ((h_cnt_rs - x_9) * (h_cnt_rs - x_9) + (v_cnt_rs - y_9) * (v_cnt_rs - y_9) < area_s_9);


    wire in_circle = in_circle_0 || in_circle_1 || in_circle_2 || in_circle_3 || in_circle_4 || in_circle_5 || in_circle_6 || in_circle_7 || in_circle_8 || in_circle_9; 
    //wire in_circle = in_circle_0 || in_circle_1 || in_circle_2 || in_circle_3 || in_circle_4 || in_circle_5; 
    always @ (*) begin
        if(valid) begin
            if(in_circle) begin
                if(in_circle_0) begin
                    case(s_0)
                        `ball_size_1:begin
                            pixel_addr = 17'd65858 + ((h_cnt_rs - x_0) + 320 * (v_cnt_rs - y_0));
                        end
                        `ball_size_2:begin
                            pixel_addr = 17'd45466 + ((h_cnt_rs - x_0) + 320 * (v_cnt_rs - y_0));
                        end
                        `ball_size_3:begin
                            pixel_addr = 17'd64699 + ((h_cnt_rs - x_0) + 320 * (v_cnt_rs - y_0));
                        end
                        `ball_size_4:begin
                            pixel_addr = 17'd43482 + ((h_cnt_rs - x_0) + 320 * (v_cnt_rs - y_0));
                        end
                        default: begin
                            pixel_addr = 17'd20000;
                        end
                    endcase
                end
                else if(in_circle_1) begin
                    case(s_1)
                        `ball_size_1:begin
                            pixel_addr = 17'd65858 + ((h_cnt_rs - x_1) + 320 * (v_cnt_rs - y_1));
                        end
                        `ball_size_2:begin
                            pixel_addr = 17'd45466 + ((h_cnt_rs - x_1) + 320 * (v_cnt_rs - y_1));
                        end
                        `ball_size_3:begin
                            pixel_addr = 17'd64699 + ((h_cnt_rs - x_1) + 320 * (v_cnt_rs - y_1));
                        end
                        `ball_size_4:begin
                            pixel_addr = 17'd43482 + ((h_cnt_rs - x_1) + 320 * (v_cnt_rs - y_1));
                        end
                        default: begin
                            pixel_addr = 17'd20000;
                        end
                    endcase
                end
                else if(in_circle_2) begin
                    case(s_2)
                        `ball_size_1:begin
                            pixel_addr = 17'd65858 + ((h_cnt_rs - x_2) + 320 * (v_cnt_rs - y_2));
                        end
                        `ball_size_2:begin
                            pixel_addr = 17'd45466 + ((h_cnt_rs - x_2) + 320 * (v_cnt_rs - y_2));
                        end
                        `ball_size_3:begin
                            pixel_addr = 17'd64699 + ((h_cnt_rs - x_2) + 320 * (v_cnt_rs - y_2));
                        end
                        `ball_size_4:begin
                            pixel_addr = 17'd43482 + ((h_cnt_rs - x_2) + 320 * (v_cnt_rs - y_2));
                        end
                        default: begin
                            pixel_addr = 17'd20000;
                        end
                    endcase
                end
                else if(in_circle_3) begin
                    case(s_3)
                        `ball_size_1:begin
                            pixel_addr = 17'd65858 + ((h_cnt_rs - x_3) + 320 * (v_cnt_rs - y_3));
                        end
                        `ball_size_2:begin
                            pixel_addr = 17'd45466 + ((h_cnt_rs - x_3) + 320 * (v_cnt_rs - y_3));
                        end
                        `ball_size_3:begin
                            pixel_addr = 17'd64699 + ((h_cnt_rs - x_3) + 320 * (v_cnt_rs - y_3));
                        end
                        `ball_size_4:begin
                            pixel_addr = 17'd43482 + ((h_cnt_rs - x_3) + 320 * (v_cnt_rs - y_3));
                        end
                        default: begin
                            pixel_addr = 17'd20000;
                        end
                    endcase
                end
                else if(in_circle_4) begin
                    case(s_4)
                        `ball_size_1:begin
                            pixel_addr = 17'd65858 + ((h_cnt_rs - x_4) + 320 * (v_cnt_rs - y_4));
                        end
                        `ball_size_2:begin
                            pixel_addr = 17'd45466 + ((h_cnt_rs - x_4) + 320 * (v_cnt_rs - y_4));
                        end
                        `ball_size_3:begin
                            pixel_addr = 17'd64699 + ((h_cnt_rs - x_4) + 320 * (v_cnt_rs - y_4));
                        end
                        `ball_size_4:begin
                            pixel_addr = 17'd43482 + ((h_cnt_rs - x_4) + 320 * (v_cnt_rs - y_4));
                        end
                        default: begin
                            pixel_addr = 17'd20000;
                        end
                    endcase
                end
                else if(in_circle_5) begin
                    case(s_5)
                        `ball_size_1:begin
                            pixel_addr = 17'd65858 + ((h_cnt_rs - x_5) + 320 * (v_cnt_rs - y_5));
                        end
                        `ball_size_2:begin
                            pixel_addr = 17'd45466 + ((h_cnt_rs - x_5) + 320 * (v_cnt_rs - y_5));
                        end
                        `ball_size_3:begin
                            pixel_addr = 17'd64699 + ((h_cnt_rs - x_5) + 320 * (v_cnt_rs - y_5));
                        end
                        `ball_size_4:begin
                            pixel_addr = 17'd43482 + ((h_cnt_rs - x_5) + 320 * (v_cnt_rs - y_5));
                        end
                        default: begin
                            pixel_addr = 17'd20000;
                        end
                    endcase
                end
                else if(in_circle_6) begin
                    case(s_6)
                        `ball_size_1:begin
                            pixel_addr = 17'd65858 + ((h_cnt_rs - x_6) + 320 * (v_cnt_rs - y_6));
                        end
                        `ball_size_2:begin
                            pixel_addr = 17'd45466 + ((h_cnt_rs - x_6) + 320 * (v_cnt_rs - y_6));
                        end
                        `ball_size_3:begin
                            pixel_addr = 17'd64699 + ((h_cnt_rs - x_6) + 320 * (v_cnt_rs - y_6));
                        end
                        `ball_size_4:begin
                            pixel_addr = 17'd43482 + ((h_cnt_rs - x_6) + 320 * (v_cnt_rs - y_6));
                        end
                        default: begin
                            pixel_addr = 17'd20000;
                        end
                    endcase
                end
                else if(in_circle_7) begin
                    case(s_7)
                        `ball_size_1:begin
                            pixel_addr = 17'd65858 + ((h_cnt_rs - x_7) + 320 * (v_cnt_rs - y_7));
                        end
                        `ball_size_2:begin
                            pixel_addr = 17'd45466 + ((h_cnt_rs - x_7) + 320 * (v_cnt_rs - y_7));
                        end
                        `ball_size_3:begin
                            pixel_addr = 17'd64699 + ((h_cnt_rs - x_7) + 320 * (v_cnt_rs - y_7));
                        end
                        `ball_size_4:begin
                            pixel_addr = 17'd43482 + ((h_cnt_rs - x_7) + 320 * (v_cnt_rs - y_7));
                        end
                        default: begin
                            pixel_addr = 17'd20000;
                        end
                    endcase
                end
                else if(in_circle_8) begin
                    case(s_8)
                        `ball_size_1:begin
                            pixel_addr = 17'd65858 + ((h_cnt_rs - x_8) + 320 * (v_cnt_rs - y_8));
                        end
                        `ball_size_2:begin
                            pixel_addr = 17'd45466 + ((h_cnt_rs - x_8) + 320 * (v_cnt_rs - y_8));
                        end
                        `ball_size_3:begin
                            pixel_addr = 17'd64699 + ((h_cnt_rs - x_8) + 320 * (v_cnt_rs - y_8));
                        end
                        `ball_size_4:begin
                            pixel_addr = 17'd43482 + ((h_cnt_rs - x_8) + 320 * (v_cnt_rs - y_8));
                        end
                        default: begin
                            pixel_addr = 17'd20000;
                        end
                    endcase
                end
                else if(in_circle_9) begin
                    case(s_9)
                        `ball_size_1:begin
                            pixel_addr = 17'd65858 + ((h_cnt_rs - x_9) + 320 * (v_cnt_rs - y_9));
                        end
                        `ball_size_2:begin
                            pixel_addr = 17'd45466 + ((h_cnt_rs - x_9) + 320 * (v_cnt_rs - y_9));
                        end
                        `ball_size_3:begin
                            pixel_addr = 17'd64699 + ((h_cnt_rs - x_9) + 320 * (v_cnt_rs - y_9));
                        end
                        `ball_size_4:begin
                            pixel_addr = 17'd43482 + ((h_cnt_rs - x_9) + 320 * (v_cnt_rs - y_9));
                        end
                        default: begin
                            pixel_addr = 17'd20000;
                        end
                    endcase
                end
                else begin
                    pixel_addr = ((h_cnt_rs)+320*(v_cnt_rs))% 76800;
                end
                
            end
            else begin
                pixel_addr = ((h_cnt_rs)+320*(v_cnt_rs))% 76800;
            end
        end
        else begin
            pixel_addr = ((h_cnt_rs)+320*(v_cnt_rs))% 76800;
        end
        
        
        
    end
    

    always @(*) begin
        if(valid) begin
            {vgaRed, vgaGreen, vgaBlue} = pixel_back;
        end
        else begin
            {vgaRed, vgaGreen, vgaBlue} = 12'h0;
        end
    end


    always @(*) begin
        area_s_0 = s_0 * s_0;
        area_s_1 = s_1 * s_1;
        area_s_2 = s_2 * s_2;
        area_s_3 = s_3 * s_3;
        area_s_4 = s_4 * s_4;
        area_s_5 = s_5 * s_5;
        area_s_6 = s_6 * s_6;
        area_s_7 = s_7 * s_7;
        area_s_8 = s_8 * s_8;
        area_s_9 = s_9 * s_9;
    end
    
endmodule
