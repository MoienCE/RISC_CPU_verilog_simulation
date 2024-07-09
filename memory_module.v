module memory_module (
  input [3:0] address,
  input read,
  input write,
  input [7:0] data_in,
  output reg [7:0] data_out
);

  reg [7:0] memory [15:0];

  initial begin
    memory[0] = 8'b00000001;
    memory[1] = 8'b00000010;
  end

  always @(*) begin

    if (read) begin
      data_out <= memory[address];
    end

    if (write) begin
      memory[address] <= data_in;
    end
  end

endmodule