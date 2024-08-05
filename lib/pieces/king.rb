# frozen_string_literal: true

require './lib/pieces/piece'

# Represents a King piece in a chess game.
class King < Piece
  # Unicode character for the King symbol
  CODE_POINT = " \u2654  "

  # Initializes a new King piece
  # @param white [Boolean] True if the King is white, false if black
  def initialize(white)
    # Call the superclass constructor with the appropriate symbol and name
    super(white, white ? CODE_POINT.gray : CODE_POINT.black, 'king')
  end

  # Validates the movement of the King from source to target
  # @param source [Array<Integer>] The starting coordinates
  # @param target [Array<Integer>] The destination coordinates
  # @param board [Board] The current game board
  # @return [Boolean] True if the movement is valid, false otherwise
  def valid_movement?(source, target, board)
    # Check if the movement is valid according to general rules for any piece
    return false unless super(source, target, board)

    # Validate if the King can reach the target position
    can_reach_target?(source, target, board)
  end

  private

  # Provides the set of movement candidates for the King
  # @return [Array<Array<Integer>>] Possible movement directions for the King
  def candidates
    # Generate all combinations of (-1, 0, 1) excluding the (0, 0) case
    array = [-1, 0, 1]
    array.product(array).reject { |value| value[0].zero? && value[1].zero? }
  end
end
