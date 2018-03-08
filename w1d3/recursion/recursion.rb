#recursion exercises
def range(n1, n2)
  return [n1] if n1 == n2 - 1

  [n1] + range(n1+1, n2)
end

def iter_sum(array)
  arr_sum = 0
  array.each {|num| arr_sum += num}
  arr_sum
end

def recur_sum(array)
  return array.first if array.size <= 1

  array.first + recur_sum(array[1..-1])
end

def exp1(base, exp)
  return 1 if exp.zero?

  base * exp1(base, exp - 1)
end

def exp2(base, exp)
  return 1 if exp.zero?

  if exp.even?
    number = exp2(base, exp / 2)
    number * number
  else
    number = exp2(base, (exp - 1) / 2)
    base * number * number
  end
end

def deep_dup(array)
  new_arr = []
  array.each do |el|
    if el.is_a?(Array)
      new_arr << deep_dup(el)
    else
      new_arr << el
    end
  end
  new_arr
end

def fibo(n)
  return nil if n <= 0
  return [1] if n == 1
  return [1, 1] if n == 2

  prev_fib = fibo(n - 1)
  prev_fib << (prev_fib[-1] + prev_fib[-2])
end

def subsets(array)
  return [[]] if array.size.zero?
  new_arr = []
  prev_sub = subsets(array[1..-1]) #[[]]
  prev_sub.each do |pos| #[]
    new_arr << pos
    if pos.is_a?(Array)
      new_arr << (pos.dup << array[0])
    else
      new_arr << [pos, array[0]]
    end
  end

  new_arr

end

def permutations(array)
  return [array] if array.length <= 1

  new_arr = []
  first = array.shift
  pers = permutations(array)

  pers.each do |per|
    (0..per.length).each do |idx|
      new_arr << (per[0...idx] + [first] + per[idx..-1])
    end
  end
  new_arr
end

def bsearch(array, target)
  return nil if array.empty?

  pivot_idx = array.length / 2
  pivot = array[pivot_idx]

  if pivot > target
    bsearch(array[0...pivot_idx], target)
  elsif pivot < target
    bsearch(array[pivot_idx + 1..-1], target)
  else
    return pivot_idx
  end
end
