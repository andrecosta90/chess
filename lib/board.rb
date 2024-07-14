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
    @grid[row][col] = value
  end

  # mock => need to translate from chess notation to matrix notation
  # rubocop:disable Metrics
  def show
    system 'clear'
    n = size
    puts
    puts "   #{(' a  '..' h  ').to_a.map(&:green).join('')}"
    n.times do |i|
      print "#{n - i}  ".green
      n.times do |j|
        piece = @grid[i][j]
        square = (i + j).even? ? piece.to_s.bg_yellow : piece.to_s.bg_red
        print square
      end
      print "  #{n - i}".green
      puts
    end
    puts "   #{(' a  '..' h  ').to_a.map(&:green).join('')}"
    puts
    puts @messages.last(3).join("\n")
    puts
  end
end
