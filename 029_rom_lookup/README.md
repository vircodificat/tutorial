# The Little Table

Sixteen bytes of constant data, ready the moment you ask.

`HexAsciiRom` in `src/top.vir` is a tiny ROM: give it one hex nibble
and it hands back the ASCII code of that nibble's printed character —
the same little table that lives inside every memory dump and hex
display. All sixteen rows are there, the table is honestly beautiful,
and `vir check` has not a word of complaint.

But a ROM's answers come from wiring, not from waiting, and this one
has grown slow as a shady afternoon. `make test` asks an address and
checks the byte arrives right away — something in the garden is
making it late.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the table answers on time.

## Stuck?

Nothing in a table of constants needs to be remembered between
questions. Look for the part of this design that is holding the
answer back, and let it go — the whole design can live happily
without it.
