# The Garden's Quiet Wire

Two sensors share one wire in the greenhouse, and that wire only
sometimes has something to say.

`GreenhouseMonitor` in `src/top.vir` listens to that channel and
keeps the most recent moisture reading and the most recent
temperature reading, each on its own shelf. The wire speaks in a
type that can mean *nothing this cycle* — and that's where the
trouble starts. The design compiles cleanly, but the monitor keeps
forgetting what the garden told it: whenever a cycle comes and goes
without a moisture reading, the moisture shelf mysteriously empties.

Your job is to find why "nothing" is being treated as if it were
something, and to teach the monitor to hold its ground through the
quiet cycles.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether both shelves keep their readings.

## Stuck?

The first failing assert in `test.poke` is a quiet cycle — no new
reading of any kind. Trace what the `match` in the moisture
register does on that cycle, and ask what gets stored when the
channel's answer carries no data at all.
