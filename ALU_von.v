module ALU_von (
    input [7:0] AC,
    input [7:0] DR,
    input [2:0] mode,
    input activate,
    output reg E,
    output reg [7:0] result
);

    // 000 ---- Add the operand of instruction to the value of a specific register
    // 001 ---- Arithmetic shifting the operand of instruction to left
    // 010 ---- Applying Xnor to the operand of instruction and the value of a specific register
    // 011 ---- Divide the operand of instruction by 2
    // 100 ---- Load the value of the operand of instruction to a specific register
    // 101 ---- Store the value of specific register to the operand of instruction 
    // 110 ---- Two’s complement the operand of instruction

    always@(posedge activate)
    begin
        case (mode)
            3'b000: begin
                result <= AC + DR;
            end
            3'b001: begin
                result <= DR <<< 1;
            end
            3'b010: begin
                result <= ~(AC^ DR);
            end
            3'b011: begin
                result <= DR >> 1;
            end
            3'b100: begin
                result <= DR;
            end
            3'b110: begin
                result <= ~AC + 1;
            end
            default: begin
                result <= 0;
            end
        endcase
    end

endmodule
