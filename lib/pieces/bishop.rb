# frozen_string_literal: true

require './lib/pieces/piece'

class Bishop < Piece
  CODE_POINT = " \u2657  "
  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black, 'bishop')
  end

  def valid_movement?(source, target, board)
    return false unless super(source, target, board)
    return false unless same_diagonal?(target, source)

    diagonal_path_valid?(source, target, board)
  end
end
