# Solution

The bug: the disagreement counter never came back down.

`Debouncer` (in `src/top.vir`) reports the level a raw, bouncy
button has truly settled on. The design's whole bargain is that a
change is believed only after the raw input has disagreed with the
output for sixteen cycles *in a row* — and the counter at the heart
of that bargain only ever counted up. On every cycle where the raw
input agreed with the debounced output, the count was supposed to be
paid back to zero; that driver was simply missing, so
`disagree_count` could only ever climb.

A clean press and release still worked — a held input fills the
counter just the same. But when the switch chattered, the bursts
banked up: two cycles here, three there, each burst adding to what
the last one left behind. Sixteen accumulated cycles of disagreement
arrived without sixteen cycles of stillness, and the debouncer
believed a rumor mid-storm. The first `make test` assert to fail
names it outright: after the first burst and its two quiet cycles,
`top.disagree_count` still read 2, where stillness owes 0.

The fix is one driver, the quiet arm of the counter:

`disagree_count <= 0`

With stillness paying the count back down, a bounce storm sawtooths
in the waveform — up during each burst, back to zero in the gaps —
and no burst is ever long enough to fill the counter. The press
after the storm gets its full sixteen unbroken cycles, and `make
test` is green all the way through.
