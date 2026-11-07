# The Waiting Room

A pipeline is a garden path with a gate halfway down it: words check
in, rest exactly one clock edge in the stage register, and check out
transformed — one word per cycle, forever, if the handshakes hold.

`Top` in `src/top.vir` is a two-stage pipeline in miniature. Stage
one doubles each incoming byte, a stage register banks the
intermediate result together with its valid bit, and stage two adds
one. Both sides of the path speak valid/ready: the producer offers a
word, the pipeline answers whether the coming edge will take it, the
consumer answers in turn, and nothing is ever lost or duplicated.

That last part is the problem. The design compiles cleanly, but
under pressure the pipe starts turning words away on cycles when it
had room for exactly one more.

The loop, as always:

1. `vir check` while you read and edit.
2. `make test` to see whether every word that checks in also checks
   out.

Someday you will build a small processor out of stages shaped
exactly like this one, and it will accept nothing less than perfect
flow control. Consider this the first drill.

## Stuck?

Watch `inp_ready` on a cycle where the bank is full and the consumer
is ready. A bank that is draining this very edge is not a full bank
— and one edge can empty it and fill it again in the same breath.
