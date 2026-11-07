# Four Doors, One Question

A multiplexer is the gardener's question mark: one question, four
possible answers, exactly one picked.

`Mux4` in `src/top.vir` is a 4:1 multiplexer. Four bytes arrive on
`a`, `b`, `c`, and `d`, and a two-bit `sel` decides which one flows
out on `out`. Or at least, it should — with `sel` pointing one way,
the wrong door opens.

The selection logic lives in `src/top.vir`. One of its questions is
being asked backwards.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the mux actually behaves.

## Stuck?

Only some of the four selections come out wrong. Watch which ones:
they are the pair picked by the very first question, and a question
asked backwards gets its answers backwards too.
