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

  def detect_winner
    (0..2).each do |i|
      return check_row(i) unless check_row(i).nil?
      return check_column(i) unless check_column(i).nil?
    end

    return check_diagonals unless check_diagonals.nil?

    nil
  end

  private

  def check_row(row)
    if @board[row][0] == @board[row][1] && @board[row][0] == @board[row][2]
      return @board[row][0]
    end

    nil
  end

  def check_column(col)
    if @board[0][col] == @board[1][col] && @board[0][col] == @board[2][col]
      return @board[0][col]
    end

    nil
  end

  def check_diagonals
    if @board[0][0] == @board[1][1] && @board[0][0] == @board[2][2]
      return @board[0][0]
    elsif @board[0][2] == @board[1][1] && @board[0][2] == @board[2][0]
      return @board[0][2]
    end

    nil
  end
end

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class ComputerPlayer < Player
  # TODO
  def return_move(board)
    nil
  end
end

class Controller
  def initialize
    @b = Board.new
  end

  def start
    puts "Welcome to Tic-Tac-Toe!\n"
    puts 'Please make a selection:'
    puts '1 - Play against another human'
    puts '2 - Play against the computer'

    # This should use exceptions
    while true
      mode = gets.chomp.to_i
      break if [1, 2].include?(mode)

      puts 'Oops, try again:'
    end

    puts ''

    mode1 if mode == 1
    mode2 if mode == 2
  end

  private

  def take_turn(player)
    while true
      @b.print_board
      print "#{player.name} (#{player.symbol}), enter your move (1-9): "
      move = gets.chomp.to_i
      puts ''
      break if @b.correct_placement?(player.symbol, move - 1)
    end

    @b.place(player.symbol, move)
  end

  def mode1
    @p1 = Player.new('Player 1', Board::MARKS[0])
    @p2 = Player.new('Player 2', Board::MARKS[1])

    while true
      take_turn(@p1)
      break unless @b.detect_winner.nil?

      take_turn(@p2)
      break unless @b.detect_winner.nil?
    end

    @b.print_board
    if @p1.symbol == @b.detect_winner
      puts "#{@p1.name} (#{@p1.symbol}) has won!"
    else
      puts "#{@p2.name} (#{@p2.symbol}) has won!"
    end
  end

  # TODO
  def mode2

  end
end

c = Controller.new
c.start

# b = Board.new
# b.print_board
# b.place('X', 3)
# b.print_board
# b.place('O', 3)
# b.place('Z', 2)
# b.place('O', 100)
# b.print_board
# b.place('O', 4)
# b.print_board
