# frozen_string_literal: true

# Provides straight-line movement capabilities for chess pieces.
module StraightMoveable
  # Determines if the target position is on the same row or column as the source position.
  # @param target [Array<Integer>] The destination coordinates [row, column]
  # @param source [Array<Integer>] The starting coordinates [row, column]
  # @return [Boolean] True if target and source are on the same row or column, false otherwise
  def same_row_or_column?(target, source)
    source[0] == target[0] || source[1] == target[1]
  end

  # Checks if the path from source to target is clear for straight-line movement (row or column).
  # @param source [Array<Integer>] The starting coordinates [row, column]
  # @param target [Array<Integer>] The destination coordinates [row, column]
  # @param board [Board] The current game board
  # @return [Boolean] True if the straight path is clear, false otherwise
  def straight_path_valid?(source, target, board)
    index = movement_axis(source, target)
    signal = movement_direction(source, target, index)
    array = movement_range(source, target, index, signal)

    board.path_free?(array)
  end

  private

  # Determines the axis of movement (0 for row, 1 for column) based on the source and target.
  # @param source [Array<Integer>] The starting coordinates [row, column]
  # @param target [Array<Integer>] The destination coordinates [row, column]
  # @return [Integer] The axis of movement (0 for row, 1 for column)
  def movement_axis(source, target)
    source[1] == target[1] ? 1 : 0
  end

  # Calculates the direction of movement along the axis (either -1 or 1).
  # @param source [Array<Integer>] The starting coordinates [row, column]
  # @param target [Array<Integer>] The destination coordinates [row, column]
  # @param index [Integer] The axis of movement (0 for row, 1 for column)
  # @return [Integer] The direction of movement (-1 or 1)
  def movement_direction(source, target, index)
    source[1 - index] > target[1 - index] ? -1 : 1
  end

  # Generates the range of positions for straight-line movement from source to target along the specified axis.
  # @param source [Array<Integer>] The starting coordinates [row, column]
  # @param target [Array<Integer>] The destination coordinates [row, column]
  # @param index [Integer] The axis of movement (0 for row, 1 for column)
  # @param signal [Integer] The direction of movement (-1 or 1)
  # @return [Array<Array<Integer>>] An array of coordinates representing the straight path
  def movement_range(source, target, index, signal)
    range = (signal * source[1 - index]..signal * target[1 - index])
    trim_path(range, signal).map { |value| index == 1 ? [value.abs, source[index]] : [source[index], value.abs] }
  end
end
