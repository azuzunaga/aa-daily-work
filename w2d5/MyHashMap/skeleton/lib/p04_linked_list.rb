class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    prev.next = @next
    @next.prev = prev
    @next, @prev = nil, nil

    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  def initialize
    @head_node = Node.new
    @tail_node = Node.new
    @head_node.next = @tail_node
    @tail_node.prev = @head_node
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head_node
  end

  def last
    @tail_node
  end

  def empty?
    first.next == last && last.prev == first
  end

  def get(key)
  end

  def include?(key)
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = last.prev
    new_node.next = last
    last.prev.next = new_node
    last.prev = new_node
  end

  def update(key, val)
  end

  def remove(key)
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
