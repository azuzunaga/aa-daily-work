require_relative 'tile'
class Board
  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def self.from_file(file)
    array = File.readlines(file)
    board = array.map(&:chomp)
    board = board.map(&:chars)
    board = Board.populate_tiles(board)
    Board.new(board)
  end

  def self.populate_tiles(board)
    board.each_index do |row|
      board[row].each_index do |col|
        if board[row][col] == "0"
          board[row][col] = Tile.new(" ", false)
        else
          board[row][col] = Tile.new(board[row][col], true)
        end
      end
    end
    board
  end

  def all_rows?
    values = []
    @grid.each do |row|
      values = row.map(&:value)
    end
    values.uniq == values
  end

  def column
    values = []
    transposed = @grid.transpose
    tranposed.each do |col|
      values = col.map(&:value)
    end
    values.uniq == values
  end

  def three_by_three

  end

  def slicer
    sliced_arrays = []
    start = 0
    finish = start + 3

    while finish < 9
      @grid.each_index do |row|
        puts "start: #{start} | finish: #{finish}"
        sliced_arrays << @grid[row][start, finish].map(&:value)
      end
      start += 3
      finish += 3
    end
    sliced_arrays
  end

  def build_little_squares
    squares = []
    sliced_arrays = slicer

    sliced_arrays.each_slice(3) do |three_threes|
      squares << three_threes
    end

    squares
  end

  def solved?

  end

  def render
    counter = 0
    @grid.each do |row|
      print " #{counter} | "
      row.each do |tile|
        if tile.given
          print "\e[0;33m#{tile.value}\e[0m | "
        else
          print "#{tile.value} | "
        end
      end
      puts "\n    ___ ___ ___ ___ ___ ___ ___ ___ ___"
      counter += 1
    end
  end


end

if __FILE__ == $PROGRAM_NAME
  board = Board.from_file("puzzle1.txt")
  p board.build_little_squares
end
