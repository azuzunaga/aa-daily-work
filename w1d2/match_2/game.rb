require_relative 'board'
require_relative 'human'
require_relative 'computer'

class Game
  attr_reader :board, :already_up, :player

  def initialize
    @board = Board.new
    @board.populate
    @already_up = []
    @player = Player.new
  end

  def handle_response(guess)
    until valid_guess?(guess)
      puts "Invalid position. Try again: "
      guess = @player.get_guess
    end
    already_up << guess
    guess
  end

  def play
    @board.render
    until @board.won?
      first_guess = handle_response(@player.get_guess)
      second_guess = handle_response(@player.get_guess)
      @board.render
      make_guess(first_guess, second_guess)
      @board.render
    end
    puts "You won!"
  end

  def make_guess(first_guess, second_guess)
    card1 = @board[first_guess]
    card2 = @board[second_guess]
    cards = [card1, card2]

    cards.each(&:reveal)

    @player.receive_guess(cards.each(&:face_value), [first_guess, second_guess])
    system "clear"
    @board.render
    if card1 == card2
      puts "Cards match!"
    else
      cards.each(&:hide)
      puts "No match!"
      @already_up.pop
      @already_up.pop
    end
  end

  def valid_guess?(pos)
    inside_board = pos.all? do |coordinate|
      (0..board.grid.length - 1).cover?(coordinate)
    end
    inside_board && !already_up.include?(pos)
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
