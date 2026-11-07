# Shades of Gray from a Single Pin

A digital pin knows exactly two levels, yet LED dimmers fade as
smoothly as a long afternoon. The trick is PWM: switch the pin fast,
and let the *fraction* of each period spent high — the duty cycle —
set the brightness.

`Pwm` in `src/top.vir` is meant to do exactly that: a counter sweeps
across the period, a compare holds the pin high below the knob, and
the test walks the knob from midnight to high noon. But the lamp
won't dim right. The design compiles cleanly, and yet every shade
comes out wrong — something about the sweep is not what it claims.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the pin spends its time where it should.

## Stuck?

The first failing assert names the moment the pin misbehaves. Open
`trace.vcd` and follow the sweep across a whole period: a duty
cycle is only ever a fraction *of something*, so ask what the
compare is actually dividing by.
