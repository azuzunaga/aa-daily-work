# Time O(n^3) / Space: O(n!)

def first_anagram?(str1, str2)
  anagrams = permutations(str1.chars)
  anagrams.map(&:join).include?(str2)
end

def permutations(array)
  return [array] if array.length <= 1

  first = array.shift
  perms = permutations(array)
  results = []

  perms.each do |perm|
    (perm.length + 1).times do |i|
      results << perm[0...i] + [first] + perm[i..-1]
    end
  end

  results
end

# Time O(n) / Space O(n)
def second_anagram(str1, str2)
  str1 = str1.chars
  str2 = str2.chars

  str1.size.times do
    char = str1[0]
    s2_i = str2.index(char)
    if s2_i
      str1.delete_at(0)
      str2.delete_at(s2_i)
    end

  end

  str1.empty? && str2.empty?
end

def third_anagram(str1, str2)
  quick_sort(str1.chars) == quick_sort(str2.chars)
end
# Time O(nlogn) / Space O(n^2)
def quick_sort(array)
  return array if array.size <= 1
  pivot = array.shift
  left = array.select { |el| el < pivot }
  right = array.select { |el| el >= pivot }

  quick_sort(left) + [pivot] +  quick_sort(right)
end

#Time O(n) / Space O(n)
def fourth_anagram(str1, str2)
  hash = Hash.new(0)

  str1.size.times do |idx|
    hash[str1[idx]] += 1
    hash[str2[idx]] -= 1
  end

  hash.values.all?(&:zero?)
end
