# The Patient Subtractor

Most algorithms race to their answer in a single step. Some take their
time, circling through a small set of states until the answer ripens.
That is how hardware loops — not with a `while` keyword, but by
visiting the same state over and over, one clock edge at a time.

`Gcd` in `src/top.vir` is a small machine that finds the greatest
common divisor of two bytes using Euclid's subtraction algorithm. It
has three states, two working registers, and a start/done handshake —
but something in its `Run` state is wrong, and the test already knows
it.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the computation actually converges.

## Stuck?

The `Run` state has three cases: larger, smaller, equal. Each of the
first two should bring the working registers one step closer together.
Check carefully which register each subtraction updates.
