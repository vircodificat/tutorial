# Solution

The bug: the two bindings in `average`'s `let` list were written in
the wrong order.

A comma-separated `let` list is read left to right, one binding at a
time. Each binding may use the names bound *before* it, but the
bindings after it are still unbound at that point. The broken code
asked `rounded` to lean on `sum` while `sum` had not been bound yet,
so the compiler rejected the driver with "Unknown component sum" --
as far as it could see, no such name existed at that line.

The fix simply puts `sum` first:

    let sum : Word[9] = a +. b,
        rounded : Word[9] = sum + 1w9 {
        it := rounded[9..1]
    }

Now `rounded` is computed from an already-bound `sum`, and the whole
driver reads like the math it performs: widen the addition with `+.`,
add one so the rounding tips halves up, then slice off the bottom
bit to divide by two.
