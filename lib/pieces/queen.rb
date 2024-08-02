# frozen_string_literal: true

require './lib/pieces/piece'

class Queen < Piece
  CODE_POINT = " \u2655  "
  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black, 'queen')
  end

  def valid_movement?(source, target, board)
    return false unless super(source, target, board)

    path_valid?(source, target, board)
  end

  # TODO
  def castling; end
end
