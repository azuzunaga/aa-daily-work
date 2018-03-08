require 'byebug'

class Array
  def my_each
    arr = self.dup

    i = 0
    while i < length
      yield arr[i]
      i += 1
    end
    self
  end

  def my_select
    arr = []
    self.my_each do |el|
      arr << el if yield el
    end
    arr
  end

  def my_reject
    arr = []
    self.my_each do |el|
      arr << el unless yield el
    end
    arr
  end

  def my_any?
    self.my_each do |el|
      return true if yield el
    end
    false
  end

  def my_all?
    self.my_each do |el|
      return false unless yield el
    end
    true
  end

  def my_flatten
    if self.class != Array
      return self
    end

    arr = []

    self.my_each do |el|
      if el.class != Array
        arr << el
      else
        flattened_el = el.my_flatten
        arr += flattened_el
      end
    end

    arr
  end

  def my_zip(*args)
    # byebug
    result = Array.new(self.length) {Array.new(args.length + 1)}
    self.each_with_index do |el, idx|
      result[idx][0] = el
    end

    row = 0
    while row < length
      col = 1
      while col < args.length + 1
        result[row][col] = args[col - 1][row]
        col += 1
      end
      row += 1
    end

    result
  end

  def my_rotate(n = 1)
    n = n % length
    if n > 0
      n.times do
        item = self.shift
        self.push(item)
      end
    else
      (-n).times do
        item = self.pop
        self.unshift(item)
      end
    end
    self
  end

  def my_join(seperator = "")
    if self.empty?
      return self
    end

    result = ""
    self.each do |el|
      result += (el + seperator)
    end
    seperator == "" ? result : result.chop
  end

  def my_reverse
    arr = []
    dup = self.dup

    dup.length.times do
      arr << dup.pop
    end

    arr
  end

  def bubble_sort!(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    # debugger
    swaps = true
    while swaps
      swaps = false
      i = 0
      while i < self.length - 1
        j = i + 1
        if prc.call(self[i], self[j]) == 1
          self[i], self[j] = self[j], self[i]
          swaps = true
        end
        i += 1
      end
    end
    self
  end

  def bubble_sort
    dup = self.dup
    dup.bubble_sort!
  end
end

def factors(num)
  arr = []

  (1..num).each do |divisor|
    if num % divisor == 0
      arr << divisor
    end
  end
  arr
end

def substrings(input)
  substrings = []
  1.upto(input.size) do |cons_length|
    input.chars.each_cons(cons_length) { |el| substrings << el.join}
  end

  substrings.uniq
end

def subwords(word, dictionary)
  substrings = substrings(word)
  substrings.select { |sub| dictionary.include?(sub) }
end
