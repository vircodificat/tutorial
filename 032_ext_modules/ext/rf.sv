// The vendor's register file: the Verilog that `ext mod rf::Rf` in
// src/rf.vir stands for.  `vir check` and `vir poke` never look in
// here — the simulator models the box natively — but a synthesis
// flow compiles this file (see build/ext after `vir build`).
//
// Configurable through Verilog parameters, which is how Virdant
// reaches it: `@parameter("XLEN", ...)` and `@parameter("READ_LATENCY",
// ...)` render into the instance declaration.  READ_LATENCY = "ZERO"
// gives combinational reads; "ONE" registers them for a cycle.
module \rf::Rf #(
    parameter XLEN        = 32,
    parameter READ_LATENCY = "ONE"
) (
    input  wire             clock,
    input  wire             write,
    input  wire      [4:0]  rd,
    input  wire      [XLEN-1:0] rd_in,
    input  wire      [4:0]  rs1,
    input  wire      [4:0]  rs2,
    output reg       [XLEN-1:0] rs1_out,
    output reg       [XLEN-1:0] rs2_out
);
    reg [XLEN-1:0] mem [0:31];

    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            mem[i] = {XLEN{1'b0}};
        end
        rs1_out = {XLEN{1'b0}};
        rs2_out = {XLEN{1'b0}};
    end

    // Registered write. x0 is hardwired to zero: a write aimed there
    // is silently dropped.
    always @(posedge clock) begin
        if (write && rd != 5'd0) begin
            mem[rd] <= rd_in;
        end
    end

    // Reads: combinational, or registered for one cycle.
    generate
        if (READ_LATENCY == "ZERO") begin : g_zero
            always @* begin
                rs1_out = mem[rs1];
                rs2_out = mem[rs2];
            end
        end else begin : g_one
            always @(posedge clock) begin
                rs1_out <= mem[rs1];
                rs2_out <= mem[rs2];
            end
        end
    endgenerate
endmodule
