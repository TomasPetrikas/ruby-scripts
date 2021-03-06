# Not the best Ruby implementation because I was translating line-by-line
# pseudocode from Wikipedia
# https://en.wikipedia.org/wiki/Merge_sort

def merge_sort(list)
  return list if list.length <= 1

  left = []
  right = []
  list.each_with_index do |element, index|
    if index < list.length / 2
      left.push(element)
    else
      right.push(element)
    end
  end

  left = merge_sort(left)
  right = merge_sort(right)

  merge(left, right)
end

def merge(left, right)
  result = []

  until left.empty? || right.empty?
    if left.first <= right.first
      result.push(left.first)
      left.shift
    else
      result.push(right.first)
      right.shift
    end
  end

  # Only one of these two will actually run
  result += left unless left.empty?
  result += right unless right.empty?

  result
end

p merge_sort([]) # => []
p merge_sort([1]) # => [1]
p merge_sort([2, 1]) # => [1,2]
p merge_sort([4, 3, 78, 2, 0, 2]) # => [0,2,2,3,4,78]
p merge_sort([3, 2, 1, 0, -1, -2, -3]) # => [-3,-2,-1,0,1,2,3]
