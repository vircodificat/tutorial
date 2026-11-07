# The Gallery

Every hex digit, drawn in seven-segment ASCII art.

`Top` runs the whole show on the virtual board: for each digit `0x0`
through `0xF` it asks the decoder for the seven-segment pattern and
prints the pattern as a little ASCII picture over the UART, one framed
drawing after another. The decoder is the star of this lesson, and it
lives in `src/seven_segment.vir` — and one digit's picture is missing
a bar. `src/top.vir` and `src/uart_sender.vir` walk the gallery onto
the wire; feel free to skim them, the puzzle is in the lookup table.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` — this one runs the design on the virtual board with
   `vir run` and compares the printed gallery against `expected.txt`,
   so a wrong pattern shows up right in the diff.

## Stuck?

The failing diff names the line. Count the bars in that digit's
picture against the segment map drawn in the comments — one bit in one
arm of the `match` is dark when it should glow.
