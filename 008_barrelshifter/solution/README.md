# Solution

The bug: the middle stage of the ladder grabbed the wrong six bits.

A left shift by 2 keeps the *low* six bits of the incoming word —
those are the ones that climb — and lets the top two fall off the
end. The broken stage instead sliced out the *high* six bits, bits 7
down through 2, and left them exactly where they were, with only the
bottom two bits zeroed. Nothing actually moved, so any shift
amount with bit 1 set came out as a masked copy of the input rather
than a shift. The test caught it the moment `shamt` reached 2: with
`value` at `0xA5`, `shifted` read `0xA4` where `0x94` was expected.

The fix is one slice in the middle stage's driver:

`word(stage1[6..0], 0w2)`

The slice takes bits 5 down to 0 — six bits, since the top index is
exclusive — and `word()` stacks them up two positions with two zeros
underneath. Same width, right window, and the ladder shifts true
again.
