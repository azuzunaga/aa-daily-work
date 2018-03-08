class Tile
  attr_reader :value, :given

  def initialize(value, given)
    @value = value
    @given = given
  end

  def to_s
    @value.to_s
  end
end
