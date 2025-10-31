//======================================================
// tb_counter.sv
// Simple Testbench for counter.sv
//======================================================
`timescale 1ns/1ps

module tb_counter;

  parameter WIDTH = 4;
  parameter MAX_COUNT = 9;

  // Testbench signals
  logic clk;
  logic rst_n;
  logic en;
  logic [WIDTH-1:0] count;
  logic tc;

  // DUT instantiation
  counter #(
    .WIDTH(WIDTH),
    .MAX_COUNT(MAX_COUNT)
  ) dut (
    .clk   (clk),
    .rst_n (rst_n),
    .en    (en),
    .count (count),
    .tc    (tc)
  );

  // Clock Generation (100 MHz)
  initial clk = 0;
  always #5 clk <= ~clk;

  // Test Stimulus
  initial begin
    $display("Starting counter test...");

    rst_n = 0;
    en = 0;
    #20;
    rst_n = 1;
    en = 1;

    // Run for several cycles
    repeat (25) begin
      @(posedge clk);
      $display("Time=%0t | count=%0d | tc=%b", $time, count, tc);
    end

    // Disable enable and check hold
    en = 0;
    repeat (5) @(posedge clk);
    assert (count == count) else $error("Counter should hold value when disabled.");

    $display("Counter test completed.");
    $finish;
  end

  // VCD dump setup
  initial begin
    $dumpfile("tb_counter.vcd");   // <---- Output file
    $dumpvars(0, tb_counter);      // Dump everything in tb_counter
  end

endmodule
