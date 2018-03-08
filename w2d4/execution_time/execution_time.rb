# Time: O(n^2) / Space: O(1)

def my_min_1(array)
  min = array[0]
  array.each do |el1|
    array.each do |el2|
      if el2 < el1 && el2 < min
        min = el2
      end
    end
  end
  min
end

# Time: O(n) / Space; O(1)
def my_min_2(array)
  min = array[0]
  array.drop(1).each do |el1|
    min = el1 if el1 < min
  end
  min
end

# Time O(n^3) / Space: O(n^3)
def largest_cont_1(array)
  results = []
  array.each_with_index do |el1, start_pos|
    (0...(array.length - start_pos)).each do |length|
      results << (array[start_pos..(start_pos + length)])
    end
  end
  results.map do |subarray1|
    subarray1.reduce(:+)
  end.max
end

# Time O(n) / Space O(1)
def largest_cont_2(array)
  largest_total = array[0]
  running_total = nil
  array.each do |el|
    if running_total.nil? || el > largest_total
      running_total = el
      largest_total = running_total if running_total > largest_total
    elsif running_total + el > 0
      running_total += el
      largest_total = running_total if running_total > largest_total
    else
      running_total = nil
    end
  end

  largest_total
end
