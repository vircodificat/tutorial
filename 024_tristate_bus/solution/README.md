# Solution

The bug: nobody was holding the line up.

Open-drain only works because something keeps the wire honest while
everybody is quiet. In this garden that something is the weak
pull-up: a `#-` driver on `line`, always attached, too feeble to win
any argument, but strong enough to lift the line back to one once
every strong hand lets go. The broken design wired both participants
to the line, taught everyone to pull low and let go — and then left
the resistor out entirely.

The waveform shows the signature clearly: every phase where a
participant pulled read a crisp 0, and every phase where both hands
came off read `z` — high impedance, no level at all. The testbench
failed exactly on the idle checks and passed exactly on the pull
checks.

The fix is one line of driver:

    line #- true

With the pull resistor in place, idle stretches read high, strong
lows still win while anyone is speaking, and both ears hear the whole
conversation. `vir check` is clean and `make test` is green, all the
way down.
