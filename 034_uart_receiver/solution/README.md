# What was wrong

The data-bit samples walked the line's value into the wrong end of
the shift register. The byte arrives least significant first, so
each sample must enter at the *top* and slide down — after eight
samples the first bit received has walked all the way to bit 0,
right where the byte's least significant bit belongs.

The broken version had the `word()` arguments swapped, which shifts
*left* instead: each sample entered at bit 0 and everything slid
up. The result was every byte delivered as its mirror image —
`0x53` came back as `0xCA` — while glitches and missing stop bits
were still handled correctly. One line, and the receiver hears the
wire right-side up.
