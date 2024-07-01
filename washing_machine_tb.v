`timescale 10ns/1ns
`include "washing_machine.v"

module washing_machine_tb();
    reg clk, reset, door_close, start, filled, detergent_added, cycle_timeout, drained, spin_timeout;
    wire door_lock, motor_on, fill_value_on, drain_value_on, done, soap_wash, water_wash; 
    
    // Instantiate the washing machine module
    washing_machine machine1 (
        .clk(clk), 
        .reset(reset), 
        .door_close(door_close), 
        .start(start), 
        .filled(filled), 
        .detergent_added(detergent_added), 
        .cycle_timeout(cycle_timeout), 
        .drained(drained), 
        .spin_timeout(spin_timeout), 
        .door_lock(door_lock), 
        .motor_on(motor_on), 
        .fill_value_on(fill_value_on), 
        .drain_value_on(drain_value_on), 
        .done(done), 
        .soap_wash(soap_wash), 
        .water_wash(water_wash)
    );

    initial begin
        $dumpfile("washing_machine_data.vcd");
        $dumpvars(0, washing_machine_tb);  // Correct module name used
    end

    initial begin
        clk = 0;
        reset = 1;
        start = 0;
        door_close = 0;
        filled = 0;
        drained = 0;
        detergent_added = 0;
        cycle_timeout = 0;
        spin_timeout = 0;
        
        #5 reset = 0;
        #5 start = 1; door_close = 1;
        #10 filled = 1;
        #10 detergent_added = 1;
        //filled = 0;
        #10 cycle_timeout = 1;
        //detergent_added = 0;
        #10 drained = 1;
        //cycle_timeout = 0;
        #10 spin_timeout = 1;
        //drained = 0;
    end
    
    always begin
        #5 clk = ~clk;
    end
    
    initial begin
        $display("Clock=%b, Reset=%b, start=%b, door_close=%b, filled=%b, detergent_added=%b, cycle_timeout=%b, drained=%b, spin_timeout=%b, door_lock=%b, motor_on=%b, fill_valve_on=%b, drain_valve_on=%b, soap_wash=%b, water_wash=%b, done=%b", clk, reset, start, door_close, filled, detergent_added, cycle_timeout, drained, spin_timeout, door_lock, motor_on, fill_value_on, drain_value_on, soap_wash, water_wash, done);
     #200 $finish;   
    end
endmodule
