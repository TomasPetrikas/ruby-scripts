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
  best_profit = nil
  best_days = [nil, nil]

  (1...stock_prices.length).to_a.reverse.each do |i|
    (0...i).to_a.reverse.each do |j|
      if best_profit.nil? || stock_prices[i] - stock_prices[j] > best_profit
        best_profit = stock_prices[i] - stock_prices[j]
        best_days = [j, i]
      end
    end
  end

  best_days
end

p stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
# returns [1, 4] for a profit of 15 - 3 = 12
