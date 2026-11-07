# Three Views of a Sum

Every good formula has a middle step worth naming.

`Averager` in `src/top.vir` adds two bytes and reports the sum three
ways: the full-width `total`, the `carried` bit, and a rounded
`average`. The average's driver was meant to name its intermediate
values with `let` bindings, but the bindings were never written, and
the module will not even compile.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the three outputs agree with the math.

## Stuck?

The driver wants two names, and one of them leans on the other.
Bind them together in a single comma-separated `let` list, widest
math first, and keep the driver inside the braces.
