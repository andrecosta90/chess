# frozen_string_literal: true

require './lib/utils'

class Player
  INPUT_PATTERN = Regexp.new(/^(?:[a-h][1-8]){2}$/)

  def initialize(white)
    @white = white
    @captured_pieces = []
  end

  def white?
    @white
  end

  def promote(piece, board)
    promote_options
    option = select_option

    new_piece = selected_piece_from(option)
    board.make_attribution(new_piece, piece.row, piece.column)
    board.remove_from_array(piece)
  end

  def make_move(board)
    object = translate_input(input)
    piece = board.select_piece_from(object[:source])

    board.validate_move(object, piece, self)
    board.execute_move(object, piece, self)
  end

  def captured_pieces
    @captured_pieces.join(' ')
  end

  def capture(item)
    @captured_pieces.push(item)
  end

  def to_s
    "#{white? ? 'WHITE'.yellow : 'Black'.blue} Player"
  end

  private

  def selected_piece_from(option)
    case option
    when 1
      Queen.new(white?)
    when 2
      Rook.new(white?)
    when 3
      Bishop.new(white?)
    when 4
      Knight.new(white?)
    end
  end

  def select_option
    value = gets.to_i
    raise StandardError, "Invalid input from user :: value='#{value}'" unless (1..4).include?(value)

    value
  end

  def promote_options
    puts '1 - Queen'
    puts '2 - Rook'
    puts '3 - Bishop'
    puts '4 - Knight'
  end

  def input
    print "#{to_s.green}: "
    value = gets.strip
    raise StandardError, "Invalid input from user :: value='#{value}'" if INPUT_PATTERN.match(value).nil?

    value
  end

  def translate_input(value)
    { source: get_coordinates(value[...2]),
      target: get_coordinates(value[2..]) }
  end
end
