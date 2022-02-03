# frozen_string_literal: true

# Chess board
class Board
  BOARD_SIZE = 8

  def initialize
    @visited = []
    @path = []
  end

  def knight_moves(start, goal)
    return unless correct_coords?(start) && correct_coords?(goal)
    return @path if @path.first == start && @path.last == goal

    @visited << start unless @visited.include?(start)
    @path << start unless @path.include?(start)
    moves = generate_moves(start) - @visited

    # p moves

    return if moves.empty?

    moves.each do |move|
      next if @visited.include?(move)

      @path << move
      if move == goal
        puts 'goal found'
        print "#{@path}\n"
        return @path
      else
        knight_moves(move, goal)
        @path.delete(move) unless @path.first == start && @path.last == goal
      end
    end
  end

  private

  def generate_moves(coords)
    return unless correct_coords?(coords)

    x, y = coords
    moves = [x - 1, x + 1].product([y - 2, y + 2]) + [x - 2, x + 2].product([y - 1, y + 1])
    moves.select { |move| correct_coords?(move) }
  end

  def correct_coords?(coords)
    return false unless coords.size == 2

    coords[0].between?(0, BOARD_SIZE - 1) && coords[1].between?(0, BOARD_SIZE - 1)
  end
end

b = Board.new
p b.knight_moves([0, 0], [7, 7])
