module rom_tb();

logic clk;
logic [7:0] addr;
logic [7:0] data;

 initial begin
    clk  = 0;
    addr = 0;
 end
 always #5 clk = ~clk;
 always #10 addr = addr +1; 



rom # (
  .ADDR_WIDTH  (8         )                                                    , //!
  .DATA_WIDTH  (8         )                                                    , //!
  .MEM_FILE    ("C:/Users/james/workspace/FPGA/rom/rom.srcs/sources_1/new/sbox.mem")                                                     //!
) dut (
  .clk_i       (clk)                                                     , //!
  .addr_i      (addr)                                                     , //!
  .data_o      (data)
);

endmodule
