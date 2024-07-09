module seq_counter_to_decoder (clk, reset, decoded_count);

  input clk, reset;
  output [7:0] decoded_count;

  reg [2:0] count;
  
  initial begin
    count <= 3'b000;
  end


  always@(posedge clk) 
  begin
    if(reset)
      count = 3'b000;
    else
      count = count + 1;
  end
  

  decoder1to8 decoder (
    .count(count),
    .decoded_count(decoded_count)
  );

endmodule



module decoder1to8 (
  input [2:0] count,
  output [7:0] decoded_count
);

  assign decoded_count = (count == 0) ? 16'b00000001 :
                         (count == 1) ? 16'b00000010 :
                         (count == 2) ? 16'b00000100 :
                         (count == 3) ? 16'b00001000 :
                         (count == 4) ? 16'b00010000 :
                         (count == 5) ? 16'b00100000 :
                         (count == 6) ? 16'b01000000 :
                                        16'b10000000 ;

endmodule
