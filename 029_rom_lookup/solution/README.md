# Solution

The bug: the ROM's output was latched through a register.

`HexAsciiRom` is a lookup table — a `match` with sixteen constant
arms, one per nibble. Constant data needs no clock and no memory of
the past: the address walks in, and the matching row's byte is simply
what the wires say. But the broken design fed the table through
`ascii_held`, a `Word[8]` register clocked on every edge, and drove
the output port from that register instead. The first `make test`
assert showed it plainly: with `nibble` poked to `0x0`, `ascii` read
`0x00` — the register's power-on value — because `advance` settles
combinational wiring but drives no clock, and the table's answer was
waiting for an edge that never came. Even with ticks, the output
would only ever trail the address by one full cycle: a ROM that
answers yesterday's question.

The fix removes everything that was holding the answer. The
`ascii_held` register is gone, and the outgoing port drives the match
directly, combinationally:

`it := match nibble { ... }`

With the register went the clock — the port's `dependson nibble`
declares the only thing the answer depends on, and the design now
contains no clock at all, which `vir check` is entirely at peace
with. Sixteen constant arms grown into plain wiring: poke any
address, and the byte is already there.
