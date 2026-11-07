# Solution

The bug: the faded pixel was rebuilt with only its red channel darkened.

A struct literal constructs a whole new value, one field at a time — and
in `Fader`, the green and blue fields of the rebuilt pixel were built
straight from the arriving pixel instead of from their darkened
counterparts. Reading a field of `pixel` hands over that channel exactly
as it arrived: untouched. So red stepped down one shade per tick while
green and blue held perfectly still, and the canvas drained toward a
thin red line instead of toward black. The design compiled cleanly and
the first fade assert was the first thing to object.

The fix builds every field of the literal from the value it was meant to
become:

    green = darker_green,
    blue  = darker_blue,

With all three fields constructed from their darkened wires, the fade
steps every channel down together, green parks at black instead of
wrapping around to 255, and `make test` stays green from the first tick
to the last.
