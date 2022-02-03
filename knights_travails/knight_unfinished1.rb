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

    @visited << start unless @visited.include?(start)
    @path << start unless @path.include?(start)
    moves = generate_moves(start) - @visited

    # p moves

    return if moves.empty?

    moves.each do |move|
      return @path if move == goal

      @path << move unless @path.include?(move)
      knight_moves(move, goal)
      return @path if move == goal

      @path.delete(move)
    end

    # @path
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
    return false unless coords[0].between?(0, BOARD_SIZE - 1)
    return false unless coords[1].between?(0, BOARD_SIZE - 1)

    true
  end
end

b = Board.new
p b.knight_moves([0, 0], [7, 7])
