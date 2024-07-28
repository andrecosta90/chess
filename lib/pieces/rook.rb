# frozen_string_literal: true

require './lib/pieces/piece'
require './lib/pieces/movements/straight'

class Rook < Piece
  include StraightMoveable

  CODE_POINT = " \u2656  "
  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black)
  end

  def valid_movement?(source, target, board)
    return false unless super(source, target, board)
    return false unless same_row_or_column?(target, source)

    straight_path_valid?(source, target, board)
  end

  # TODO
  def castling; end
end
