# Solution

The bug: the first question was asked backwards.

The lower pair of inputs is chosen by `sel[0]`. The broken code read
`when sel[0] => a`, which serves `a` when the bit is *set* and `b`
when it is clear — exactly the reverse of the design's intent, so
selections 0 and 1 came out swapped while 2 and 3 stayed correct.

The fix flips the question back around:

    when sel[0] => b
    else => a

A `when` arm in expression position produces a value with `=>`, and
the condition is the question being asked: `sel[0]` set means `b`
takes the seat. With that one line corrected, `make test` walks `sel`
across all four values and finds the right byte at every door.
