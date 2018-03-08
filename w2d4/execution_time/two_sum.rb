# Time: O(n^2) / Space: O(1)
def bad_two_sum?(array, target)
  array.each_index do |idx|
    jdx = idx+1
    next if jdx == array.length
    while jdx < array.length
      return true if array[idx] + array[jdx] == target
      jdx += 1
    end
  end
  false
end

# Time: O(nlog(n)) / Space: O(n^2)

def ok_two_sum(arr, target)
  sorted = quick_sort(arr)

  arr.each do |el|
    b_target = target - el
    return true if b_search(arr, b_target)
  end
  false
end

def quick_sort(array)
  return array if array.size <= 1
  pivot = array.shift
  left = array.select { |el| el < pivot }
  right = array.select { |el| el >= pivot }

  quick_sort(left) + [pivot] +  quick_sort(right)
end

def b_search(array, target)
  return nil if array.empty?

  mid = array.size / 2

  case target <=> mid
  when 0
    return mid
  when -1
    b_search(array.take(mid), target)
  when 1
    search_res = b_search(array.drop(mid + 1), target)
    search_res.nil? ? nil : mid + search_res + 1
  end
end

# Time: O(n) / Space: O(n)
def two_sum?(array, target)
  hash = Hash.new
  array.each do |el|
    interm_target = target - el
    return true if hash.keys.include?(el)
    hash[interm_target] = true
  end
  false
end
