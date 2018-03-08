require 'colorize'
require_relative 'board'
require_relative "cursor"

class Display
  attr_reader :cursor, :board
  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end


end
