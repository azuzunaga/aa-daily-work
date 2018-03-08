require 'set'
require_relative 'player'

class Game
  dict = File.readlines("dictionary.txt").map(&:chomp)
  DICTIONARY = Set.new(dict)

  attr_accessor :fragment, :current_player, :previous_player
  attr_reader :dictionary, :player1, :player2

  def initialize(player1, player2, dictionary = DICTIONARY)
    @fragment = ""
    @player1 = player1
    @player2 = player2
    @dictionary = dictionary
  end

  def valid_play?(string)
    ("a".."z").to_a.include?(string.downcase) && part_of_word?(string)
  end

  def part_of_word?(string)
    maybe_fragment = @fragment + string

    dictionary.any? do |word|
      word[0, maybe_fragment.size] == maybe_fragment
    end
  end

  def play_round
    @current_player = @player1
    @previous_player = @player2

    until lost?(@fragment)
      one_move
    end

    puts "The winner is #{@current_player.name}!"
  end

  def lost?(fragment)
    @dictionary.include?(fragment)
  end

  def next_player!
    @current_player, @previous_player = @previous_player, @current_player
  end

  def get_valid_guess
    print "#{current_player.name} enter a letter: "
    guess = gets.chomp
    until valid_play?(guess)
      puts "Try again: "
      guess = gets.chomp
    end
    guess
  end

  def one_move
    guess = get_valid_guess
    @fragment += guess
    next_player!
    puts "Fragment is: #{@fragment}"
  end

end
