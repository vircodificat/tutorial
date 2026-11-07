# Solution

The bug: the transmit shift register advanced on the leading edge
instead of the trailing edge.

Mode 0 gives each side of the wire a job per edge. On the leading
edge (sck rising), both ends sample. On the trailing edge (sck
falling), whoever has something to say puts the next bit on the
wire — a full low half-period before anybody listens again. In this
design the transmit register `shift_out` supplies `mosi` straight
off its top bit, so the whole question is: on which edge does it
shift?

The broken code shifted it in the leading-edge block, in the same
breath as the sample. The result: `mosi` changed at the very moment
`sck` rose, so the bit the device was supposed to sample was yanked
away exactly when it was being read — a hold-time violation in the
making. The waveform shows it plainly: during every high
half-period, `mosi` already carried the *next* bit, and the first
failing assert was the one watching `mosi` hold steady across a
leading edge.

The fix is to let the shift ride along with the trailing edge:

    shift_out <= word(shift_out[7..0], 0w1)

moved into the `phase == 1` arm, underneath the `busy <= false`
check so the eighth trailing edge closes the transfer instead of
shifting a ninth bit nobody asked for.

With that, 0xA5 goes out bit by settled bit while 0x3C walks into
`received`, the all-zero and all-one extremes both behave, and a
stray `start` pulse mid-transfer is ignored politely.
`vir check` and `make test` are green all the way down.
