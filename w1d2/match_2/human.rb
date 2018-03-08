class Human
  attr_reader :name

  def initialize
    @name = "Americo"
  end

  def get_guess
    print "#{name} enter your guess like so: row, col (0, 0): "
    gets.chomp.split.map(&:to_i)
  end

  def receive_guess(*args); end
end
