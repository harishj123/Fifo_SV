class clk_gen;
   task clk_gen();
     clk=0;
     forever #5 clk=~clk;
  endtask
endclass
