# Double Dabble

Binary in, BCD digits out — the bridge between arithmetic and the
displays that show it.

`DoubleDabble` in `src/top.vir` converts an 8-bit binary number into
the three BCD digits a seven-segment display is waiting for. It runs
the classic shift-add-3 algorithm — but as hardware: the loop's body
is combinational wiring, and the loop itself is a step counter, one
step per clock. Raise `start`, and eight clocks later `done` comes
back up with the answer resting in `ones`, `tens`, and `hundreds`.

Except the beat is broken. The design compiles cleanly, but the loop
never finishes its work, and `make test` knows it.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to hear whether the loop keeps time.

## Stuck?

The first failing assert is about the loop's progress, not its
arithmetic. Run one conversion and watch `top.step` in `trace.vcd`:
in a healthy run it climbs once per clock until all eight steps are
done. A software loop advances its own index; hardware has no `for`
to do that for it — some register has to take the job.
