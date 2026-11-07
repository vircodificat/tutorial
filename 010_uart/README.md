# Speaking in Serial

A UART transmitter has one friendly job: take a byte and walk it
onto a single wire, one bit at a time.

`UartSender` in `src/top.vir` builds the whole frame in one shift
register — a low start bit, the eight data bits with the least
significant one first, a high stop bit — and holds each bit on `tx`
for four clock cycles. That pace is a fast fake baud, chosen so the
waveform stays readable; a real UART counts out 115200 against a
real clock, and the arithmetic is identical. The line rests high
between frames, and a send while a frame is still going is quietly
ignored.

The transmitter compiles clean, but the test does not pass yet —
find out why.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the byte actually makes it onto the
   wire.

## Stuck?

Bits leave the shifter through bit 0, one per bit period. `word()`
lists its arguments most-significant first — so look closely at
which data bit the load parks next to the exit.
