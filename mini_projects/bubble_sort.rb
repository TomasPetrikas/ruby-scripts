# Tried to make it a bit fancier and faster

def bubble_sort(list)
  for i in 0...(list.length - 1) do
    is_sorted = true

    for j in 0...(list.length - 1 - i) do
      if list[j] > list[j+1]
        list[j], list[j+1] = list[j+1], list[j]
        is_sorted = false
      end
    end

    if is_sorted
      break
    end
  end

  list
end

p bubble_sort([]) # => []
p bubble_sort([1]) # => [1]
p bubble_sort([2,1]) # => [1,2]
p bubble_sort([4,3,78,2,0,2]) # => [0,2,2,3,4,78]
p bubble_sort([3,2,1,0,-1,-2,-3]) # => [-3,-2,-1,0,1,2,3]