module top(clk, rst, PS2_DATA, PS2_CLK, vgaRed, vgaBlue, vgaGreen, hsync, vsync, btnC, btnL, btnR, next_left);
    input clk, rst, btnC, btnL, btnR;
    inout PS2_DATA, PS2_CLK;
    output [3:0] vgaRed, vgaGreen, vgaBlue;
    output hsync, vsync;
    output next_left;

    wire clk_d2, clk_d22, clk_d16;

    wire [511:0] key_down;
    wire [8:0] last_change;
    wire been_ready;

    wire valid;

    wire next_falling, next_left, next_right;

    wire [9:0] x_pos[9:0];
    wire [9:0] y_pos[9:0];


    wire [11:0] data;
    wire [16:0] pixel_addr;
    wire [11:0] pixel;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480

    assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;

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
         .falling(next_falling), 
         .left(next_left), 
         .right(next_right)
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
        .falling(next_falling),
        .left(next_left),
        .right(next_right),
        .test_falling(btnC),
        .test_left(btnL),
        .test_right(btnR),
        .x_1(x_pos[0]),
        .y_1(y_pos[0]),
        .x_2(x_pos[1]),
        .y_2(y_pos[1])
    );

    mem_addr_gen mem_addr_gen_inst(
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .pixel_addr(pixel_addr),
        .x_1(x_pos[0]),
        .y_1(y_pos[0]),
        .x_2(x_pos[1]),
        .y_2(y_pos[1])
    );

    blk_mem_gen_0 BMG0(
		.clka(clk_d2),
        .wea(0),
        .addra(pixel_addr),
        .dina(data[11:0]),
        .douta(pixel)
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
endmodule