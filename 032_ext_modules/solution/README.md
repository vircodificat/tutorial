# Solution

The bug: the shell tried to tune the black box the way it would tune
a native Virdant module -- with a generic type argument on the
instantiation.

Ext mods are declared from the outside only: `src/rf.vir` lists the
ports and no logic, and the Verilog lives outside Virdant entirely
(`ext/rf.sv`).  Because there is no inside for a type parameter to
reach, an `ext mod` cannot have generics at all -- and the check
said exactly that, pointing at `Rf[Word[32]]` and naming the honest
alternative: ext mods are parameterized with `@parameter`
annotations.

The fix replaces the type argument with an annotation on the
instance:

`@parameter("READ_LATENCY", "ZERO")`

The value is not decorative.  `src/rf.vir` declares the vendor
module's parameters with their defaults, and the vendor's default
read latency is `"ONE"` -- reads handed over one cycle late.  This
shell reads combinationally and asks its question the very cycle
after a write lands, so the instance pins the latency to `"ZERO"`.
One line, and the tour prints every word the register file was
planted with: the write before and after, the same word through
both ports, the dropped write to x0, the top of the file, and the
count of writes the box actually accepted.
