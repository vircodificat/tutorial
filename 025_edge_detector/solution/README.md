# Solution

The bug: `press_now` never asked about the past.

It was driven straight from `button`, so `pulse` was not an edge at
all — it was a level. While the button was held down, `pulse` stayed
high for the entire hold, and `presses` climbed merrily the whole
time: one press counted as dozens. The first failing assert is the
one right after the press's clock edge, the cycle where the pulse
was supposed to be gone and wasn't.

An edge detector needs a memory. `prev_button` is the "previous
value" register: every clock edge it latches whatever `button` reads
at that moment and holds it until the next one. So at any instant,
`prev_button` is the button as it was one beat ago, while `button`
is the button as it is right now. Comparing the two is what
separates *down* from *just went down*.

The fix is the whole idiom in one line:

`it := !prev_button && button`

The button is down now, and it was up one cycle ago: a press. With
that comparison in place, the pulse rises with the button and is
gone one clock edge later, releases stay quiet, and the burst of
quick taps lands exactly five pulses in the ledger. `vir check` goes
fully quiet — the unused-signal warning about `prev_button` evaporates
the moment it finally gets a reader — and `make test` is green all
the way down.
