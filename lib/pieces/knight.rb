# frozen_string_literal: true

require './lib/pieces/piece'

class Knight < Piece
  CODE_POINT = " \u2658  "
  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black)
  end

  private

  def permutations
    [-2, -1, 1, 2].permutation(2).reject { |value| value[0].abs == value[1].abs }
  end
end
