/*
The MIT License (MIT)

Copyright (c) 2022 - Fleeting Digital Designs.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
data_o OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

//! This wilkl infer a ROM for the SBOX

module rom
#(
  parameter integer ADDR_WIDTH  = 8                                            , //!
  parameter integer DATA_WIDTH  = 8                                            , //!
  parameter         MEM_FILE    = "init.mem"                                    //!
)(
  input     logic                     clk_i                                   , //!
  input     logic   [ADDR_WIDTH-1:0]  addr_i                                  , //!
  output    logic   [DATA_WIDTH-1:0]  data_o                                    //!
);

// create memory array from parameters
logic [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH];

  initial begin
    //$readmemh(MEM_FILE, mem, 0, (2**ADDR_WIDTH));                                     //! populate mem array with contents of the file
    $readmemh(MEM_FILE, mem);                                     //! populate mem array with contents of the file
  end

  always_ff @(posedge clk_i ) begin : l_mem_array
    data_o <= mem[addr_i];
  end
endmodule
