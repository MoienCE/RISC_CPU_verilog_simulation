module reg_4b_von_TB;

  reg clk;
  reg load;
  reg inc;
  reg clear;
  reg [3:0] data;

  wire [3:0] value;

  reg_4b_von uut (
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
        data = 4'b0101;
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