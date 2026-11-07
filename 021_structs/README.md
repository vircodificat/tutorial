# Pixels Travel Whole

A pixel's three color channels belong together — and data that
belongs together should travel together, in one basket.

`PixelFader` in `src/top.vir` keeps a single pixel on its canvas and
fades it toward black, one shade per tick. The channels arrive on
three separate wires, should be bundled into one `Pixel` struct at
the boundary, and from there the whole pixel should move — into a
register, through a submodule, and back — rebuilt fresh each time
the fade takes a step. Something in that journey has gone wrong:
the fade no longer darkens the pixel evenly, and `make test`
objects on the very first tick.

The design compiles cleanly, so the trouble is in what a rebuilt
pixel is actually made of.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether all three channels step down together.

## Stuck?

Read the failing assert, then `trace.vcd`: one channel walks down a
shade per tick while another sits perfectly still. Find the struct
literal that builds the faded pixel, and ask — field by field —
what each one is being built *from*.
