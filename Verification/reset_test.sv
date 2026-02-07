class reset_test;
  task reset_test();
    reset_n = 0;
    #10
    reset_n = 1;
  endtask
endclass
