//======================================================
// counter.sv
// Parameterized Up Counter with Terminal Count (tc)
//======================================================
module counter #(
  parameter WIDTH = 8,             // Counter width
  parameter MAX_COUNT = (1 << WIDTH) - 1  // Default terminal value
)(
  input  logic              clk,      // Clock
  input  logic              rst_n,    // Active-low reset
  input  logic              en,       // Enable
  output logic [WIDTH-1:0]  count,    // Counter value
  output logic              tc        // Terminal count (pulse)
);

  // Sequential Counter Logic
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      count <= '0;
    else if (en) begin
      if (count == MAX_COUNT)
        count <= '0;
      else
        count <= count + 1'b1;
    end
  end

  // Terminal Count (1 when count reaches MAX_COUNT)
  assign tc = en && (count == MAX_COUNT);

endmodule
