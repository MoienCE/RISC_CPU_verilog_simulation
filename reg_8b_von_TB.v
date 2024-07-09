module reg_8b_von_TB;

  reg clk;
  reg load;
  reg inc;
  reg clear;
  reg [7:0] data;

  wire [7:0] value;

  reg_8b_von uut (
    .data_in(data),
    .clk(clk),
    .load(load),
    .inc(inc),
    .clear(clear),
    .value(value)
  );

    initial begin
        clk = 0;
        clear = 0;
        data = 8'b01010101;
        inc = 0;
        load = 0;
        
        #10
        load = 1;
        #10
        load = 0;
        #40;
        inc = 1;
        #10
        inc = 0;
        clear = 1;
        #2
        clear = 0;
     
    end
    
    always #1 clk = ~clk;

endmodule