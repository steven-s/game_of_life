# Conway's Game of Life (with Ruby!)

A simple implementation that was started late one night when I felt like getting more familiar with Ruby again.

* * *

# What is Conway's Game of Life? 

[Wikipedia](http://en.wikipedia.org/wiki/Conway's_Game_of_Life) can probably do a better job explaining this than I can, but it's a 'simple' cellular automation game.

In this version, cells live on an infinite grid and live or die over time (represented by world ticks) according to the following rules:

1. Any live cell with fewer than two live neighbours dies, as if caused by under-population
2. Any live cell with two or three live neighbours lives on to the next generation
3. Any live cell with more than three live neighbours dies, as if by overcrowding
4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction
