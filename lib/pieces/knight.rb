# frozen_string_literal: true

require './lib/pieces/piece'

# Represents a Knight piece in a chess game.
class Knight < Piece
  # Unicode character for the Knight symbol
  CODE_POINT = " \u2658  "

  # Initializes a new Knight piece
  # @param white [Boolean] True if the Knight is white, false if black
  def initialize(white)
    # Call the superclass constructor with the appropriate symbol and name
    super(white, white ? CODE_POINT.gray : CODE_POINT.black, 'knight')
  end

  # Validates the movement of the Knight from source to target
  # @param source [Array<Integer>] The starting coordinates
  # @param target [Array<Integer>] The destination coordinates
  # @param board [Board] The current game board
  # @return [Boolean] True if the movement is valid, false otherwise
  def valid_movement?(source, target, board)
    # Check if the movement is valid according to general rules for any piece
    return false unless super(source, target, board)

    # Validate if the Knight can reach the target position
    can_reach_target?(source, target, board)
  end

  private

  # Provides the set of movement candidates for the Knight
  # @return [Array<Array<Integer>>] Possible movement directions for the Knight
  def candidates
    # Generate all permutations of [-2, -1, 1, 2] with a length of 2
    # and reject those where the absolute values are equal
    [-2, -1, 1, 2].permutation(2).reject { |value| value[0].abs == value[1].abs }
  end
end
