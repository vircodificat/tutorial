# Plug and Play

A bus is a bundle of wires that have agreed on a conversation:
one side raises a hand, the other answers, and data crosses between them.

In `src/top.vir` a tiny master runs a five-step errand across a
four-byte memory: write two bytes, then read them back. Master and
memory each speak their half of the conversation through a socket
named `Wishbone` -- a Virdant socket gathers every signal of a bus
into one named thing. Both halves are present and correct, but
`vir check` insists that nobody is listening on either end.
Something that should join them has gone missing.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the errand actually completes.

(The handshake here is a simplified cousin of the real Wishbone
bus -- same strobe-and-acknowledge idea, trimmed to what a lesson
needs.)

## Stuck?

Master and memory are two plugs with nothing between them. In
`Top`, a single line -- one operator -- connects two sockets of
the same kind, every channel at once, each in its own direction.
