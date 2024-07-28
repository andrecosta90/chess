# frozen_string_literal: true

require './lib/pieces/piece'
require './lib/pieces/movements/diagonal'
require './lib/pieces/movements/straight'

class Queen < Piece
  include DiagonalMoveable
  include StraightMoveable

  CODE_POINT = " \u2655  "
  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black)
  end

  def valid_movement?(source, target, board)
    return false unless super(source, target, board)

    straight = same_row_or_column?(target, source)
    diagonal = same_diagonal?(target, source)
    return false unless straight || diagonal

    if straight
      return straight_path_valid?(source, target, board)
    elsif diagonal
      return diagonal_path_valid?(source, target, board)
    end

    false
  end

  # TODO
  def castling; end
end
