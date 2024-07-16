# frozen_string_literal: true

require './lib/pieces/piece'

class Knight < Piece
  CODE_POINT = " \u2658  "
  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black)
  end

  def movable_items(source)
    arr = permutations
    items = arr.map { |param| move_item(source, param) }
    items.reject { |value| out_of_range?(value) }
  end

  def capturable_items(source)
    movable_items(source)
  end

  private

  def move_item(source, param)
    [source[0] + param[0], source[1] + param[1]]
  end

  def permutations
    [-2, -1, 1, 2].permutation(2).reject { |value| value[0].abs == value[1].abs }
  end
end
