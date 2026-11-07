# Two Beds, One Seed

Write a counter once, and harvest it at two widths.

A good seed packet doesn't come printed with a garden size on it —
you plant the same seeds in a window box or a whole bed, and each
patch grows to its own measure. `Counter` in `src/counter.vir` is
that seed packet: a counting template whose width is a generic
parameter, with no concrete width anywhere in its body. `Top` in
`src/top.vir` is the gardener: it plants the template twice, once as
a narrow 4-bit counter and once as a wide 12-bit one, and each
planting becomes its own synthesized module.

Except one of the two plantings never took. The design as it stands
won't even pass `vir check`, and the compiler's complaint points
straight at the spot where each garden gets to say how wide it wants
to grow. Both files are worth reading — the template teaches most of
the idea, but the lesson's trouble is in the instantiation.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` — once the design compiles, the test walks both
   counters over their own wraps and checks that neither bed
   disturbs the other.

## Stuck?

Read the error's first line at the `wide` instantiation: it names
exactly what kind of thing the parameter expects, and what it was
handed instead. Look at how the narrow instance fills its brackets,
and remember that `Word` itself is written with a number in brackets
because its parameter is a different kind than this one.
