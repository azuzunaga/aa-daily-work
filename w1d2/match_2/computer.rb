require 'byebug'
class Computer
  attr_reader :name, :known_cards, :board, :best_candidate

  def initialize
    @name = "Computer"
    @known_cards = Hash.new {|h, v| h[v] = Array.new }
    @board = Board.new
    @best_candidate = []
  end

  def available_positions
    positions = []
    @board.grid.each_index do |row|
      @board.grid[row].each_index do |col|
        position = [row, col]
        positions << position if @board[position].nil?
      end
    end
    positions
  end

  def get_guess
    debugger
    candidate = @known_cards.select { |k, v| v.flatten.size == 4 }.values
    unless candidate.empty?
      @best_candidate += candidate
      key = @known_cards.key(candidate)
      @known_cards.delete(key)
    end

    unless @best_candidate.empty?
      guess = @best_candidate.pop
      guess
    end

    available_positions.sample
  end

  def receive_guess(cards, positions)
    card1, card2 = cards
    pos1, pos2 = positions
    @known_cards[card1] << pos1 unless @known_cards.values.include?(pos1)
    @known_cards[card2] << pos2 unless @known_cards.values.include?(pos2)
  end
end
