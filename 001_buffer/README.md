# The Patient Byte

A register only lets go of its value when a clock edge tells it to.
`Buffer` in `src/top.vir` should capture its input once per clock
edge and hold the captured byte on `out` between edges — but it
will not even compile. Whoever wrote it drove the register as
though it were a wire.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the buffer really holds a byte
   between clock edges.

## Stuck?

A `reg` is not a wire: it cannot be driven by a stray statement
outside its own block. Its driver belongs inside the `reg` block,
where every clock edge can reach it.
