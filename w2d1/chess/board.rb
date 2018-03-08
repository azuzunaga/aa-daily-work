require_relative 'piece'
require_relative 'null_piece'
require_relative 'display'

class Board

  WHITE_PIECE_HASH = {
    Piece.new(:rook)   => [7,0],
    Piece.new(:knight) => [7,1],
    Piece.new(:bishop) => [7,2],
    Piece.new(:queen)  => [7,3],
    Piece.new(:king)   => [7,4],
    Piece.new(:bishop) => [7,5],
    Piece.new(:knight) => [7,6],
    Piece.new(:rook)   => [7,7],
    Piece.new(:pawn)   => [6,0],
    Piece.new(:pawn)   => [6,1],
    Piece.new(:pawn)   => [6,2],
    Piece.new(:pawn)   => [6,3],
    Piece.new(:pawn)   => [6,4],
    Piece.new(:pawn)   => [6,5],
    Piece.new(:pawn)   => [6,6],
    Piece.new(:pawn)   => [6,7]
  }

  BLACK_PIECE_HASH = {
    Piece.new(:rook)   => [0,7],
    Piece.new(:knight) => [0,6],
    Piece.new(:bishop) => [0,5],
    Piece.new(:queen)  => [0,4],
    Piece.new(:king)   => [0,3],
    Piece.new(:bishop) => [0,2],
    Piece.new(:knight) => [0,1],
    Piece.new(:rook)   => [0,0],
    Piece.new(:pawn)   => [1,7],
    Piece.new(:pawn)   => [1,6],
    Piece.new(:pawn)   => [1,5],
    Piece.new(:pawn)   => [1,4],
    Piece.new(:pawn)   => [1,3],
    Piece.new(:pawn)   => [1,2],
    Piece.new(:pawn)   => [1,1],
    Piece.new(:pawn)   => [1,0]
  }


  attr_reader :grid
  def initialize
    @grid = Array.new(8){Array.new(8, NullPiece.new)}
    set_up_board
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  def set_up_board
    WHITE_PIECE_HASH.each do |piece, pos|
      self[pos] = piece
    end
    BLACK_PIECE_HASH.each do |piece, pos|
      self[pos] = piece
    end
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].is_a?(NullPiece)
      raise "No piece there!"
    elsif valid_pos?(end_pos)
      raise "Piece already there!"
    end
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new
  end

  def valid_pos?(move)
    move.all?{|el| el.between?(0..7) }
  end
end
