# Solution

The pipeline turned its producer away whenever the stage register
was full — even on the very cycle the banked word was leaving. The
`@Valid` arm of `inp_ready` answered `false`, no matter what the
consumer was doing, so on any cycle where the bank was occupied,
incoming words were refused outright.

That shows up first as a stalled handshake (the pipeline is ready
when it shouldn't refuse to be), and then as lost throughput: feed
words back to back and the pipe produces one word, goes empty, and
produces the next — a bubble every other cycle, because the drain
and the refill were never allowed to share an edge.

The fix: a full bank is only a closed door when nothing is leaving.
`inp_ready` now also says yes when the consumer is taking the banked
word this cycle, so a word drains and a new one banks in the same
edge, and a stall lifts without costing a single extra cycle.
