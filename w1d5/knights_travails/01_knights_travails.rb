require 'byebug'
require_relative '../skeleton/lib/00_tree_node.rb'

class KnightPathFinder
  attr_reader :visited_positions, :pos, :tree

  def initialize(pos)
    @pos = pos
    @board = Array.new(8) { Array.new(8, "pos") }
    @tree = PolyTreeNode.new(@pos)
    @visited_positions = [pos]
  end

  def build_move_tree
    # byebug
    queue = []
    queue.push(@tree)
    until queue.empty?
      moves = new_move_positions(queue.first.value)
      moves.each do |move|
        kid = PolyTreeNode.new(move)
        queue.push(kid)
        queue.first.add_child(kid)
      end
      queue.shift
    end

  end

  def find_path

  end

  def self.valid_moves(pos)
    @board = Array.new(8) { Array.new(8, "pos") }
    positions = []
    row, col = pos
    positions << [row-2,col-1] if (row-2).between?(0, 7) && (col-1).between?(0, 7)
    positions << [row-2,col+1] if (row-2).between?(0, 7) && (col+1).between?(0, 7)
    positions << [row+1,col-2] if (row+1).between?(0, 7) && (col-2).between?(0, 7)
    positions << [row-1,col-2] if (row-1).between?(0, 7) && (col-2).between?(0, 7)
    positions << [row+1,col+2] if (row+1).between?(0, 7) && (col+2).between?(0, 7)
    positions << [row-1,col+2] if (row-1).between?(0, 7) && (col+2).between?(0, 7)
    positions << [row+2,col-1] if (row+2).between?(0, 7) && (col-1).between?(0, 7)
    positions << [row+2,col+1] if (row+2).between?(0, 7) && (col+1).between?(0, 7)
    positions
  end

  def new_move_positions(codinate)
    moves = KnightPathFinder.valid_moves(codinate)
    available_new_moves = []

    moves.each do |move|
      available_new_moves << move unless @visited_positions.include?(move)
    end

    visited_positions.concat(available_new_moves)

    available_new_moves
  end

  def over?
    visited_positions.size = 64
  end


end
