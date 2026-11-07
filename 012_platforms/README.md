# A Design Meets Its Board

A real design never floats alone: it lives on a board, and a board
only has the pins it has.

Virdant describes a board as a *platform* -- plain data naming the
board's ports -- and a top-level module binds to one, promising to
match it port for port. `Top` in `src/top.vir` is bound to the
tutorial's virtual board, but something in its port list does not
agree with the board, and the compiler refuses to let the design
through. (`src/greeter.vir` holds the little UART sender the design
speaks through; it needs no repairs.)

This lesson grades itself a little differently: `make test` here
does not run a poke script. It runs `vir run`, which simulates the
design on the virtual board itself -- the design prints a short
greeting and then asks the board to exit, and the test passes only
when both of those happen.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to watch the board say hello.

## Stuck?

`vir check` will name the platform and the port it objects to. A
module bound to a board may only declare ports the board actually
declares -- and ports the board has but this design never listens
to still have to be declared.
