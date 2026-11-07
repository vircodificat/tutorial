# The Deciding Circuit

Arms that produce, arms that perform: `match` is how a circuit
decides.

`Alu` in `src/top.vir` is a tiny arithmetic-logic unit. An `opcode`
picks what happens to operands `a` and `b`, `result` carries the
answer, and two flag ports describe the op that ran. Every decision
in it is a `match` — one in expression position, producing values;
one in statement position, performing work. It all compiles just
fine, but it does not pass yet: some subtractions come back wrong,
while the other ops behave. Find out why, and put the match back on
speaking terms with itself.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the ALU really computes.

## Stuck?

Arms are tried in order, and the first matching arm wins. Read the
guarded `#Sub` arm slowly: whichever inner arm the guard's condition
reaches first is the one that produces the result — for every
subtraction, not just the ones it was meant for.
