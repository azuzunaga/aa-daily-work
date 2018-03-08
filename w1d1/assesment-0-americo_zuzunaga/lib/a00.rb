# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

def caesar_cipher(str, shift)
  letters = ('a'..'z').to_a

  encoded = []

  str.chars.each do |letter|
    if letter == " "
      encoded << letter
    else
      alpha_shift = (letters.find_index(letter) + shift) % 26
      encoded << letters[alpha_shift]
    end
  end

  encoded.join
end

# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

# Example:
# digital_root(4322) => digital_root(11) => (2)

def digital_root(num)
  return num if (num % 10) == num

  digital_root(digital_root_step(num))
end

def digital_root_step(num)
  string_num = num.to_s.chars
  sum = 0
  string_num.each do |digit|
    sum += digit.to_i
  end
  string_num.join.to_i
end

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)
  return str.chars.sort.join if alphabet.nil?

  str_sorted = []
  alphabet.each do |el|
    if str.include?(el)
      str_sorted << el * str.count(el)
    end
  end

  str_sorted.join
end

class Array
  # Write a method, `Array#two_sum`, that finds all pairs of positions where the
  # elements at those positions sum to zero.

  # NB: ordering matters. I want each of the pairs to be sorted smaller index
  # before bigger index. I want the array of pairs to be sorted
  # "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def two_sum
    arr = []

    i = 0
    while i < self.length
      j = i + 1
      while j < self.length
        if (self[i] + self[j]).zero?
          arr << [i, j]
        end
        j += 1
      end
      i += 1
    end

    arr
  end
end

class String
  # Returns an array of all the subwords of the string that appear in the
  # dictionary argument. The method does NOT return any duplicates.

  def real_words_in_string(dictionary)
    arr = []
    1.upto(self.size) do |w_len|
      self.chars.each_cons(w_len) do |comb|
        arr << comb.join if dictionary.include?(comb.join)
      end
    end

    arr.uniq.reverse
  end
end

# Write a method that returns the factors of a number in ascending order.

def factors(num)
  facts = []

  1.upto(num) do |divisor|
    facts << divisor if (num % divisor).zero?
  end

  facts
end
