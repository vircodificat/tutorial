# Solution

The bug: the bus was never plugged in.

`Top` built a master and a memory, each with its own `Wishbone`
socket -- and left the two sockets dangling. A socket is only a
bundle of signals until it is connected, so every channel had
nowhere to go and `vir check` said so, channel by channel:
"No drivers for master.wishbone.ack", "No drivers for
slave.wishbone.strobe", and friends.

The fix is one line in `Top`:

    master.wishbone :=: slave.wishbone

`:=:` is bulk connect: it joins every channel of one socket to the
matching channel of the other, mapping each direction correctly on
the way -- the client's `strobe` reaches the server, and the
server's `ack` and `rdata` find their way back. No per-signal
wiring, and nothing to forget if the socket grows a channel later.

With the two halves of the conversation joined, the master's
program runs straight through -- two writes, two reads, `done` --
and `make test` is green.
