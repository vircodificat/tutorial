# Solution

The bug: `synced` was wired to `sync_a` — the first flop.

The whole point of a two-flop synchronizer is that the first flop is the
quarantine zone. It samples the raw, potentially unstable async input, and
if the input was changing right at the clock edge, `sync_a` may be in a
metastable state for a brief moment. The design cannot trust it yet.

The second flop, `sync_b`, samples `sync_a` one full cycle later. By then,
metastability has had time to resolve — it fades exponentially, and one
clock period is almost always enough. `sync_b` is what the rest of the
design reads.

The fix is one line: change `it := sync_a` to `it := sync_b`.

With the fix in place, every change in `async_in` appears on `synced`
exactly two clock cycles later. The test traces the pipeline in both
directions and runs a fast one-cycle pulse through it, confirming the
second flop is in the path and the first flop's shaky sample never
escapes.
