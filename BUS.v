module BUS (
  input [7:0] X_DATA,
  input [7:0] AR_DATA,
  input [7:0] PC_DATA,
  input [7:0] DR_DATA,
  input [7:0] AC_DATA,
  input [7:0] IR_DATA,
  input [7:0] TR_DATA,
  input [7:0] MEMORY_DATA,
  input [2:0] select,
  output reg [7:0] out
);
  
  initial begin
    out = 8'b00000000;
  end

  always @(*) begin
    case (select)
      3'b000: out = X_DATA;
      3'b001: out = AR_DATA;
      3'b010: out = PC_DATA;
      3'b011: out = DR_DATA;
      3'b100: out = AC_DATA;
      3'b101: out = IR_DATA;
      3'b110: out = TR_DATA;
      3'b111: out = MEMORY_DATA;
      default: out = 8'b00000000;
    endcase
  end

endmodule
