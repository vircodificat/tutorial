# Solution

The bug: inside the guarded `#Sub` arm, the two inner arms were in
the wrong order.

Arms are tried in order, and the first matching arm wins. The
guarded arm meant to say "subtract when the subtraction fits, clamp
to zero when it does not" — but with the arms crossed, the `when
a >= b` arm produced `0` for every subtraction that actually fit,
and the `else` handed back a wrapped, underflowed `a - b` for every
one that didn't. `7 - 3` came back as `0`, and `3 - 7` came back as
`0xFC`. The other ops were untouched, which is what pointed at the
guard: only `#Sub` was wrong, and only the guard lives there.

The fix restores the order the comment promised:

`when a >= b => a - b`, with `else => 0` catching the clamp.

Now the first matching arm is the subtraction whenever it fits, and
the clamp only gets a turn at the bottom of the word. `make test`
is green again.
