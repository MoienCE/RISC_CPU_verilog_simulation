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
  output [7:0] out
);

  assign out = (select == 0 ) ? X_DATA :
             (select == 1 ) ? AR_DATA :
             (select == 2 ) ? PC_DATA :
             (select == 3 ) ? DR_DATA :
             (select == 4 ) ? AC_DATA :
             (select == 5 ) ? IR_DATA :
             (select == 6 ) ? TR_DATA :
             (select == 7 ) ? MEMORY_DATA :
             0;

endmodule
