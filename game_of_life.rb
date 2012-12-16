class World
  def initialize
    @cells = []
  end
  
  def population
    @cells.uniq { |cell| cell.hash }.size
  end

  def spawn_cell(x, y)
    @cells << Cell.new(x, y)
  end
  
  def cell_alive?(x, y)
    @cells.each do |cell|
      return true if cell.x == x and cell.y == y
    end
    
    false
  end
  
  def tick
    new_world = []
    
    @cells.each do |cell|
      neighbors = neighbor_count(cell)
      new_world << cell if neighbors > 1 and neighbors < 4
      
      find_dead_neighbors(cell).each do |dead_neighbor|
        new_world << dead_neighbor if neighbor_count(dead_neighbor) == 3
      end
    end
    
    @cells = new_world.uniq { |cell| cell.hash }
  end
  
  private
  
  def neighbor_count(cell)
    neighbor_count = 0
    neighbor_count += 1 if cell_alive?(cell.x + 1, cell.y) # right
    neighbor_count += 1 if cell_alive?(cell.x - 1, cell.y) # left
    neighbor_count += 1 if cell_alive?(cell.x, cell.y + 1) # top
    neighbor_count += 1 if cell_alive?(cell.x, cell.y - 1) # bottom
    neighbor_count += 1 if cell_alive?(cell.x + 1, cell.y + 1) # top right
    neighbor_count += 1 if cell_alive?(cell.x + 1, cell.y - 1) # bottom right
    neighbor_count += 1 if cell_alive?(cell.x - 1, cell.y + 1) # top left
    neighbor_count += 1 if cell_alive?(cell.x - 1, cell.y - 1) # bottom left
    neighbor_count
  end
  
  def find_dead_neighbors(cell)
    dead_neighbors = []
    dead_neighbors << Cell.new(cell.x + 1, cell.y) unless cell_alive?(cell.x + 1, cell.y) # right
    dead_neighbors << Cell.new(cell.x - 1, cell.y) unless cell_alive?(cell.x - 1, cell.y) # left
    dead_neighbors << Cell.new(cell.x, cell.y + 1) unless cell_alive?(cell.x, cell.y + 1) # top
    dead_neighbors << Cell.new(cell.x, cell.y - 1) unless cell_alive?(cell.x, cell.y - 1) # bottom
    dead_neighbors << Cell.new(cell.x + 1, cell.y + 1) unless cell_alive?(cell.x + 1, cell.y + 1) # top right
    dead_neighbors << Cell.new(cell.x + 1, cell.y - 1) unless cell_alive?(cell.x + 1, cell.y - 1) # bottom right
    dead_neighbors << Cell.new(cell.x - 1, cell.y + 1) unless cell_alive?(cell.x - 1, cell.y + 1) # top left
    dead_neighbors << Cell.new(cell.x - 1, cell.y - 1) unless cell_alive?(cell.x - 1, cell.y - 1) # bottom left
    dead_neighbors
  end
end

class Cell
  attr_accessor :x, :y
  
  def initialize(x, y)
    @x, @y = x, y
  end
  
  def hash
    (17 + @x.hash) * 31 + @y.hash 
  end
end