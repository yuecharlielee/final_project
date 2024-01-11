`include "global.v"

module top(clk, rst, PS2_DATA, PS2_CLK, vgaRed, vgaBlue, vgaGreen, hsync, vsync, btnC, btnL, btnR, finish, left_signal, right_signal, falling_signal, pmod_1, pmod_2, pmod_4);
    input clk, rst, btnC, btnL, btnR;
    inout PS2_DATA, PS2_CLK;
    output wire [3:0] vgaRed, vgaGreen, vgaBlue;
    output hsync, vsync;
    output wire finish;
    output wire left_signal, right_signal, falling_signal;

    output pmod_1, pmod_2, pmod_4;

    wire clk_d2, clk_d22, clk_d16;

    wire [511:0] key_down;
    wire [8:0] last_change;
    wire been_ready;

    wire valid;


    wire [11:0] x_pos[11:0];
    wire [11:0] y_pos[11:0];
    wire [9:0] state[9:0];


    wire [11:0] data;
    wire [16:0] pixel_addr;
    wire [11:0] pixel_back;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480

    
    wire left, right, falling;

    assign left_signal = (left == 1'b1 || btnL == 1'b1) ? 1'b1 : 1'b0;
    assign right_signal = (right == 1'b1 || btnR == 1'b1) ? 1'b1 : 1'b0;
    assign falling_signal = (falling == 1'b1 || btnC == 1'b1) ? 1'b1 : 1'b0;

    //clk
    clk_div #(2) CD0(.clk(clk), .clk_d(clk_d2));
    clk_div #(20) CD1(.clk(clk), .clk_d(clk_d16));
    clk_div #(22) CD2(.clk(clk), .clk_d(clk_d22));
    
    
    Keyboard_control key_ctrl(
         .clk(clk),
         .rst(rst),
         .key_down(key_down), 
         .last_change(last_change), 
         .been_ready(been_ready), 
         .falling(falling), 
         .left(left), 
         .right(right)
    );

    KeyboardDecoder key_de (
         .key_down(key_down),
         .last_change(last_change),
         .key_valid(been_ready),
         .PS2_DATA(PS2_DATA),
         .PS2_CLK(PS2_CLK),
         .rst(rst),
         .clk(clk)
    );

    player_control pc(
        .clk(clk_d22),
        .rst(rst),
        .falling(falling),
        .left(left),
        .right(right),
        .test_falling(btnC),
        .test_left(btnL),
        .test_right(btnR),
        .x_0(x_pos[0]),
        .y_0(y_pos[0]),
        .s_0(state[0]),
        .x_1(x_pos[1]),
        .y_1(y_pos[1]),
        .s_1(state[1]),
        .x_2(x_pos[2]),
        .y_2(y_pos[2]),
        .s_2(state[2]),
        .x_3(x_pos[3]),
        .y_3(y_pos[3]),
        .s_3(state[3]),
        .x_4(x_pos[4]),
        .y_4(y_pos[4]),
        .s_4(state[4]),
        .x_5(x_pos[5]),
        .y_5(y_pos[5]),
        .s_5(state[5]),
        .x_6(x_pos[6]),
        .y_6(y_pos[6]),
        .s_6(state[6]),
        .x_7(x_pos[7]),
        .y_7(y_pos[7]),
        .s_7(state[7]),
        .x_8(x_pos[8]),
        .y_8(y_pos[8]),
        .s_8(state[8]),
        .x_9(x_pos[9]),
        .y_9(y_pos[9]),
        .s_9(state[9]),
        .finish(finish)
    );

    mem_addr_gen mem_addr_gen_inst(
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .valid(valid),
        .pixel_addr(pixel_addr),
        .pixel_back(pixel_back),
        .x_0(x_pos[0]),
        .y_0(y_pos[0]),
        .s_0(state[0]),
        .x_1(x_pos[1]),
        .y_1(y_pos[1]),
        .s_1(state[1]),
        .x_2(x_pos[2]),
        .y_2(y_pos[2]),
        .s_2(state[2]),
        .x_3(x_pos[3]),
        .y_3(y_pos[3]),
        .s_3(state[3]),
        .x_4(x_pos[4]),
        .y_4(y_pos[4]),
        .s_4(state[4]),
        .x_5(x_pos[5]),
        .y_5(y_pos[5]),
        .s_5(state[5]),
        .x_6(x_pos[6]),
        .y_6(y_pos[6]),
        .s_6(state[6]),
        .x_7(x_pos[7]),
        .y_7(y_pos[7]),
        .s_7(state[7]),
        .x_8(x_pos[8]),
        .y_8(y_pos[8]),
        .s_8(state[8]),
        .x_9(x_pos[9]),
        .y_9(y_pos[9]),
        .s_9(state[9]),
        .vgaRed(vgaRed),
        .vgaGreen(vgaGreen),
        .vgaBlue(vgaBlue)
    );

    blk_mem_gen_0 BMG0(
		.clka(clk_d2),
        .wea(0),
        .addra(pixel_addr),
        .dina(data[11:0]),
        .douta(pixel_back)
    );


    vga_controller VC0(
        .pclk(clk_d2),
        .reset(rst),
        .hsync(hsync),
        .vsync(vsync),
        .valid(valid),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt)
    );

    MusicMain music (
              .clk(clk),
              .reset(rst),
              .pmod_1(pmod_1),
              .pmod_2(pmod_2),
              .pmod_4(pmod_4)
          );
endmodule