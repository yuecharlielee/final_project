import sys

original_stdout = sys.stdout 	

with open('generate.txt', 'w') as f:
    sys.stdout = f
    for i in range(10):
        print(f'x_dis_{i} = (x_pos > x_{i}) ? (x_pos - x_{i}) * (x_pos - x_{i}) : (x_{i} - x_pos) * (x_{i} - x_pos);')
        print(f'y_dis_{i} = (y_pos > y_{i}) ? (y_pos - y_{i}) * (y_pos - y_{i}) : (y_{i} - y_pos) * (y_{i} - y_pos);')
    
    for i in range(10):
        print(f's_dis_{i} = (ball_size + s_{i}) * (ball_size + s_{i});')

    for i in range(10):
        print(f"""if ((counter > {i}) & ((x_dis_{i} + y_dis_{i}) <= (ball_size + s_{i}) * (ball_size + s_{i}))) begin
    collision = collision + 1;
    if (x_pos < x_{i}) begin
        next_x_pos = next_x_pos - 1;
        next_y_pos = y_pos;
    end
    else if (x_pos > x_{i}) begin
        next_x_pos = next_x_pos + 1;
        next_y_pos = y_pos;
    end
    else begin 
        next_x_pos = x_pos;
        next_y_pos = y_pos;
        next_state = `finish_state;
    end

    if(x_pos == `right_bound - ball_size) begin
        next_x_pos = x_pos;
        next_y_pos = y_pos;
        next_state = `finish_state;
    end
    if(x_pos == `left_bound + ball_size) begin
        next_x_pos = x_pos;
        next_y_pos = y_pos;
        next_state = `finish_state;
    end
end
""")
    sys.stdout = original_stdout