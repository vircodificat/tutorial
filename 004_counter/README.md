# Count, Wrap, Repeat

A counter that knows when to stop — almost.

`ModCounter` in `src/top.vir` counts from zero up to a fixed limit
and wraps back to zero, cycling forever. A `load` input lets you jump
the counter to any starting value, and an `at_limit` flag pulses high
for the one cycle when the limit is actually reached.

The design compiles, but it wraps one cycle too early: the limit value
itself is never visible on `value`. Find the wrap condition and correct
the comparison.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to watch the counter step through its full cycle.

## Stuck?

The wrap condition compares `count` to a number. What number should
it be? Walk through what the test expects step by step.
