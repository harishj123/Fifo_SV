// underflow_test.sv

class underflow_test;

  
  /*rst_gen reset; // Declare a handle of type rst_gen

  // Constructor that takes in the reset object
  function new(rst_gen r);
    reset = r;
  endfunction*/

  task underflow_test();
    $display("----------------underflow Test--------------------------");
    begin
      data_out_check = data_out;
      // Load a single value
      write_en = 1;
      data_in = 16'hA5A5;
      $display("Underflow write data : %0h",data_in);
      #10;
      write_en = 0;
      #10;

      //reset.rst_gen(); // Now valid: reset is passed from TB

      // Attempt to read while empty
      read_en = 1;
      #10;
      $display("Underflow Read data : %0h",data_out);
      read_en = 0;
      #10
      
      /*if (!underflow) begin
        $error("Underflow Test: Underflow flag should be asserted");
        error_count++;
      end
      if (data_out != data_out_check) begin
        $error("Underflow Test: Data out should be unchanged from last read value when underflow occurs.");
        error_count++;
      end*/
    $display("----------------underflow Test completed--------------------------");
      end
  endtask

endclass
