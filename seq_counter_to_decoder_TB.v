module seq_counter_to_decoder_tb;

  reg clk;
  reg reset;
  reg inc;

  wire [7:0] decoded_count;

  seq_counter_to_decoder dut (
    .clk(clk),
    .reset(reset),
    .decoded_count(decoded_count)
  );

    initial begin

        clk = 0;
        reset = 0;   
        inc = 1;

        #40;
        reset = 1;
        #40;
        reset = 0;
        #40
        inc = 0;
     
    end
    
    always #1 clk = ~clk;

endmodule