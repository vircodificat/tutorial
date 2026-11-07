# The Cheapest Random Numbers in Hardware

Pseudo-random bytes with no adder, no multiplier, not even a
counter — just a shift register feeding a few of its own bits back
into itself.

`Lfsr` in `src/top.vir` is meant to be a *maximal-length* 8-bit
linear-feedback shift register: planted with the seed 0xAC, it should
wander through all 255 nonzero bytes before repeating a single one.
It compiles cleanly, but the sequence coming out of `out` is not the
golden one the test knows, and somewhere along the way the register
leaves the path.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the register really is maximal.

## Stuck?

The feedback XOR reads four tap bits, and the taps are the whole
personality of an LFSR — a wrong tap still looks random, it just
isn't maximal anymore. Map the polynomial in the comment back onto
bit positions and compare it, bit by bit, against what the XOR line
actually reads.
