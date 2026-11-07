# First In, First Out

Queues are the politest of data structures: first come, first served.

You have surely queued things in software. Here is a queue made of
clock edges instead. `Fifo` in `src/top.vir` is a two-slot queue for
bytes: `push` adds a byte to the back of the line, `pop` serves the
oldest byte on `out`, and `empty` and `full` report how the queue is
doing. Something is off, though — push two bytes, pop one, and the
wrong byte steps forward.

The queue lives in `src/top.vir`, and one of its registers has
forgotten how the line moves.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the queue actually behaves.

## Stuck?

When a byte is served from the front, every byte behind it slides one
slot closer to the door. `count` already knows how many bytes are
waiting — write the missing arm in `slot0` that performs the slide,
but only when the back slot truly holds a byte.
