# Two Clocks, One Signal

The outside world does not care about your clock.

A button press, a signal from another chip, a pulse from a sensor — these
arrive on their own schedule, unaware of the clock your design runs on.
Sampling an asynchronous input directly can land a register mid-transition,
producing a value that is neither a clean 0 nor a clean 1 for an
indeterminate moment. The two-flop synchronizer is the hardware idiom that
handles this safely: two registers back-to-back, so the murky first sample
has a full clock cycle to settle before anyone downstream ever sees it.

The design is in `src/top.vir`. It compiles and simulates — but `synced`
is coming out exactly one cycle too early, as if the second flop were not
there.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether the two-cycle delay holds.

## Stuck?

The comment on `sync_a` says the first flop's output should never be
trusted directly. Find where `synced` is driven, and ask yourself which
register it should be reading from.
