# frozen_string_literal: true

# I was curious what a Ruby solution to the more well-known Knight's tour
# problem looks like, so I grabbed this from here:
# http://www.rosettacode.org/wiki/Knight%27s_tour#Ruby
#
# Code is not mine.

# Knight's tour using Warnsdorff's rule
# https://en.wikipedia.org/wiki/Knight%27s_tour#Warnsdorff.27s_rule

# Game board and solver
class Board
  Cell = Struct.new(:value, :adj) do
    def self.end=(end_val)
      @@end = end_val
    end

    def try(seq_num)
      self.value = seq_num
      return true if seq_num == @@end

      a = []
      adj.each_with_index do |cell, n|
        a << [wdof(cell.adj) * 10 + n, cell] if cell.value.zero?
      end
      a.sort.each { |_, cell| return true if cell.try(seq_num + 1) }
      self.value = 0
      false
    end

    def wdof(adj)
      adj.count { |cell| cell.value.zero? }
    end
  end

  # default move (Knight)
  ADJACENT = [[-1, -2], [-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2]].freeze

  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    frame = ADJACENT.flatten.map(&:abs).max
    @board = Array.new(rows + frame) do |i|
      Array.new(cols + frame) do |j|
        i < rows && j < cols ? Cell.new(0) : nil  # frame (Sentinel value : nil)
      end
    end
    rows.times do |i|
      cols.times do |j|
        @board[i][j].adj = ADJACENT.map { |di, dj| @board[i + di][j + dj] }.compact
      end
    end
    Cell.end = rows * cols
    @format = " %#{(rows * cols).to_s.size}d"
  end

  def solve(s_x, s_y)
    if (@rows * @cols).odd? && (s_x + s_y).odd?
      puts 'No solution'
    else
      puts(@board[s_x][s_y].try(1) ? to_s : 'No solution')
    end
  end

  def to_s
    (0...@rows).map do |x|
      (0...@cols).map { |y| @format % @board[x][y].value }.join
    end
  end
end

def knight_tour(rows = 8, cols = rows, start = [rand(rows), rand(cols)])
  puts "\nBoard (#{rows} x #{cols}), Start: [#{start[0]}, #{start[1]}]"
  Board.new(rows, cols).solve(start[0], start[1])
end

knight_tour(8, 8, [3, 1])

knight_tour(5, 5, [2, 2])

knight_tour(4, 9, [0, 0])

knight_tour(5, 5, [0, 1])

knight_tour(12, 12, [1, 1])
