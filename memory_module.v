module memory_module (
  input [3:0] address,
  input read,
  input write,
  input [7:0] data_in,
  output reg [7:0] data_out
);

  reg [7:0] memory [15:0];

  initial begin
    memory[0] = 8'b01001100;    // load M[c] to AC  ... 05 will be in AC
    memory[1] = 8'b00101010;    // xnor M[a] with AC ... 05 xnor 08
    memory[2] = 8'b01101010;    // 2's comp M[a]
    memory[3] = 8'b01110000;
    memory[4] = 8'b01110000;
    memory[5] = 8'b01110000;
    memory[6] = 8'b01110000;
    memory[7] = 8'b01110000;
    memory[8] = 8'b01110000;
    memory[9] = 8'b01110000;
    memory[10] = 8'b00001000;
    memory[11] = 8'b01110000;
    memory[12] = 8'b00000101;
    memory[13] = 8'b01110000;
    memory[14] = 8'b01110000;
    memory[15] = 8'b01110000;
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