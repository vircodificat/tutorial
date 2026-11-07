# Now You're Listening

The wire has been talking; this lesson is about the other end.
`UartReceiver` in `src/top.vir` waits for a resting-high line to
fall, then samples it once per bit period — four clock cycles per
bit here, a fast fake baud — gathering a low start bit, eight data
bits with the least significant one first, and one high stop bit
that closes the frame. A good frame pops out of `out` as a byte; a
bounce that isn't a start bit and a frame that never raises the
line again are both quietly dropped.

The receiver compiles cleanly, but when `test.poke` plays frames
into the line — a good byte, a bounce, a frame with no stop bit,
the same byte again — the bytes come out wrong. Find out why.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the receiver hears what the wire says.

## Stuck?

Hold a mirror up to the first byte the receiver reports. Each
sample walks the line's value into the shifter — ask which end a
least-significant-first byte should enter from, and which end this
one does.
