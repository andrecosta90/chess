# frozen_string_literal: true

require './lib/color'
require './lib/pieces/pawn'

class Board
  attr_reader :size

  def initialize
    @size = 8
    @grid = Array.new(size) { Array.new(size, '    ') }

    # initial state
    # white pawn
    @size.times { |col| @grid[6][col] = Pawn.new(true) }

    # black pawn
    @size.times { |col| @grid[1][col] = Pawn.new(false) }
  end

  def empty?(position)
    @grid[position[0]][position[1]] == '    '
  end

  def select_piece_from(position)
    @grid[position[0]][position[1]]
  end

  def update(row, col, value)
    previous_value = @grid[row][col]
    @grid[row][col] = value
    previous_value
  end
end
