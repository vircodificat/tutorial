// Testbench for the tristate-bus lesson: two open-drain participants
// share one line. This file is read-only scaffolding; the lesson
// itself lives in src/.

module Tb;
    reg  pull_0 = 0;
    reg  pull_1 = 0;
    wire line_level;
    wire heard_0;
    wire heard_1;

    \top::Top dut(
        .pull_0(pull_0),
        .pull_1(pull_1),
        .line_level(line_level),
        .heard_0(heard_0),
        .heard_1(heard_1)
    );

    integer fails = 0;

    task check_line(input logic expected, input string what);
        if (line_level !== expected) begin
            $display("FAIL [%0t] %s: line_level=%b expected=%b",
                     $time, what, line_level, expected);
            fails = fails + 1;
        end else begin
            $display("PASS [%0t] %s", $time, what);
        end
    endtask

    task check_heard(input logic expected_0, input logic expected_1,
                     input string what);
        if (heard_0 !== expected_0 || heard_1 !== expected_1) begin
            $display("FAIL [%0t] %s: heard=(%b,%b) expected=(%b,%b)",
                     $time, what, heard_0, heard_1, expected_0, expected_1);
            fails = fails + 1;
        end else begin
            $display("PASS [%0t] %s", $time, what);
        end
    endtask

    initial begin
        // One waveform, whole story: the shared line, both
        // participants' stakes in it, and every hand and ear.
        $dumpfile("trace.vcd");
        $dumpvars(0, dut);

        // Power-on: both hands off. A polite open-drain line rests
        // high, held there by its pull-up.
        #10 check_line(1'b1, "power-on, nobody pulling: line idles high");
        #10 check_heard(1'b1, 1'b1, "both ears hear the idle-high line");

        // Participant 0 speaks: a strong low beats any weak pull.
        pull_0 = 1;
        #10 check_line(1'b0, "p0 pulls: strong low owns the line");
        #10 check_heard(1'b0, 1'b0, "both ears hear the pull, including p0's own");

        // Participant 1 joins: two strong lows agree. No argument,
        // because nobody ever drives this line high.
        pull_1 = 1;
        #10 check_line(1'b0, "p0 and p1 both pull: agreeing lows, still low");

        // Participant 0 lets go mid-conversation: p1 carries the
        // low alone.
        pull_0 = 0;
        #10 check_line(1'b0, "p0 releases, p1 still pulling: line stays low");
        #10 check_heard(1'b0, 1'b0, "p0 hears the line held low by its neighbor");

        // Everyone lets go: the line must find its way back up.
        pull_1 = 0;
        #10 check_line(1'b1, "both released: line returns to idle high");
        #10 check_heard(1'b1, 1'b1, "both ears hear idle high again");

        // Now participant 1 speaks alone.
        pull_1 = 1;
        #10 check_line(1'b0, "p1 pulls alone: strong low owns the line");
        #10 check_heard(1'b0, 1'b0, "p0's ear catches the neighbor's pull");

        // A short burst: pull, release, pull -- the texture a real
        // wired-AND conversation leaves on the wire.
        pull_1 = 0;
        #10 check_line(1'b1, "p1 releases again: idle high");
        pull_0 = 1;
        #10;
        pull_0 = 0;
        #10;
        pull_0 = 1;
        pull_1 = 1;
        #10 check_line(1'b0, "quick burst ends with both hands down: line low");

        // And one last polite landing.
        pull_0 = 0;
        pull_1 = 0;
        #10 check_line(1'b1, "final release: line pulled back up");

        if (fails == 0) begin
            $display("=== ALL CHECKS PASSED ===");
        end else begin
            $display("=== %0d CHECK(S) FAILED -- see trace.vcd ===", fails);
            $fatal;
        end
        $finish;
    end
endmodule
