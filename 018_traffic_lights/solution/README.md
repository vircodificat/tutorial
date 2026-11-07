# Traffic Lights: the fix

The controller was sending north-south traffic straight from its yellow
back into its own green. The timer, the lights, the safety checks -- all
of it worked; only one line pointed the wrong way.

The transition table is the heart of the design. It reads the current
phase and names the one phase that may follow it. The broken line sent
the north-south yellow back to where it had just been:

```virdant
with #NsYellow => #NsGreen
```

It had to hand the road to the other direction:

```virdant
with #NsYellow => #EwGreen
```

Everything else in the controller depends on that arrow. The lights,
the timers, the safety invariant -- all of them read the phase that
this one line picks. With the wrong arrow, the north-south road kept
taking its turn twice, and the east-west road never got a green at all.

The test rides two full trips around the intersection, asserting the
six lights and the safety invariant at every phase. On the broken
version it fails the moment the north-south yellow should hand over to
the east-west green -- and the fix is one token.
