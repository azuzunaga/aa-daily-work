require_relative 'card'
require 'byebug'
class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(4) { Array.new(4) }
  end

  def pick_random_cards
    cards = []

    while cards.size < (@grid.length ** 2)
      number = rand(1..13)
      card_one = Card.new(number)
      card_two = Card.new(number)
      cards.concat([card_one, card_two]) unless cards.include?(card_one)
    end
    cards
  end

  def render
    counter = 0
    @grid.each do |row|
      print " #{counter} |"
      row.each do |card|
        print card.show_card
      end
      counter += 1
      puts "\n"
    end
  end

  def populate
    cards = pick_random_cards
    cards = cards.shuffle
    grid.each_index do |row|
      grid[row].each_index do |col|
        pos = [row, col]
        self[pos] = cards.pop
      end
    end
  end

  def won?
    @grid.flatten.all? { |card| card.state == :face_up }
  end

  def reveal(pos)
    if self[pos].state == :face_down
      self[pos].reveal
    else
      puts "Card already revealed!"
    end
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end
end

if __FILE__ == $PROGRAM_NAME
  Board.new.render
end
