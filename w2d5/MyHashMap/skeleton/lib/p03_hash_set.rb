require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    if count == num_buckets
      resize!
    end

    unless self[num].include?(num)
      self[num] << key
      @count += 1
    end
  end

  def include?(key)
    num = key.hash
    self[num].include?(key)
  end

  def remove(key)
    num = key.hash
    self[num].delete(key)
    @count -= 1
  end

  private

  def [](num)
    @store[num % num_buckets]  # optional but useful; return the bucket corresponding to `num`
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
