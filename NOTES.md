# Notes
More lesson ideas:

1. structs — bundle an RGB pixel (or a coordinate) into a struct and pass it around whole: data that travels together lives together.
2. unions & Valid — a "maybe there's data" channel: Valid[T] and unions teach how hardware says null without a null pointer in sight.
3. generics — one mod declared [T : Nat]-style, instantiated as a Word[4] counter and a Word[12] counter: write it once, synthesize it
   twice.
4. tristate bus — many drivers, one wire: bus/net, #=/#- drivers and tap, and why open-drain needs a pull-up to be polite.
5. edge detector — a one-cycle pulse every time a button goes down: comparing a reg to its own past, the 2-line idiom half of digital design is made of.
6. debouncer — the button bounces, your logic shouldn't: a small counter that refuses to believe an input until it's held still (paired naturally with the edge detector).
7. PWM — dim an LED by duty cycle: a counter and a compare, and the lesson that digital outputs can paint in shades of gray.
8. spi_master — the shift register in anger: clocking bytes out on spi_mosi while sampling spi_miso, a cousin of the UART lesson with a clock line to keep everyone honest.
9. rom_lookup — a case/match as a tiny ROM: constant data without registers, and why synthesizers love a table more than a computation.
10. double_dabble — binary to BCD (for feeding those seven-segment digits with real numbers): a shift-add-3 loop that shows an algorithm unrolling into cycles.
11. pipeline — a two-stage pipeline with a register between produce and consume: valid/ready handshakes, a stall, and the first taste of what the RISC-V core will demand.
12. ext_modules — ext mod with @parameter: bringing in someone else's Verilog and wiring it like a native — because real boards have black boxes.
13. gray_code — counters that change one bit at a time: binary↔Gray conversion, and why Gray sequences keep clock-domain crossings honest.
14. uart_receiver — the other half of the UART story: waiting for the start edge, sampling at mid-bit, and the devious simplicity of a 16x oversample.
15. priority_encoder — many requesters, one grant: fixed-priority and round-robin arbiters, and why starvation is a hardware sin.
16. crc — a serial CRC with the polynomial-as-XOR-tree picture: LFSR's stricter sibling, and how checksums catch bursts.
17. moving_average — running sums and sliding windows: streaming filters and the first taste of DSP-shaped thinking.
18. dividing_engine — restoring division, one bit per cycle: the first algorithm that feels slow, and why hardware folk flinch at `/` in synthesizable code.
19. i2c_master — open-drain serial with start/stop conditions: the protocol where the line can only pull down, building on what tristate taught.
20. jtag — the four-wire debug port: TAP controller state machine, shifting instructions and data through scan chains, and why every chip has this backdoor.
21. shift_register — the universal idiom all to itself: SIPO/PISO, variable-length shifts, and how one reg with a moving window becomes UARTs, SPIs, and serializers.
22. spi_flash — talking to a real memory chip: command/address/data SPI transactions, read-status polling, and the first peripheral that has opinions about timing.
23. ir_remote_nec — decode a TV remote: pulse-distance timing, 32-bit frames, and the longest button-press measurement you'll ever build.
24. popcount_clz — counting ones and finding the first one: XOR/OR reduction trees and priority chains — the operations every mask-based allocator leans on.
25. crossbar_switch (wishbone) — N masters, M slaves, any-to-any: a Wishbone crossbar interconnect, the arbiter's bigger sibling and the beating heart of every SoC.
26. cache_direct_mapped — the smallest cache that deserves the name: tag, index, valid bit, hit/miss — the capstone's memory hierarchy arrives early, tiny enough to see all of it.
27. bf_interpreter — a Brainf*ck machine in hardware: a tape of registers, one instruction decoder FSM, and every loop unrolled into clock cycles — proof you can build a computer out of anything.
