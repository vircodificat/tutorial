# The Debouncer

A button press is a fact; the bouncing around it is just weather.

`Debouncer` in `src/top.vir` watches a raw, bouncy button pin and
reports the level the button has truly settled on. Its whole bargain:
a change is believed only after the raw input has held it, still and
steady, for sixteen cycles. The design compiles cleanly, and a clean
press and release behave — but set the contacts chattering, and the
counter starts believing rumors it never paid for.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the debouncer can be talked out of
   turning.

## Stuck?

The test asserts on the counter itself, and `trace.vcd` tells the
story plainly: through the bounce storm, `disagree_count` should
sawtooth — climbing during every burst of chatter, back to zero
during every quiet gap. Follow where it goes on the cycles when the
raw input agrees with the output.
