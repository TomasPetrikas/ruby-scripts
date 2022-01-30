# frozen_string_literal: true

def fibs(num)
  arr = []

  num.times do |i|
    arr << if i.zero?
             0
           elsif i == 1
             1
           else
             arr[-1] + arr[-2]
           end
  end

  arr
end

def fibs_rec(num)
  return [0] if num == 1
  return [0, 1] if num == 2

  arr = fibs_rec(num - 1)
  arr << arr[num - 2] + arr[num - 3]
end

p fibs(1)
p fibs_rec(1)

p fibs(2)
p fibs_rec(2)

p fibs(3)
p fibs_rec(3)

p fibs(10)
p fibs_rec(10)
