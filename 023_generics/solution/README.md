# Solution

The bug: the wide counter's instantiation handed the template a bare
number where a word type was required.

`Counter` is a template with one generic parameter, `W`, of kind
`Type` — it stands for a whole type, and the whole point of the lesson
is that each instantiation fills it in with the word type it wants:
`Word[4]` for the narrow bed, `Word[12]` for the wide one. The
instantiation site is exactly where the widths diverge, so it is also
the one place where you must say which width you mean.

The broken code wrote the wide instance's argument as a plain number
instead of a word type. `vir check` said so directly, at that line:
the parameter `W` expects a type, but found a Nat literal. The narrow
instance was fine all along — it had its word type in its brackets —
which is why only the wide counter's ports went unresolved.

The fix is one pair of brackets. With `Word[12]` in place, both
instances elaborate, and `vir build` shows the harvest: two mono
modules, one per argument list, each with the readable origin in a
comment above it. Same template, two widths, one source file. `make
test` walks both counters over their own wraps — 15 to 0 and 4095 to
0 — and everything is green again.
