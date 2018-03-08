class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.join('*').hash
  end
end

class String
  def hash
    self.chars.map { |chr| chr.ord }.join.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    (self.keys.sort.join('$') + self.values.sort.join("+")).hash
  end
end
