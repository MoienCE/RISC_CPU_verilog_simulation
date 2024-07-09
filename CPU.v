module CPU;
    reg clock;

    wire load_AC, load_AR, load_DR, load_IR, load_PC, load_TR;
    wire clear_AC, clear_AR, clear_DR, clear_PC, clear_TR;
    wire inc_AC, inc_AR, inc_DR, inc_PC, inc_TR;
    wire seq_counter_RESET;
    wire memory_read;
    wire memory_write;
    wire [2:0] bus_selectors;
    wire alu_enable;
    wire [2:0] alu_mode;

    wire [7:0] out_Bus, out_Memory, out_DR, out_AC, out_IR, out_TR, out_ALU, X_DATA, out_sequence_counter;
    wire [3:0] out_AR, out_PC;
    wire out_E_ALU;


    ALU_von ALU (
        .AC(out_AC),
        .DR(out_DR),
        .mode(alu_mode),
        .activate(alu_enable),
        .E(out_E_ALU),
        .result(out_ALU)
    );

    BUS theBUS (
        .X_DATA(X_DATA),
        .AR_DATA(out_AR),
        .PC_DATA(out_PC),
        .DR_DATA(out_DR),
        .AC_DATA(out_AC),
        .IR_DATA(out_IR),
        .TR_DATA(out_TR),
        .MEMORY_DATA(out_Memory),
        .select(bus_selectors),
        .out(out_Bus)
    );

    seq_counter_to_decoder sequence_counter (
        .clk(clock),
        .reset(seq_counter_RESET),
        .decoded_count(out_sequence_counter)
    );

    Control_Unit control_unit_inst (
        .clk(clock),
        .T(out_sequence_counter),
        .IR(out_IR),
        .load_AR(load_AR),
        .load_PC(load_PC),
        .load_DR(load_DR),
        .load_AC(load_AC),
        .load_IR(load_IR),
        .load_TR(load_TR),
        .clear_AR(clear_AR),
        .clear_PC(clear_PC),
        .clear_DR(clear_DR),
        .clear_AC(clear_AC),
        .clear_TR(clear_TR),
        .inc_AR(inc_AR),
        .inc_PC(inc_PC),
        .inc_DR(inc_DR),
        .inc_AC(inc_AC),
        .inc_TR(inc_TR),
        .seq_counter_RESET(seq_counter_RESET),
        .memory_read(memory_read),
        .memory_write(memory_write),
        .bus_selectors(bus_selectors),
        .alu_enable(alu_enable),
        .alu_mode(alu_mode)
    );

    reg_4b_von AR (
        .data_in(out_Bus[3:0]),
        .clk(clock),
        .load(load_AR),
        .inc(inc_AR),
        .clear(clear_AR),
        .value(out_AR)
    );
    reg_4b_von PC (
        .data_in(out_Bus[3:0]),
        .clk(clock),
        .load(load_PC),
        .inc(inc_PC),
        .clear(clear_PC),
        .value(out_PC)
    );
    reg_8b_von DR (
        .data_in(out_Bus),
        .clk(clock),
        .load(load_DR),
        .inc(inc_DR),
        .clear(clear_DR),
        .value(out_DR)
    );
    reg_8b_von AC (
        .data_in(out_Bus),
        .clk(clock),
        .load(load_AC),
        .inc(inc_AC),
        .clear(clear_AC),
        .value(out_AC)
    );
    reg_8b_von IR (
        .data_in(out_Bus),
        .clk(clock),
        .load(load_IR),
        .inc(inc_AR),
        .clear(clear_AR),
        .value(out_IR)
    );
    reg_8b_von TR (
        .data_in(out_Bus),
        .clk(clock),
        .load(load_TR),
        .inc(inc_TR),
        .clear(clear_TR),
        .value(out_TR)
    );

    memory_module memory (
        .address(out_AR),
        .read(memory_read),
        .write(memory_write),
        .data_in(out_Bus),
        .data_out(out_Memory)
    );
    
    initial begin
        clock = 1;
    end
    always #10 clock = ~clock;

endmodule
