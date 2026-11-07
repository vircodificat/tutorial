# The Black Box in the Garden

Real boards are full of black boxes: memory, PHYs, register files --
Verilog someone else wrote, tuned with parameters, documented only by
its ports. Virdant adopts them with `ext mod` and `@parameter`, and
this lesson wires one up as if it grew here.

`Top` in `src/top.vir` is a small shell around a vendor register file.
The box's declaration lives in `src/rf.vir` -- ports only, no logic --
and the Verilog it stands for is `ext/rf.sv`. Once the shell is whole,
`make test` runs the design on the virtual board: it plants a few
words in the file, reads them back through both ports, drops one write
on the floor at x0, and prints the whole story one line of hex at a
time.

But the tour never left the station. `src/top.vir` does not pass
`vir check` yet, and one piece of the wiring is missing: the shell
never told the box which flavor of hardware to be.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to watch the tour come out, line by line.

## Stuck?

The check's message says what ext mods cannot be tuned with, and what
to reach for instead. The name and value to pass are written down
twice: once as the vendor's declared defaults in `src/rf.vir`, and
once in the Verilog in `ext/rf.sv`. This shell was written for the
flavor where the answer arrives the very cycle the question does.
