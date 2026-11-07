# Solution

The bug: `buffer` was driven like a wire.

A `reg` is a register, not a wire. It updates only on clock edges,
so it only accepts drivers written with `<=`, and those drivers
live inside its own block. The broken code had a stray
`buffer := inp` statement outside the `reg`, which the compiler
rejects with "Wrong driver type for buffer, expected <=" — a
register cannot be sampled combinationally, because with no clock
edge there is no moment to sample at.

The fix moves the sampling driver inside the `reg` block, guarded
by `when true` so it fires at every clock edge:

    reg buffer : Word[8] {
        initial it <= 0
        if {
            when true {
                it <= inp
            }
        }
    }

Now `buffer` samples `inp` once per clock edge and holds the value
until the next one, which is exactly what `make test` checks: poke
a new input, and `out` only moves after a `tick`.
