# Traffic Lights

An intersection with a memory of its own: green for one road, yellow,
then the other road takes its turn.

`TrafficLight` in `src/top.vir` runs a four-phase cycle for a
north-south road and an east-west road. Each direction gets its green
and its short yellow while the other waits at red. The whole design
orbits one safety rule: the two roads must never both be green, and
yellow must always come before the change.

It compiles, the lights cycle along, and the test still fails. One
phase turns the wrong way, and a whole direction is left waiting at
the curb.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to watch the lights actually behave.

## Stuck?

The transition table in `next_state` is the heart of the controller.
Read the four arrows and ask, of each one: does this hand the road
to the *other* direction?
