# Solution

The bug: the digit 9's arm of the lookup table was missing its bottom
bar.

`SevenSegment` (now in its own file, `src/seven_segment.vir`) decodes a
hex nibble into seven segment bits, and the 9's pattern read
`0b1100111` instead of `0b1101111` — segment `d`, the bottom bar, was
dark. The printed gallery made it plain: the 9 stood on thin air. The
fix is one bit in one arm:

`with 0x9 => 0b1101111`

The rest of the lesson grew a new frame around the same old decoder.
`Top` (in `src/top.vir`) now binds to the virtual board with `for
virt::Virt` and walks a little cursor — digit, line, column — printing
each digit's label and segment picture through `UartSender` (in
`src/uart_sender.vir`), then asks the board to exit. Two details keep
the board's UART watcher happy, both noted in the code: bytes leave
back-to-back with no idle gap between a stop bit and the next start
bit, and the gallery's very first character is a space, whose short
high pulse gives the board a crisp first measurement of the bit
period.

`make test` now grades by running the design on the virtual board
(`vir run`) and diffing the printed gallery against `expected.txt` —
sixteen drawings, all present, all correct.
