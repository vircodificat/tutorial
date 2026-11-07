# Shifting Without a Shift

There is no `<<` in Virdant — a shift is just wiring.

`BarrelShifter` in `src/top.vir` should slide `value` left by `shamt`
bits, zeros pouring in underneath. It does it the hardware way: a
ladder of three stages, each shifting by 1, 2, or 4 bits, selected by
one bit of `shamt`. One rung of that ladder is wired to the wrong
bits, though — everything compiles clean, and the shifts simply come
out crooked.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see which shift amounts come out crooked.

## Stuck?

In a left shift, the bits that survive are the low ones — they are
the ones that climb, while the high bits fall off the end. Look
closely at which slice the middle stage takes, and mind the width: a
slice's top index is exclusive, so it holds `hi - lo` bits.
