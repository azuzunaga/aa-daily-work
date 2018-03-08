class Board
  BOMB_PERCENTAGE = 0.15625

  attr_reader :grid, :size

  alias :rows :grid

  def initialize
    @size = 9
    @grid = Array.new(size) { Array.new(size) }
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def place_random_bombs
    board_size = size**2
    num_of_bombs = (board_size * BOMB_PERCENTAGE).floor

    num_of_bombs.times do |i|
      row = (0...size).to_a.sample
      col = (0...size).to_a.sample
      pos = [row, col]

      while self[pos]
        row = (0...size).to_a.sample
        col = (0...size).to_a.sample
        pos = [row, col]
      end

      self[pos] = :b
    end
  end

  def render
    puts "  #{(0...size).to_a.join(' ')}"
    rows.each_with_index do |row, idx|
      puts "#{idx} #{row.join(' ')}"
    end
  end
end
