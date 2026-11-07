# Many Hands, One Wire

Two participants share a single open-drain line — the same bargain
real I2C wiring strikes. Nobody ever drives the line high; anyone may
pull it low; and when every hand comes off, the wire should settle,
politely, back to one. This one doesn't settle.

The design compiles cleanly, but `make test` disagrees: the line goes
flat at exactly the moments the testbench calls idle. The break is in
`src/top.vir` — `src/participant.vir` behaves, and the testbench
`tb.sv` is read-only scaffolding.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` — this lesson's testbench is simulated with Icarus
   Verilog, and it leaves a `trace.vcd` waveform behind so you can
   walk the whole conversation step by step.

## Stuck?

Notice the shape of the failures: every "pull" check passes, and
every "idle" check fails. An open-drain line held up only by voices
is a trellis with no vine — the moment everyone lets go, nothing is
left to lift the wire. Ask yourself who was supposed to be doing the
lifting, and what a driver that pulls but never wins an argument
looks like.
