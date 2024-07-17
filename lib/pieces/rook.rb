# frozen_string_literal: true

require './lib/pieces/piece'

class Rook < Piece
  CODE_POINT = " \u2656  "
  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black)
  end

  private

  def permutations
    (-7..7).reject(&:zero?).flat_map { |idx| [[0, idx], [idx, 0]] }
  end
end
