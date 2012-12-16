require 'rspec'
require_relative 'game_of_life'

describe 'game of life' do
  
  context 'game world' do
    it 'starts empty' do
      game_world = World.new
      game_world.population.should eq(0)
    end
    
    it 'should spawn cells' do
      game_world = World.new
      game_world.spawn_cell(0, 0)
      
      game_world.population.should eq(1)
      game_world.cell_alive?(0, 0).should be_true
    end
    
    it 'should have unique cells' do
      game_world = World.new
      game_world.spawn_cell(0, 0)
      game_world.spawn_cell(0, 0)
      
      game_world.population.should eq(1)
    end
  end
  
  context 'cells' do  
    it 'should define location' do
      origin = Cell.new(0, 0)
      first_quadrant = Cell.new(5, 10)
      second_quadrant = Cell.new(-7, 2)
      third_quadrant = Cell.new(-3, -11)
      fourth_quadrant = Cell.new(3, -5)
      
      origin.x.should eq(0)
      origin.y.should eq(0)
      
      first_quadrant.x.should eq(5)
      first_quadrant.y.should eq(10)
      
      second_quadrant.x.should eq(-7)
      second_quadrant.y.should eq(2)
      
      third_quadrant.x.should eq(-3)
      third_quadrant.y.should eq(-11)
      
      fourth_quadrant.x.should eq(3)
      fourth_quadrant.y.should eq(-5)
    end
    
    it 'should define hash' do
      cell = Cell.new(2, 3)
      equal_cell = Cell.new(2, 3)
      different_cell_one = Cell.new(6, 3)
      different_cell_two = Cell.new(2, 5)
      different_cell_three = Cell.new(3, 2)
      
      cell.hash.should eq(equal_cell.hash)
      cell.hash.should_not eq(different_cell_one.hash)
      cell.hash.should_not eq(different_cell_two.hash)
      cell.hash.should_not eq(different_cell_three.hash)
    end
  end
  
  let(:game_world) do World.new end
  
  it 'follows rule 1.1: any live cell with no live neighbours dies, as if caused by under-population' do
    game_world.spawn_cell(0, 0)
    
    game_world.cell_alive?(0, 0).should be_true
    
    game_world.tick
    
    game_world.cell_alive?(0, 0).should be_false
  end
  
  it 'follows rule 1.2: any live cell with a single live neighbours dies, as if caused by under-population' do
    game_world.spawn_cell(0, 0)
    game_world.spawn_cell(0, 1)
    
    game_world.cell_alive?(0, 0).should be_true
    game_world.cell_alive?(0, 1).should be_true
    
    game_world.tick
    
    game_world.cell_alive?(0, 0).should be_false
  end
  
  it 'follows rule 2.1: any live cell with two live neighbours lives on to the next generation' do
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
    game_world.spawn_cell(0, 0)
    game_world.spawn_cell(0, 1)
    game_world.spawn_cell(1, 0)
    game_world.spawn_cell(1, 1)
    
    game_world.cell_alive?(0, 0).should be_true
    game_world.cell_alive?(0, 1).should be_true
    game_world.cell_alive?(1, 0).should be_true
    game_world.cell_alive?(1, 1).should be_true
    
    game_world.population.should eq(4)
    
    5.times do
      game_world.tick
    
      game_world.cell_alive?(0, 0).should be_true
      game_world.cell_alive?(0, 1).should be_true
      game_world.cell_alive?(1, 0).should be_true
      game_world.cell_alive?(1, 1).should be_true
      
      game_world.population.should eq(4)
    end
  end
  
  it 'follows oscillator pattern' do
    game_world.spawn_cell(0, 0)
    game_world.spawn_cell(0, 1)
    game_world.spawn_cell(0, -1)
    
    game_world.cell_alive?(0, 0).should be_true
    game_world.cell_alive?(0, 1).should be_true
    game_world.cell_alive?(0, -1).should be_true
    game_world.cell_alive?(1, 0).should be_false
    game_world.cell_alive?(-1, 0).should be_false
    
    game_world.population.should eq(3)
    
    game_world.tick
  
    game_world.cell_alive?(0, 0).should be_true
    game_world.cell_alive?(0, 1).should be_false
    game_world.cell_alive?(0, -1).should be_false
    game_world.cell_alive?(1, 0).should be_true
    game_world.cell_alive?(-1, 0).should be_true
    
    game_world.population.should eq(3)
  
    game_world.tick
  
    game_world.cell_alive?(0, 0).should be_true
    game_world.cell_alive?(0, 1).should be_true
    game_world.cell_alive?(0, -1).should be_true
    game_world.cell_alive?(1, 0).should be_false
    game_world.cell_alive?(-1, 0).should be_false
    
    game_world.population.should eq(3)
  end
end