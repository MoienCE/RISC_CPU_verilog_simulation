module Control_Unit (
    input [7:0] IR,
    input clock,
    input reset,
    
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
    
    output reg memory_read,
    output reg memory_write,
    output reg [2:0] bus_selectors,
    output reg alu_enable,
    output reg [2:0] alu_mode
);

    reg [3:0] sequence_counter;
    reg [2:0] opcode;
    reg immediate;

    initial begin
        sequence_counter = 0;
    end


    always @(*) begin
        // Reset all control signals
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

        memory_read = 1;
        memory_write = 0;

        bus_selectors = 3'b111;

        alu_enable = 0;
        alu_mode = 3'b000;

        if (1) begin
            case (sequence_counter)
                0: begin
                    bus_selectors = 3'b010;
                    load_AR = 1;
                end
                1: begin
                    inc_PC = 1;
                    memory_read = 1;
                    memory_write = 0;
                    load_IR = 1;
                end
                2: begin
                    opcode = IR[6:4];
                    bus_selectors = 3'b101;
                    load_AR = 1;
                    immediate = IR[7];
                end
                3: begin
                    if (immediate) begin
                        load_AR = 1;
                    end else begin
                        load_DR = 1; // Load DR immediately
                    end
                end
                4: begin
                    load_DR = 1; // Load DR immediately
                    if (opcode == 3'b101) begin
                        bus_selectors = 3'b100;
                        memory_read = 0;
                        memory_write = 1;
                    end
                end
                5: begin
                    alu_mode = opcode;
                    alu_enable = 1;
                    load_AC = 1;
                end
                6: begin
                    if (opcode != 3'b111) begin
                        bus_selectors = 3'b100;
                        memory_read = 0;
                        memory_write = 1;
                    end
                end
                7: begin end
                default: begin
                end
            endcase
        end
    end

    always @(posedge clock or posedge reset) begin
        
        if (reset) begin
            sequence_counter <= 0;
            clear_PC = 1;
        end else begin
            case (sequence_counter)
                0: begin
                    sequence_counter <= sequence_counter + 1;
                end
                1: begin
                    sequence_counter <= sequence_counter + 1;
                end
                2: begin
                    sequence_counter <= sequence_counter + 1;
                end
                3: begin
                    sequence_counter <= sequence_counter + 1;
                end
                4: begin
                    sequence_counter <= sequence_counter + 1;
                end
                5: begin
                    sequence_counter <= sequence_counter + 1;
                end
                6: begin
                    sequence_counter <= 0;
                end
                default: begin
                    sequence_counter <= 0;
                end
            endcase
        end
    end

endmodule
