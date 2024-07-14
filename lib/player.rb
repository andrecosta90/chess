# frozen_string_literal: true

require './lib/utils'

class Player
  INPUT_PATTERN = Regexp.new(/^(?:[a-h][1-8]){2}$/)

  def initialize(white)
    @white = white
  end

  def white?
    @white
  end

  def make_move(board)
    object = translate_input(input)
    piece = board.select_piece_from(object[:source])

    validate_move(board, object[:source], object[:target], piece, self)
    execute_move(board, object[:source], object[:target], piece)
    true
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

  def validate_move(board, source, target, piece, player)
    raise StandardError, 'Invalid move -- There is no piece in this position!' if board.empty?(source)
    raise StandardError, "Invalid move -- #{player} can't move this piece!" if piece.white? != player.white?

    return if piece.valid_movement?(source, target, board)

    raise StandardError, "Invalid movement -- You can't move to this position!"
  end

  def execute_move(board, source, target, piece)
    piece.move
    board.update(source[0], source[1], '    ') # empty square
    board.update(target[0], target[1], piece)
  end
end
