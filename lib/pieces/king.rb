# frozen_string_literal: true

require './lib/pieces/piece'

class King < Piece
  CODE_POINT = " \u2654  "
  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black)
  end

  def valid_movement?(source, target, board)
    return false unless super(source, target, board)

    can_reach_target?(source, target, board)
  end

  private

  def candidates
    array = [-1, 0, 1]
    array.product(array).reject { |value| value[0].zero? & value[1].zero? }
  end
end
