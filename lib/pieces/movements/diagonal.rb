# frozen_string_literal: true

module DiagonalMoveable
  def diagonal_path_valid?(source, target, board)
    array = diagonal_movement_range(source, target)
    board.path_free?(array)
  end

  def same_diagonal?(target, source)
    (target[0] - source[0]).abs == (target[1] - source[1]).abs
  end

  private

  def movement_direction(target, source)
    [
      (target[0] - source[0]).negative? ? -1 : 1,
      (target[1] - source[1]).negative? ? -1 : 1
    ]
  end

  def diagonal_movement_range(source, target)
    range_x = get_range(source[0], target[0])
    range_y = get_range(source[1], target[1])
    range_x.zip(range_y)
  end

  def get_range(src, tgt)
    signal = src > tgt ? -1 : 1
    range = (signal * src..signal * tgt)
    signal.positive? ? range.reject(&:negative?) : range
    trim_path(range, signal).map(&:abs)
  end
end
