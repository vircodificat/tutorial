# Solution

The bug: the shifter loaded the byte most-significant first.

Everything else about the frame was right. The start bit sat at the
exit, the stop bit guarded the far end, the phase counter handed the
wire a fresh bit every four cycles, and the line rested high between
frames. But the load spelled the data byte out bit by bit, starting
with `data[0]` — and `word()` lays its arguments out
most-significant first. So `data[0]` was parked up beside the stop
bit while `data[7]` stood right next to the start bit, first out the
door. Every byte left backwards: the waveform made it loud, with
0x0F walking out as 0,0,0,0,1,1,1,1 instead of 1,1,1,1,0,0,0,0.

The fix is to let Virdant do the laying out. Since bits leave the
shifter through bit 0 and `word()` lists bits most-significant
first, the plain byte slots in with its least significant bit
already beside the start bit:

`it <= word(1w1, data, 0w1)`

One line, and the frame reads start, `data[0]` … `data[7]`, stop —
exactly the order the wire asks for. The busy-ignore behavior and
both test bytes now check out, and `make test` is green.
