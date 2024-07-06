# frozen_string_literal: true

require_relative 'piece'

class Board
  attr_reader :grid, :n_columns, :n_rows

  def initialize
    @n_columns = 8
    @n_rows = 8
    @grid = Array.new(n_rows) { Array.new(n_columns, '    ') }

    # initial state
    @grid[2][3] = " \u2659  ".black
    @grid[6][4] = " \u2659  ".gray
    # @grid[6][3] = '  ♝  '.black
  end

  def empty?(row, col)
    @grid[row][col] = '    '
  end

  def move(source, target)
    raise StandardError, 'Invalid move...' unless valid_movement?(source, target)

    piece = @grid[source[0]][source[1]]
    @grid[source[0]][source[1]] = '    '
    @grid[target[0]][target[1]] = piece
  end

  # rubocop:disable Metrics
  def show
    n = n_columns
    puts
    puts "   #{(' a  '..' h  ').to_a.map(&:green).join('')}"
    n.times do |i|
      print "#{n - i}  ".green
      n.times do |j|
        piece = @grid[i][j]
        square = (i + j).even? ? piece.bg_yellow : piece.bg_red
        print square
      end
      print "  #{n - i}".green
      puts
    end
    puts "   #{(' a  '..' h  ').to_a.map(&:green).join('')}"
    puts
  end
  # rubocop:enable Metrics
  #

  private

  # mock
  def valid_movement?(_source, _target)
    true
  end
end
