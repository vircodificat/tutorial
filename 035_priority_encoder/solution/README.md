# What was wrong

The pointer was parking on the winner instead of stepping past
them. The broken arm read:

    it <= w

so after granting requester 1, the pointer landed on 1 — the very
requester who just got served. The next cycle's `eligible` mask
still included requester 1, the priority chain still picked them
first, and the round robin collapsed into the very starvation it
exists to prevent: requester 1 was granted over and over while 3
waited. One character was missing:

    it <= w + 1

With that fixed, the pointer lands just past the winner, the
eligible mask moves forward with it, and every turn comes around —
including requester 3's, and the wrap back to 0 when the pointer
runs off the end of the line.
