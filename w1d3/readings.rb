def upcase(str)
  return str.upcase if str.legth <= 1
  upcase(str[0]) + upcase(str[1..-1])
end

def reverse(str)
  return str if str.length <= 1
  reverse(str[-1]) + reverse(str[0..-2])
end

def quick_sort(array)
  return array if array.size <= 1
  pivot_arr = [array.first]
  left_array = array[1..-1].select { |el| el <= array.first }
  right_array = array[1..-1].select { |el| el > array.first }

  quick_sort(left_array) + pivot_arr + quick_sort(right_array)
end
