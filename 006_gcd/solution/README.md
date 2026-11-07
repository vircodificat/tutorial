# What was wrong

In the `Run` state the `when x < y` arm needs to shrink `y` towards `x`:

    y <= y - x

The broken version wrote `x <= x - y` instead, updating `x` and subtracting
in the wrong direction. Because `x < y`, the subtraction underflows and wraps
around in 8-bit arithmetic, launching `x` to a large value above `y`. The
machine then counts `x` back down by subtracting `y` repeatedly — and by
coincidence lands on `y`, declaring that value the GCD. For `gcd(4, 26)` the
wrong answer is `26`; the right answer is `2`.

The fix is a single-arm change: update `y` instead of `x`, and subtract `x`
from `y` rather than the other way round.
