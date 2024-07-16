# frozen_string_literal: true

require './lib/color'
require './lib/pieces/knight'
require './lib/pieces/pawn'
require './lib/pieces/rook'

class Board
  attr_reader :size

  # rubocop:disable Metrics
  def initialize
    @size = 8
    @grid = Array.new(size) { Array.new(size, '    ') }

    # initial state
    #
    # white pieces
    @size.times { |col| @grid[6][col] = Pawn.new(true) }
    @grid[7][1] = Knight.new(true)
    @grid[7][6] = Knight.new(true)
    @grid[7][0] = Rook.new(true)
    @grid[7][7] = Rook.new(true)

    # black pawn
    @size.times { |col| @grid[1][col] = Pawn.new(false) }
    @grid[0][1] = Knight.new(false)
    @grid[0][6] = Knight.new(false)
    @grid[0][0] = Rook.new(false)
    @grid[0][7] = Rook.new(false)
  end
  # rubocop:enable Metrics

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
