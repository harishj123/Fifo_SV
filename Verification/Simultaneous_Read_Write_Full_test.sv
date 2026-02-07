class  simultaneous_read_write_full_test;
   /*rst_gen reset; // Declare a handle of type rst_gen

  // Constructor that takes in the reset object
  function new(rst_gen r);
    reset = r;
  endfunction*/
  
  task simultaneous_read_write_full_test();
    $display("-----------------Simultaneous read write full test----------------");
    begin

      //reset.rst_gen(); // Now valid: reset is passed from TB

      // Write FIFO to full
        write_en = 1;
        for (int i = 0; i < DEPTH ; i++) begin 
          data_in = i;
          $display("simultaneaus read write full test data : %0d",data_in);
          #10;
        end

        write_en = 0;
        data_out_check = data_in; 
        #10;
      // Verify full flag is set
      if (!full) $error("Simultaneous Read/Write While Full Test: FIFO should be full");

        // Enable simultaneous read and write
        write_en = 1;
        read_en = 1;
        data_in = 16'h9ABC;
      $display("simultaneaus read write test data : %0h",data_in);
        #10;
        write_en = 0;
        #10;
        
        // check to see if overflow is triggered
        if (!overflow) begin
          $error("Simultaneous Read/Write While Full Test: Overflow flag should be asserted on first simultaneous read/write");
          error_count++;
        end
        
        write_en = 1;
        for (int k = 0; k < DEPTH+5; k++) begin
          #10;
          $display("simultaneaus read write test data : %0h",data_out);
          if (k == DEPTH-3 && data_out != data_out_check) begin 
            $error("Simultaneous Read/Write While Full Test: Data out should be match saved value, %0h. Instead a value was written while overflow was asserted: %0h.", data_out_check, data_out);
            error_count++;
          end
          else if (k > DEPTH-3 && data_out != data_in) begin
            $error("Simultaneous Read/Write While Full Test: Data out should be match continuous input value, %0h, after overflow is cleared and simultaneous read/write is allowed.", data_in);
            error_count++;
          end
        end
        write_en = 0;
        read_en = 0;
      $display("-----------------Simultaneous read write full test completed----------------");
    end
  endtask
endclass
