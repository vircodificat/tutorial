# Solution

The bug: `Top` declared a port the board does not have.

A platform is a board written down as data, and binding a module to
one with `for` makes `vir check` hold the module's port list up
against the board's, port by port: same names, same directions, same
types. The broken code declared an extra `outgoing led : Bit`, and
the compiler refused with "Module has port led which platform Virt
does not declare" -- the error even names the platform, so you know
which side of the bargain is complaining.

The fix is to delete the port. A board only has the pins it has; a
module bound to a board must use exactly those. (If the port had
been the other way around -- a board port the module omits -- the
error would read "Module is missing port ... required by platform"
instead, unless the platform gives that port a `default`, which the
virtual board does for its SPI flash pins.)

One note on grading: in this directory `make test` does not run a
poke script. It runs `vir run`, which simulates the design on the
virtual board itself: the design prints its greeting to the terminal
and then raises `exit`, and the run passes only when the greeting
appears and the program exits 0.
