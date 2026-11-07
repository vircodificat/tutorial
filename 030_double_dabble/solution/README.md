# Solution

The bug: the step counter never climbed.

The whole design is a software loop unrolled into hardware. The loop
body — adjust each BCD digit by 3 where it would overflow, then shift
the whole bed left one bit — was wired correctly and ran once per
clock. But a software loop also advances its own index every
iteration, and in hardware nobody does that for free: `step` had its
power-on value and its reset-on-`start` driver, but no driver to climb
while `busy`. So `step` held at zero forever, the loop's termination
test never came true, `busy` never fell, and `done` never rose. The
waveform made it plain: `bcd` kept shifting cycle after cycle while
`step` stayed flat at zero.

The fix is the missing arm in `step`'s driver block: while `busy`,
climb by one. With the counter turning, exactly eight clocks pass
between `start` and `done`, and every assert in `make test` — the
mid-loop heartbeat check and all the digit checks — goes green.
