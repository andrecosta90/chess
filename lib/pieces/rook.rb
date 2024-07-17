# frozen_string_literal: true

require './lib/pieces/piece'

class Rook < Piece
  CODE_POINT = " \u2656  "
  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black)
  end

  def valid_movement?(source, target, board)
    return false unless valid_path?(source, target, board)

    super(source, target, board)
  end

  private

  def valid_path?(source, target, board)
    index = movement_axis(source, target)
    signal = movement_direction(source, target, index)
    array = movement_range(source, target, index, signal)

    board.path_free?(array)
  end

  def movement_axis(source, target)
    source[1] == target[1] ? 1 : 0
  end

  def movement_direction(source, target, index)
    source[1 - index] > target[1 - index] ? -1 : 1
  end

  def movement_range(source, target, index, signal)
    range = (signal * source[1 - index]..signal * target[1 - index])
    range = signal.positive? ? range.reject(&:negative?) : range
    range.to_a[1...-1].map { |value| index == 1 ? [value.abs, source[index]] : [source[index], value.abs] }
  end

  def permutations
    (-7..7).reject(&:zero?).flat_map { |idx| [[0, idx], [idx, 0]] }
  end
end
