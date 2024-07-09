module memory_module_tb;

  reg clk;
  reg [3:0] address;
  reg read;
  reg write;
  reg [7:0] data_in;

  wire [7:0] data_out;

  memory_module uut (
    .clk(clk),
    .address(address),
    .read(read),
    .write(write),
    .data_in(data_in),
    .data_out(data_out)
  );

  initial begin
    clk <= 0;
    address <= 0;
    read <= 0;
    write <= 0;
    data_in <= 0;

    // writing test
    data_in <= 8'b11110000;
    address <= 4'b0001;
    write <= 1;
    read <= 0;
    #20;

    // reading test
    address <= 4'b0001;
    write <= 0;
    read <= 1;
    #20;  

  end

  always #1 clk = ~clk;


endmodule
