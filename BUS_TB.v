module BUS_TB;

  // input
  reg [7:0] X_DATA;
  reg [7:0] AR_DATA;
  reg [7:0] PC_DATA;
  reg [7:0] DR_DATA;
  reg [7:0] AC_DATA;
  reg [7:0] IR_DATA;
  reg [7:0] TR_DATA;
  reg [7:0] MEMORY_DATA;
  reg [2:0] select;

  // output
  wire [7:0] out;

  // test control unit
  BUS uut (
    .X_DATA(X_DATA),
    .AR_DATA(AR_DATA),
    .PC_DATA(PC_DATA),
    .DR_DATA(DR_DATA),
    .AC_DATA(AC_DATA),
    .IR_DATA(IR_DATA),
    .TR_DATA(TR_DATA),
    .MEMORY_DATA(MEMORY_DATA),
    .select(select),
    .out(out)
  );

  // tests
  initial begin

    X_DATA <= 8'h0000;
    AR_DATA <= 8'h1111;
    PC_DATA <= 8'h2222;
    DR_DATA <= 8'h3333;
    AC_DATA <= 8'h4444;
    IR_DATA <= 8'h5555;
    TR_DATA <= 8'h6666;
    MEMORY_DATA <= 8'h7777;

    select <= 3'b000;
    #10;

    select <= 3'b001;
    #10;

    select <= 3'b111;
    #10;

  end

endmodule
