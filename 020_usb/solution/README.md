# Solution

The bug: the stuffing rule fired one bit too early.

The two rules of USB's line encoding are small and exact. NRZI says a
0 toggles the line and a 1 holds it. Bit stuffing says that after six
consecutive 1s, the transmitter must slip a stuffed 0 into the stream —
a guaranteed edge, so the receiver's clock never goes hungry. In this
design the run of 1s is counted in `ones_run`, and the moment to
schedule a stuffed 0 is when the bit on deck would be the *sixth*
consecutive 1 — that is, when `ones_run` already reads 5.

The broken code compared `ones_run` against 4 instead. Five 1s were
enough to trigger the stuffing, so the stuffed edge landed one bit
period ahead of schedule. The waveform told the story clearly: while
sending 0xFE, the line held still through five bit periods and then
toggled early, and the byte ended after only five held 1s instead of
six. The very first `make test` assert to fail was the one standing
right at the stuffed-bit moment, the one whose comment says so.

The fix is one comparison:

`it := data_bit && ones_run == 5`

With 5 in place, six consecutive 1s go out before the stuffed 0
appears, 0x00 toggles happily with no stuffing at all, and the mid-byte
stuffing inside 0xFF lands exactly where a real USB receiver would be
grateful for it. `make test` is green again, all the way down.
