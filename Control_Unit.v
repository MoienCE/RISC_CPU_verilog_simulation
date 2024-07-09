module Control_Unit (
    input clk,
    input [7:0] T, // sequence
    input [7:0] IR,
    
    output reg load_AR, 
    output reg load_PC, 
    output reg load_DR, 
    output reg load_AC, 
    output reg load_IR, 
    output reg load_TR,
    
    output reg clear_AR, 
    output reg clear_PC, 
    output reg clear_DR, 
    output reg clear_AC, 
    output reg clear_TR,
    
    output reg inc_AR, 
    output reg inc_PC, 
    output reg inc_DR, 
    output reg inc_AC, 
    output reg inc_TR,
    
    output reg seq_counter_RESET,
    output reg memory_read,
    output reg memory_write,
    output reg [2:0] bus_selectors,
    output reg alu_enable,
    output reg [2:0] alu_mode
);


    reg [2:0] opcode;
    reg immediate;

    always @(posedge clk) begin
        seq_counter_RESET = 0;

        opcode = 3'b000;
        immediate = 0;

        load_AR = 0;
        load_PC = 0;
        load_DR = 0;
        load_AC = 0;
        load_IR = 0;
        load_TR = 0;
        
        clear_AR = 0;
        clear_PC = 0;
        clear_DR = 0;
        clear_AC = 0;
        clear_TR = 0;

        inc_AR = 0;
        inc_PC = 0;
        inc_DR = 0;
        inc_AC = 0;
        inc_TR = 0;

        memory_read = 0;
        memory_write = 0;

        bus_selectors = 3'b000;

        alu_enable = 0;
        alu_mode = 3'b000;

        if (T[0]) begin
            bus_selectors = 2;
            load_AR = 1;
        end else if (T[1]) begin
            bus_selectors = 3'b111;
            inc_PC = 1;
            memory_read = 1;
            memory_write = 0;
            load_IR = 1;
        end else if (T[2]) begin
            opcode = IR[6:4];
            bus_selectors = 3'b101;
            load_AR = 1;
            immediate = IR[7];
        end else if (T[3]) begin
            if (immediate) begin
                bus_selectors = 3'b111;
                load_AR = 1;
            end
        end else if (T[4]) begin
            bus_selectors = 3'b111;
            load_DR = 1;
            if (opcode == 3'b101) begin
                bus_selectors = 3'b100;
                memory_read = 0;
                memory_write = 1;
            end
        end else if (T[5]) begin
            alu_mode = opcode;
            alu_enable = 1;
        end else begin
            seq_counter_RESET = 1;
        end
    end

endmodule
