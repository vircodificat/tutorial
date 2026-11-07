# Solution

The bug: the wrap condition used `count == 4` (one less than the limit)
instead of `count == 5`.

A mod-N counter wraps *after* the counter reaches the limit value, not
before. With `when count == 4`, the counter snapped back to zero as soon
as it hit 4 — so 5 was never placed on `value`, and `at_limit` never
pulsed high.

The fix is to compare against the actual limit:

    when count == 5 {
        it <= 0
    }

Now the counter steps through 0, 1, 2, 3, 4, 5, then wraps. The limit
value (5) is visible on `value` for exactly one clock cycle, and
`at_limit` goes high to announce it. The cycle after that, the edge
fires and `count` becomes 0 again.
