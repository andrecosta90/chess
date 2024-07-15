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

  def make_move(board)
    object = translate_input(input)
    piece = board.select_piece_from(object[:source])

    validate_move(board, object, piece)
    execute_move(board, object, piece)
  end

  def captured_pieces
    @captured_pieces.join(' ')
  end

  def to_s
    "#{white? ? 'WHITE'.yellow : 'Black'.blue} Player"
  end

  private

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

  def validate_move(board, object, piece)
    raise StandardError, 'Invalid move -- There is no piece in this position!' if board.empty?(object[:source])
    raise StandardError, "Invalid move -- #{self} can't move this piece!" if piece.white? != white?

    return if piece.valid_movement?(object[:source], object[:target], board)

    raise StandardError, "Invalid movement -- You can't move to this position!"
  end

  def clear_source_square(board, source)
    board.update(source[0], source[1], '    ') # empty square
  end

  def move_piece_to_target(board, piece, target)
    board.update(target[0], target[1], piece)
  end

  def handle_capture(captured_piece)
    return if captured_piece == '    '

    @captured_pieces.push(white? ? captured_piece.to_s.bg_gray.black : captured_piece.to_s.gray)
  end

  def execute_move(board, object, piece)
    piece.update
    clear_source_square(board, object[:source])
    captured_piece = move_piece_to_target(board, piece, object[:target])

    handle_capture(captured_piece)
  end
end
