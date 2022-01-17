# This method takes an array of stock prices (one for each day) and returns a
# pair of days representing the best day to buy and the best day to sell
# (days start at 0)
#
# Parameters
#
# (Array)
#
# Returns
#
# Array (of size 2)

def stock_picker(stock_prices)
  bestProfit = nil
  bestDays = [nil, nil]

  # for loops aren't preferred in ruby, but I felt like this is a decent
  # application for them
  for i in (1...stock_prices.length).to_a.reverse do
    for j in (0...i).to_a.reverse do
      if bestProfit == nil || stock_prices[i] - stock_prices[j] > bestProfit
        bestProfit = stock_prices[i] - stock_prices[j]
        bestDays = [j, i]
      end
    end
  end

  bestDays
end

p stock_picker([17,3,6,9,15,8,6,1,10])
# returns [1, 4] for a profit of 15 - 3 = 12