# frozen_string_literal: true

# I literally couldn't figure this out (first time for a TOP project so far),
# so I tried to rewrite what I had based on another student's solution.
#
# https://github.com/qpongratz/knights-travails/blob/main/knight_moves.rb
#
# I can usually understand a recursive solution when I see it (eventually),
# but my brain really struggles to generate one on its own.
#
# My main contribution here is slightly prettier printing.

# Controls what move nodes to keep track of
class Node
  BOARD_SIZE = 8

  attr_reader :coords, :parent

  @@history = []

  def initialize(coords, parent)
    @coords = coords
    @parent = parent
    @@history << coords
  end

  def generate_moves
    x, y = @coords
    moves = [x - 1, x + 1].product([y - 2, y + 2]) + [x - 2, x + 2].product([y - 1, y + 1])
    moves.select! { |move| Node.correct_coords?(move) }
    moves -= @@history
    moves.map { |move| Node.new(move, self) }
  end

  def self.correct_coords?(coords)
    return false unless coords.size == 2

    coords[0].between?(0, BOARD_SIZE - 1) && coords[1].between?(0, BOARD_SIZE - 1)
  end
end

def unroll(node, arr = [])
  unroll(node.parent, arr) unless node.parent.nil?
  arr << node.coords
end

def display(arr)
  puts "Total number of moves: #{arr.size - 1}"
  p arr

  board = Array.new(Node::BOARD_SIZE) { Array.new(Node::BOARD_SIZE, '_') }
  arr.each_with_index { |pos, i| board[pos[0]][pos[1]] = i }
  display_2d(board)
end

def display_2d(arr)
  arr.each do |row|
    row.each do |cell|
      print("#{cell} ")
    end
    puts
  end
end

def knight_moves(start, goal)
  queue = []
  current_node = Node.new(start, nil)
  until current_node.coords == goal
    current_node.generate_moves.each { |move| queue.push(move) }
    current_node = queue.shift
  end
  display(unroll(current_node))
end

knight_moves([0, 0], [7, 7])
