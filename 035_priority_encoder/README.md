# Who Goes First

Four requesters share one grant line, and somebody has to decide
who goes first. `src/top.vir` parks two arbiters side by side to
watch them disagree: `FixedPriority` always answers with the most
senior requester — requester 0 outranks everyone, forever — while
`RoundRobin` keeps a rotating pointer and makes everyone take
turns, wrapping back around the line when it runs off the end.

Both arbiters compile cleanly, but when `test.poke` puts them
through their paces — two requesters squabbling, a senior one
joining late, a lonely requester below the pointer, a full sweep
of the line — the round robin stops taking turns. Find out why.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether everyone gets their turn.

## Stuck?

Watch `pointer` in the waveform. After each grant it should land
*one past* the winner — ask yourself where it actually lands, and
what a round robin looks like when the pointer never gets past
whoever won first.
