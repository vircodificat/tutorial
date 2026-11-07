# Solution

The bug: the moisture register stored the quiet cycles.

A `Valid` channel says one of two things each cycle: here is a
value, or there is nothing this time. The moisture register's
`match` handled the first case perfectly — when the channel
carried a `@Moisture`, the percent was latched onto the shelf. But
its `else` arm drove the register with `@Invalid()` on every other
cycle, so a temperature reading, or a quiet cycle, wiped the shelf
back to "empty". The monitor could never remember a moisture
reading for more than a moment, and the first failing assert in
`test.poke` was exactly that: a quiet cycle where the shelf was
expected to keep holding 63 percent.

The fix is to remove that one driver line. When no arm of a
statement-level `match` fires, the register is undriven for the
cycle — and an undriven register simply holds its value. That is
the whole trick behind "maybe there's data" hardware: `@Invalid()`
is not a value to be stored, it is the absence of one, so the
right response to an empty-handed cycle is to do nothing at all.

With the driver gone, the moisture shelf holds through quiet
cycles and temperature cycles alike, zero percent latches as the
genuine bone-dry news it is, and `make test` runs green from the
first power-on assert to the last quiet evening.
