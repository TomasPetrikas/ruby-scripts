class Board
  DIGITS = '123456789'.freeze
  MARKS = %w[X O].freeze

  def initialize
    @board = Array.new(3) { Array.new(3) }
    n = 1
    (0..2).each do |i|
      (0..2).each do |j|
        @board[i][j] = n.to_s
        n += 1
      end
    end
  end

  def print_board
    puts "#{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}"
    puts '---------'
    puts "#{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}"
    puts '---------'
    puts "#{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}"
    puts ''
  end

  def place(symbol, location)
    # location expected to be between 1 and 9
    location -= 1
    @board[location / 3][location % 3] = symbol if correct_placement?(symbol, location)
  end

  def correct_placement?(symbol, location)
    # location expected to be between 0 and 8
    return false unless MARKS.include?(symbol)
    return false unless DIGITS.include?((location + 1).to_s)
    return false unless DIGITS.include?(@board[location / 3][location % 3])

    true
  end
end

b = Board.new
b.print_board
b.place('X', 3)
b.print_board
b.place('O', 3)
b.place('Z', 2)
b.place('O', 100)
b.print_board
b.place('O', 4)
b.print_board
