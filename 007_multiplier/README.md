# The Shift-and-Add Multiplier

Multiplication on hardware is a surprising thing: you can multiply two
numbers with nothing more than an adder and a shift register, one bit
at a time, one clock edge at a time.

`Multiplier` in `src/top.vir` does exactly that. It takes two 4-bit
numbers, `a` and `b`, and over four work cycles it accumulates partial
products into an 8-bit result. Assert `start`, wait four ticks, and
`done` lights up with `product` ready.

Something is off, though — several of the test cases produce the wrong
answer. The design compiles cleanly, so the bug is in the behaviour, not
the types. The logic of the shift-and-add algorithm is all there; one
small decision is pointing at the wrong place.

Work with two commands:

1. `vir check` — while reading and editing.
2. `make test` — to see whether the multiplier actually computes.

## Stuck?

Each work cycle, `mp` shifts right by one bit. The multiplier peeks at
one bit of `mp` to decide whether to add this cycle's shifted copy of
`a`. Which bit should it always peek at after each shift?
