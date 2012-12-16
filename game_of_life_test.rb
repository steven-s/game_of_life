require 'rspec'
require_relative 'game_of_life'

describe 'game of life' do
  it 'follows rule 1.1: any live cell with no live neighbours dies, as if caused by under-population' do
    game_world = World.new
    
    game_world.spawn_cell(0, 0)
    
    game_world.cell_alive?(0, 0).should be_true
    
    game_world.tick
    
    game_world.cell_alive?(0, 0).should be_false
  end
  
  it 'follows rule 1.2: any live cell with a single live neighbours dies, as if caused by under-population' do
    game_world = World.new
    
    game_world.spawn_cell(0, 0)
    game_world.spawn_cell(0, 1)
    
    game_world.cell_alive?(0, 0).should be_true
    game_world.cell_alive?(0, 1).should be_true
    
    game_world.tick
    
    game_world.cell_alive?(0, 0).should be_false
  end
  
  it 'follows rule 2.1: any live cell with two live neighbours lives on to the next generation' do
    game_world = World.new
    
    game_world.spawn_cell(0, 0)
    game_world.spawn_cell(0, 1)
    game_world.spawn_cell(1, 0)
    
    game_world.cell_alive?(0, 0).should be_true
    game_world.cell_alive?(0, 1).should be_true
    game_world.cell_alive?(1, 0).should be_true
    
    game_world.tick
    
    game_world.cell_alive?(0, 0).should be_true
  end
  
  it 'follows rule 2.2: any live cell with three live neighbours lives on to the next generation' do
    game_world = World.new
    
    game_world.spawn_cell(0, 0)
    game_world.spawn_cell(0, 1)
    game_world.spawn_cell(1, 0)
    game_world.spawn_cell(1, 1)
    
    game_world.cell_alive?(0, 0).should be_true
    game_world.cell_alive?(0, 1).should be_true
    game_world.cell_alive?(1, 0).should be_true
    game_world.cell_alive?(1, 1).should be_true
    
    game_world.tick
    
    game_world.cell_alive?(0, 0).should be_true
  end
  
  it 'follows rule 3: any live cell with more than three live neighbours dies, as if by overcrowding' do
    game_world = World.new

    game_world.spawn_cell(0, 0)
    game_world.spawn_cell(0, 1)
    game_world.spawn_cell(0, -1)
    game_world.spawn_cell(1, 0)
    game_world.spawn_cell(1, 1)

    game_world.cell_alive?(0, 0).should be_true
    game_world.cell_alive?(0, 1).should be_true
    game_world.spawn_cell(0, -1).should be_true
    game_world.cell_alive?(1, 0).should be_true
    game_world.cell_alive?(1, 1).should be_true

    game_world.tick

    game_world.cell_alive?(0, 0).should be_false
  end
  
  it 'follows rule 4: any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction' do
    game_world = World.new
    
    game_world.spawn_cell(0, 1)
    game_world.spawn_cell(1, 0)
    game_world.spawn_cell(1, 1)
    
    game_world.cell_alive?(0, 0).should be_false
    game_world.cell_alive?(0, 1).should be_true
    game_world.cell_alive?(1, 0).should be_true
    game_world.cell_alive?(1, 1).should be_true
    
    game_world.tick
    
    game_world.cell_alive?(0, 0).should be_true
  end
  
  it 'follows block pattern' do
    game_world = World.new
    
    game_world.spawn_cell(0, 0)
    game_world.spawn_cell(0, 1)
    game_world.spawn_cell(1, 0)
    game_world.spawn_cell(1, 1)
    
    game_world.cell_alive?(0, 0).should be_true
    game_world.cell_alive?(0, 1).should be_true
    game_world.cell_alive?(1, 0).should be_true
    game_world.cell_alive?(1, 1).should be_true
    
    5.times do
      game_world.tick
    
      game_world.cell_alive?(0, 0).should be_true
      game_world.cell_alive?(0, 1).should be_true
      game_world.cell_alive?(1, 0).should be_true
      game_world.cell_alive?(1, 1).should be_true
    end
  end
  
  it 'follows oscillator pattern' do
    game_world = World.new
    
    game_world.spawn_cell(0, 0)
    game_world.spawn_cell(0, 1)
    game_world.spawn_cell(0, -1)
    
    game_world.cell_alive?(0, 0).should be_true
    game_world.cell_alive?(0, 1).should be_true
    game_world.cell_alive?(0, -1).should be_true
    game_world.cell_alive?(1, 0).should be_false
    game_world.cell_alive?(-1, 0).should be_false
    
    game_world.tick
  
    game_world.cell_alive?(0, 0).should be_true
    game_world.cell_alive?(0, 1).should be_false
    game_world.cell_alive?(0, -1).should be_false
    game_world.cell_alive?(1, 0).should be_true
    game_world.cell_alive?(-1, 0).should be_true
  
    game_world.tick
  
    game_world.cell_alive?(0, 0).should be_true
    game_world.cell_alive?(0, 1).should be_true
    game_world.cell_alive?(0, -1).should be_true
    game_world.cell_alive?(1, 0).should be_false
    game_world.cell_alive?(-1, 0).should be_false
  end
end