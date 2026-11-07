# One Good Pulse

A button press should be an event, not a mood.

`EdgeDetector` in `src/top.vir` watches a button and raises `pulse`
for exactly one clock cycle each time the button goes down — one
press, one pulse, however long the button stays held. A small
register tallies the presses downstream, so a pulse that overstays
its welcome shows up in the arithmetic right away.

And right now it does overstay. The design compiles, `vir check`
strolls through it without complaint, and yet press the button and
the pulse simply refuses to go home.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the pulse knows when to leave.

## Stuck?

To know that something *just* happened, something has to remember
how things stood a moment ago. A wire only ever sees right now.
Count the cast in `src/top.vir`: one register is declared, dutifully
updated every cycle, and never once read.
