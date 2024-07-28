# frozen_string_literal: true

require './lib/pieces/piece'
require './lib/pieces/movements/diagonal'

class Bishop < Piece
  include DiagonalMoveable

  CODE_POINT = " \u2657  "
  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black)
  end

  def valid_movement?(source, target, board)
    return false unless super(source, target, board)
    return false unless same_diagonal?(target, source)

    p "source= #{source}"
    p "target= #{target}"
    p "movement_direction= #{movement_direction(target, source)}"

    diagonal_path_valid?(source, target, board)
  end
end
