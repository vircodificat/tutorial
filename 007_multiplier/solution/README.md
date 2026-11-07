# Solution

The bug: the add step checked the wrong bit of the multiplier shift register.

Each work cycle, `mp` shifts right by one place: the bit at position
zero was just examined, and the shift moves the next candidate bit down
into that spot. So the correct guard is always *bit zero* of `mp` —
whatever bit has arrived there from the original `b`.

The broken code read `mp[1]` (bit one) instead of `mp[0]`. Because `mp`
shifts right each cycle, bit one of `mp` lags one step behind the bit
that should be deciding the add. The first step was always governed by
the second bit of `b`; the last step tested nothing at all — the whole
product was off by one bit-position.

Changing `mp[1]` back to `mp[0]` lines the guard up with the shift, and
all five products check out.
