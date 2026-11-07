# Solution

The bug: `slot0` never moved on a pop.

A queue only works if the whole line moves together. When `pop`
serves the byte at the front, every byte behind it must slide one
slot closer to the door — but `slot0` had no arm to catch the byte
sliding out of `slot1`. The queue kept serving the same first byte
while `count` cheerfully reported one fewer. The waveform told the
story: after two pushes and a pop, `out` still showed the very first
byte pushed.

The fix is the missing arm in `slot0`'s driver block:

`when pop && count == 2 { it <= slot1 }`

The guard is doing the quiet thinking here. The slide only makes
sense when a pop actually happens *and* the back slot truly holds a
byte (`count == 2`) — a pop from a one-byte queue empties it, and
there is nothing to slide into anywhere. With the arm in place, all
three registers move as one, and `make test` is green.
