# Solution

The bug: two of the stacked arms were in the wrong order.

A stack of `when` arms is not a list of independent rules -- it is
a pecking order. The arms are tried from top to bottom, and the
FIRST one whose condition is true fires; every arm below it is
skipped until the next edge. The broken tank had `drop` written
first and `drain` last, so on any edge where both fired, the drop
got the first word and the drain never got to speak: the tank rose
by one at the very moment it was told to empty.

The fix puts the arms back in order of authority, strongest first:

    when drain {
        it <= 0
    }
    when fill {
        it <= 9
    }
    when drop && it != 9 {
        it <= it + 1
    }

That is also why the test presses two buttons at once: `make test`
fails exactly on the colliding cycles (fill+drop, drain+drop,
drain+fill, all three together), where a weaker request was stealing
the edge from its boss. Singles and quiet cycles all passed before
and after the fix -- only the collisions knew the difference.
