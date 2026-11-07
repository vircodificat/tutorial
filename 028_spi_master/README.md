# Eight Pulses, Both Directions

SPI is the quiet workhorse of the chip garden: three wires, one
small word counter, and a clock line to keep everyone honest.
`SpiMaster` in `src/top.vir` is the gardener here — it pulses `sck`
itself, walks a byte out of `mosi` most-significant bit first, and
gathers the device's answer on `miso` at the same moment, all under
the timing rules of SPI mode 0.

Except the flower bed is uneven. The design compiles cleanly, but
when `test.poke` plays the device on the other end — answering
`0xA5` with `0x3C`, then trading all-zero and all-one bytes — the
waveform disagrees with somebody about *which* sck edge does what.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether both halves of the wire tell the
   same story.

## Stuck?

`test.poke` pokes a fresh `miso` bit before every rising edge and
checks `mosi` before and after it. Find the first assert that
objects, look at which half-period it complains about, and ask
yourself which edge the transmit register shifted on — and which
edge mode 0 says it should have.
