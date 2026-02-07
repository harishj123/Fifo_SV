class overflow_test;
   /*rst_gen reset; // Declare a handle of type rst_gen

  // Constructor that takes in the reset object
  function new(rst_gen r);
    reset = r;
  endfunction*/
  
  task overflow_test();
    $display("-----------Overflow test--------------");
    begin
      
      // Fill the FIFO completely
      for (int i = 0; i < DEPTH; i++) begin
        write_en = 1;
        data_in = i;
        $display("Overflow Write : %0d",data_in);
        #10;
        write_en = 0;
        #10;
      end
      
      // Attempt to write additional data
      write_en = 1;
      data_in = 16'hFFFF;
      $display("Overflow Read = %0h",data_in);
      #10;
      write_en = 0;
      if (!overflow) begin
        $error("Overflow Test: Overflow flag should be asserted");
        error_count++;
      end
      //reset.rst_gen();
      // Read out all values and verify
      for (int i = 0; i < DEPTH; i++) begin
        read_en = 1;
        #10;
        read_en = 0;
        $display("Overflow Read = %0d",data_out);
        if (data_out != i) begin
          $error("Overflow Test: Data mismatch at index %0d: expected %0d, got %0d", i, i, data_out);
          error_count++;
        end
        #10;
      end

      // Ensure the overflowed value is not in the FIFO
      read_en = 1;
      #10;
      read_en = 0;
      $display("-----------Overflow test--------------");
      if (!empty) begin
        $error("Overflow Test: FIFO should be empty after reading all values");
        error_count++;
      end
    end
  endtask
endclass
