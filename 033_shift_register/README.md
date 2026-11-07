# The Sliding Window

A shift register is one register with a window over it, and
`ShiftRegister` in `src/top.vir` knows four ways to move that
window: hold still, slide one bit right toward bit 0, slide one
bit left toward bit 7, or swap the whole window for a fresh word
in a single cycle. The `mode` port picks the move, `sin` is the
bit that trickles in while the window slides, `din` is the load
word — and `sout` always shows whichever bit is about to fall off
the edge, which turns out to depend on the direction.

The register compiles cleanly, but when `test.poke` walks it left,
right, and both ways again, the waveform disagrees with somebody
about which way is which. Find out why.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the window slides where it should.

## Stuck?

`word()` lists its arguments most-significant first. One of the
two slide arms feeds `sin` in from the wrong end — ask yourself
which edge of the window a left slide should enter through.
