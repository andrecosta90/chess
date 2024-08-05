# frozen_string_literal: true

# Provides diagonal movement capabilities for chess pieces.
module DiagonalMoveable
  # Checks if the path from source to target is clear for diagonal movement.
  # @param source [Array<Integer>] The starting coordinates [row, column]
  # @param target [Array<Integer>] The destination coordinates [row, column]
  # @param board [Board] The current game board
  # @return [Boolean] True if the diagonal path is clear, false otherwise
  def diagonal_path_valid?(source, target, board)
    array = diagonal_movement_range(source, target)
    board.path_free?(array)
  end

  # Determines if the target position is on the same diagonal as the source.
  # @param target [Array<Integer>] The destination coordinates [row, column]
  # @param source [Array<Integer>] The starting coordinates [row, column]
  # @return [Boolean] True if target and source are on the same diagonal, false otherwise
  def same_diagonal?(target, source)
    (target[0] - source[0]).abs == (target[1] - source[1]).abs
  end

  private

  # Calculates the direction of movement for diagonal movement.
  # @param target [Array<Integer>] The destination coordinates [row, column]
  # @param source [Array<Integer>] The starting coordinates [row, column]
  # @return [Array<Integer>] The direction of movement in x and y axes [-1, 1]
  def movement_direction(target, source)
    [
      (target[0] - source[0]).negative? ? -1 : 1,
      (target[1] - source[1]).negative? ? -1 : 1
    ]
  end

  # Generates the range of positions for diagonal movement from source to target.
  # @param source [Array<Integer>] The starting coordinates [row, column]
  # @param target [Array<Integer>] The destination coordinates [row, column]
  # @return [Array<Array<Integer>>] An array of coordinates representing the diagonal path
  def diagonal_movement_range(source, target)
    range_x = get_range(source[0], target[0])
    range_y = get_range(source[1], target[1])
    range_x.zip(range_y)
  end

  # Creates a range of values for movement along a specific axis.
  # @param src [Integer] The starting coordinate
  # @param tgt [Integer] The destination coordinate
  # @return [Array<Integer>] A range of values from src to tgt
  def get_range(src, tgt)
    signal = src > tgt ? -1 : 1
    range = (signal * src..signal * tgt)
    signal.positive? ? range.reject(&:negative?) : range
    trim_path(range, signal).map(&:abs)
  end
end
