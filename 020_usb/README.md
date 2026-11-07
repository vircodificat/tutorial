# Putting Bits on the Wire

USB is a tall, tall cake of protocols — layers upon layers of
packets, enumerations, and handshakes. But every one of those layers
ends at the same place: a single wire, carrying a single level,
changing at exactly the right moments. `UsbEncoder` in `src/top.vir`
is that last step. It takes a byte and produces the line levels a
real USB transmitter would put on the wire, following two small,
beautiful rules: NRZI encoding, and bit stuffing.

Except the wire is lying. The design compiles cleanly, but one of
the two rules has gone subtly wrong, and the test knows it.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the wire tells the truth.

## Stuck?

Read `test.poke` alongside the source: it walks through each byte
bit by bit, and the comment above every assert names the rule that
was supposed to produce that level. Find the first assert that
fails, count back to the bit that produced it, and ask which of the
two rules was cheated — and by how much.
