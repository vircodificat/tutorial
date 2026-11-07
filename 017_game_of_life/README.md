# The Garden of Clockwork

Conway's Game of Life, blooming in sixteen registers.

`GameOfLife` in `src/top.vir` keeps a 4x4 colony in a single register:
`load` plants a pattern, and every clock edge with `step` high grows
the whole board one generation — births, survivals, deaths, all in the
same heartbeat. The tests plant a blinker, a block, and a few harsher
seasons, but this garden will not pass them: one cell is counting a
neighbor it should not.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to watch the garden grow (or fail to).

When the test finally goes green, open `trace.vcd`: a blinker folding
over itself, a block content forever, a diamond ring settling out of
chaos — every generation swapped in whole, in a single tick.

## Stuck?

Each cell's `count` should add up exactly the neighbors its comment
names — traced from the geometry, where row r, column c is bit 4r + c.
Compare every wire's terms against its comment; one cell has an extra
listener.
