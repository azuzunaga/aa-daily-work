def sum_to(n)
  return nil if n < 0
  return n if n == 0
  n + sum_to(n - 1)
end

def add_numbers(array)
  return array.first if array.size == 1
  return nil if array.empty?
  array.first + add_numbers(array[1..-1])
end

def gamma_fnc(n)
  return 1 if n == 1
  return nil if n <= 0
  (n - 1) * gamma_fnc(n - 1)
end

def ice_cream_shop(flavors, favorite)
  return flavors.first == favorite if flavors.size <= 1

  first_flavor = ice_cream_shop([flavors.first], favorite)
  other_flavors = ice_cream_shop(flavors[1..-1], favorite)

  first_flavor || other_flavors
end

def reverse(str)
  return str if str.length <= 1
  reverse(str[-1]) + reverse(str[0..-2])
end
