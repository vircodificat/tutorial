# Solution

The bug: cell (1,1) counted itself as its own neighbor.

Conway's Game of Life asks every cell about the eight cells *around*
it — never about itself. The center cell's `count` summed nine bits:
its eight true neighbors, plus the cell's own bit slipped in among
them. The waveform told the story plainly: a horizontal blinker's
center cell holds one live neighbor, so it should die each generation —
but counting itself made the tally two, and a live cell with two
neighbors survives. The blinker froze at its heart instead of folding.

The fix removes the extra term from `next_1_1`'s count, leaving
exactly the eight neighbors the comment names:

    let count : Word[4] = word(0w3, cells[0]) + word(0w3, cells[1])
        + word(0w3, cells[2]) + word(0w3, cells[4]) + word(0w3, cells[6])
        + word(0w3, cells[8]) + word(0w3, cells[9]) + word(0w3, cells[10])

With the extra listener gone, the blinker folds in half and back, the
block holds its corner forever, and every season in the test ends the
way Conway intended.
