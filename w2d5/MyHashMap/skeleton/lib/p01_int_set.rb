class MaxIntSet
  def initialize(max)
    @max = max
    @set = Array.new(max)
  end

  def insert(num)
    validate!(num)
    @set << num
  end

  def remove(num)
    @set.delete(num) if include?(num)
  end

  def include?(num)
    @set.include?(num)
  end

  private

  def is_valid?(num)
    num < @max && num >= 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num) && !include?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if count == num_buckets
      resize!
    end

    unless self[num].include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }
    temp.each do |bucket|
      bucket.each do |el|
        insert(el)
      end
    end
  end
end
