# frozen_string_literal: true

def merge_sort(list)
  return list if list.length <= 1

  left = []
  right = []
  list.each_with_index do |element, index|
    index < list.length / 2 ? left << element : right << element
  end

  left = merge_sort(left)
  right = merge_sort(right)

  merge(left, right)
end

def merge(left, right)
  result = []

  until left.empty? || right.empty?
    result << if left.first <= right.first
                left.shift
              else
                right.shift
              end
  end

  result + left + right
end

p merge_sort([]) # => []
p merge_sort([1]) # => [1]
p merge_sort([2, 1]) # => [1, 2]
p merge_sort([4, 3, 78, 2, 0, 2]) # => [0, 2, 2, 3, 4, 78]
p merge_sort([3, 2, 1, 0, -1, -2, -3]) # => [-3, -2, -1, 0, 1, 2, 3]
