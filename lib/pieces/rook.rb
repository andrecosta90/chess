# frozen_string_literal: true

require './lib/pieces/piece'

class Rook < Piece
  CODE_POINT = " \u2656  "
  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black, 'rook')
  end

  def valid_movement?(source, target, board)
    return false unless super(source, target, board)
    return false unless same_row_or_column?(target, source)

    straight_path_valid?(source, target, board)
  end

  # TODO
  def castling; end
end
