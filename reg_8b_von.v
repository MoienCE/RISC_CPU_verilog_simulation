module reg_8b_von (data_in, clk, load, inc, clear, value);

    input [7:0] data_in;
    input clk, load, inc, clear;
    output reg [7:0] value;

    initial value = 8'b00000000;

    always @(posedge clk) begin
    if (load) begin
        value <= data_in;
    end else if (inc) begin
        value <= value + 1;
    end else if (clear) begin
        value = 8'b00000000;
    end

    end
    
endmodule