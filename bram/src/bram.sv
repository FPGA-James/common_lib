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
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

//input pkg_bram::*;
`include "../src/if_bram.sv"
//! Module description
module bram 
#(
  parameter P_DATA_WIDTH = 32, //! Data Width for the memory
  parameter P_ADDR_WIDTH = 8  //! Address width for the memory
) 
(
  if_bram.slave   bram //! if_bram slave interface
);

// define memory and length
logic [P_DATA_WIDTH-1:0] memory [(2 **P_ADDR_WIDTH)-1:0]; // create an unpacked array

// enable handler

// write data handler
always_ff @( posedge bram.clk or negedge bram.rst_n ) begin : l_write_data
  if (!bram.rst_n) begin
    memory <= '{default:0};               // reset array
  end else if ((bram.cs) && (bram.we)) begin
    memory[bram.addr] <= bram.data_i;      // write data into selected address
  end
end

// read data handler
assign bram.data_o  = (bram.cs && bram.oe) ? memory[bram.addr] : {P_DATA_WIDTH{1'bz}};

endmodule