# The Tank's Pecking Order

Three requests can land on the same clock edge, and this water tank
is supposed to know which one is boss: `drain` overrules `fill`,
which overrules `drop`. But the tank has been misbehaving — press
two buttons at once and the weaker request somehow wins the edge.

The suspects live in `src/top.vir`, where the three requests are
written as stacked `when` arms inside one driver block.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the tank keeps its priorities straight.

## Stuck?

The arms are tried from top to bottom, and the first one whose
condition is true fires — every arm below it is skipped until the
next clock edge. Check who gets the first word when `drain` and
`drop` land together.
