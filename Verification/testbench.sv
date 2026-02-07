`include "clock_gen.sv"
`include "reset_gen.sv"
`include "basic_write_read_test.sv"
`include "underflow_test.sv"
`include "overflow_test.sv"
`include "simultaneous_read_write_empty_test.sv"
`include "simultaneous_read_write_full_test.sv"
`include "reset_test.sv"

  parameter DATA_WIDTH = 16;
  parameter DEPTH = 8;
  parameter ADDR_WIDTH = 3;

  logic clk;
  logic reset_n;
  logic write_en;           
  logic read_en;           
  logic [DATA_WIDTH-1:0] data_in;
  logic [DATA_WIDTH-1:0] data_out;
  logic [DATA_WIDTH-1:0] data_out_check;
  logic full;             
  logic empty;             
  logic almost_full;      
  logic almost_empty;     
  logic overflow;         
  logic underflow;
  
  int error_count = 0;
module fifo_tb();
 
  
   fifo #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  ) uut (
    .clk(clk),
    .reset_n(reset_n),
    .write_en(write_en),
    .read_en(read_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty),
    .almost_full(almost_full),
    .almost_empty(almost_empty),
    .overflow(overflow),
    .underflow(underflow)
  );
  
  /*initial begin
    if (error_count == 0) begin
      $display("\n!!  All tests completed successfully Nice....!!!!! \n");
    end else begin
      $display("Test completed with %0d errors", error_count);
    end

    
 // end
  end*/
  
   clk_gen clock = new();
   rst_gen reset = new();
   reset_test rst = new();
  basic_write_read_test basic_read_write = new();
  underflow_test under_flow = new();
  overflow_test over_flow = new();
  simultaneous_read_write_empty_test simultaneous_read_write_empty = new();
  simultaneous_read_write_full_test simultaneous_read_write_full = new();
  
   initial begin
     clk = 1;
    reset_n = 0;
    write_en = 0;
    read_en = 0;
    data_in = 0;
    data_out_check = 0;
   end
  
  initial begin
    if (error_count == 0) begin
      $display("\n!!  All tests completed successfully Nice....!!!!! \n");
    end else begin
      $display("Test completed with %0d errors", error_count);
    end
    fork
      clock.clk_gen();
    join_none
      reset.rst_gen(); 
    basic_read_write.basic_write_read_test(); 
    rst.reset_test(); #10;
    under_flow.underflow_test(); 
    rst.reset_test(); #10;
    over_flow.overflow_test(); 
    rst.reset_test(); #10;
    simultaneous_read_write_empty.simultaneous_read_write_empty_test();
    rst.reset_test(); #10;
    simultaneous_read_write_full.simultaneous_read_write_full_test(); 
    //rst.reset_test(); #10;
    
    //initial begin
    //end
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
endmodule
