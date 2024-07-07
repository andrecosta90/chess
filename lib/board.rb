# frozen_string_literal: true

require_relative 'pieces/pawn'

class Board
  attr_reader :grid, :size

  def initialize
    @size = 8
    @grid = Array.new(size) { Array.new(size, '    ') }

    # initial state
    # white pawn
    @size.times { |col| @grid[6][col] = Pawn.new(true) }

    # black pawn
    @size.times { |col| @grid[1][col] = Pawn.new(false) }

    @messages = ['']
  end

  def empty?(position)
    @grid[position[0]][position[1]] == '    '
  end

  def get_piece(position)
    @grid[position[0]][position[1]]
  end

  # mock => need to translate from chess notation to matrix notation
  # rubocop:disable Metrics
  def move(source, target)
    src = get_coordinates(source)
    tge = get_coordinates(target)

    piece = get_piece(src)

    raise StandardError, 'Invalid move -- There is no piece in this position!' if empty?(src)
    raise StandardError, 'Invalid movement' unless piece.valid_movement?(src, tge, self)

    piece.move
    p piece

    @grid[src[0]][src[1]] = '    ' # FIX ? empty square ?
    @grid[tge[0]][tge[1]] = piece

    @messages.push("#{piece.to_s.bg_green} : #{source.green} → #{target.green} :: #{src} → #{tge}")
  end

  def show
    # system 'clear'
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
  # rubocop:enable Metrics
  #

  private

  def get_coordinates(pos)
    [parse_rank(pos[1]), parse_file(pos[0])]
  end

  def parse_file(char)
    char.downcase.ord - 97
  end

  def parse_rank(char)
    size - char.to_i
  end
end
