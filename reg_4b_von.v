
module reg_4b_von (data_in, clk, load, inc, clear, value);

    input [3:0] data_in;
    input clk, load, inc, clear;
    output reg [3:0] value;

    initial value = 4'b0000;
    
    always @(posedge clk or posedge clear) begin
    if (load) begin
        value <= data_in;
    end else if (inc) begin
        value <= value + 1;
    end else if (clear) begin
        value = 4'b0000;
    end

    end
    
endmodule
