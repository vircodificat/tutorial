# Solution

The bug: the sweep turned around at 128 instead of running the full 256.

A duty cycle is a fraction *of a period*, so the period is half the
definition. The compare `sweep < brightness` carves the first
`brightness` counts out of a 256-count sweep, and it can only be
trusted if the sweep actually runs all 256 before starting over.
The broken code reset the sweep to 0 the moment it reached 127, so
the period quietly became 128 counts. Every fraction doubled:
knob 64 lit half the period instead of a quarter, and any knob
setting from 128 up compared against a sweep that never got past
126 — so the LED sat pinned fully on, no matter where you turned
the knob past the halfway mark.

The waveform made it plain: the sweep fell off a cliff at 128, and
the pin's high stretch rode along with it.

The fix is to let the arithmetic do the wrapping and delete the
early turnaround:

    it <= it + 1

A `Word[8]` that keeps adding wraps itself — 255 + 1 lands back on
0 — so the period is the full 256 counts, every duty cycle is
measured against the whole range, and `make test` walks the knob
from midnight to high noon with every assert agreeing.
