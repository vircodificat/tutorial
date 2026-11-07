# What was wrong

The left-slide arm had its `word()` arguments backwards:

    it <= word(sin, it[7..0])

That puts `sin` in the most-significant position — a *right* slide
wearing a left slide's name. The fix is to feed the serial bit in
at the bottom, where a left slide's newcomer belongs:

    it <= word(it[7..0], sin)

Every bit steps one place up, bit 7 falls off the top, and the
trickling `sin` lands in bit 0. The right-slide arm was already
correct: there `sin` enters at the top and bit 0 falls off the
bottom.
