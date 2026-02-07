class basic_write_read_test;
  /*rst_gen reset; // Declare a handle of type rst_gen

  // Constructor that takes in the reset object
  function new(rst_gen r);
    reset = r;
  endfunction*/
   task basic_write_read_test();
     $display("-------Basic Write Test-------");
    begin
      //reset.rst_gen();
      // Write values from 0 to DEPTH-1
      for (int i = 0; i < DEPTH; i++) begin
        write_en = 1;
        data_in = i;
        $display("Write = %0d at index of %0d",data_in,i);
        #10;
        write_en = 0;
        #10;
        
      end
      $display("-------Basic Write Test completed-------"); 
      // Check full flag
      if (!full) begin
        $error("Basic Write/Read Test: FIFO should be full");
        error_count++;
      end
      $display("-------Basic read Test-------");
      // Read values back and verify
      for (int i = 0; i < DEPTH; i++) begin
        read_en = 1;
        #10;
        read_en = 0;
        $display("Read = %0d at index of %0d",data_out,i);
        if (data_out != i) begin
          $error("Basic Write/Read Test: Data mismatch at index %0d: expected %0d, got %0d", i, i, data_out);
          error_count++;
        end
        #10;
      end
      $display("-------Basic read Test completed-------");
      
      // Check empty flag
      if (!empty) begin
        $error("Basic Write/Read Test: FIFO should be empty");
        error_count++;
      end

      // Check overflow and underflow flags
      if (overflow) begin
        $error("Basic Write/Read Test: FIFO should not overflow");
        error_count++;
      end
      if (underflow) begin
        $error("Basic Write/Read Test: FIFO should not underflow");
        error_count++;
      end
    end
  endtask
endclass
