# frozen_string_literal: true

module StraightMoveable
  def same_row_or_column?(target, source)
    source[0] == target[0] || source[1] == target[1]
  end

  def straight_path_valid?(source, target, board)
    index = movement_axis(source, target)
    signal = movement_direction(source, target, index)
    array = movement_range(source, target, index, signal)

    board.path_free?(array)
  end

  private

  def movement_axis(source, target)
    source[1] == target[1] ? 1 : 0
  end

  def movement_direction(source, target, index)
    source[1 - index] > target[1 - index] ? -1 : 1
  end

  def movement_range(source, target, index, signal)
    range = (signal * source[1 - index]..signal * target[1 - index])
    trim_path(range, signal).map { |value| index == 1 ? [value.abs, source[index]] : [source[index], value.abs] }
  end
end
