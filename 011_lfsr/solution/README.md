# Solution

The bug: one tap was wrong. The feedback XOR read `lfsr[2]` where it
should have read `lfsr[4]`, so the register was really running the
polynomial x^8+x^5+x^3+1 instead of x^8+x^6+x^5+x+1. It still
compiled, it still shifted, it still looked busy and random — which
is exactly what makes a wrong tap so sneaky. An LFSR never *looks*
broken; it just stops being maximal, and only the golden sequence
can tell.

The fix is one bit in the feedback:

`it := lfsr[0] ^^ lfsr[2] ^^ lfsr[5] ^^ lfsr[7]`
becomes
`it := lfsr[0] ^^ lfsr[4] ^^ lfsr[5] ^^ lfsr[7]`

With the correct tap set, the test's first ten golden bytes land one
after another, the register walks a hundred and twenty steps without
ever touching zero, and the late-sequence checks at steps 100, 110
and 120 pass too. A maximal LFSR keeps every promise it makes: all
255 nonzero bytes, in order, before a single repeat.
