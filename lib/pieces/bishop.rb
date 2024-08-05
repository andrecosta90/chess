# frozen_string_literal: true

require './lib/pieces/piece'

# Represents a Bishop piece in a chess game.
class Bishop < Piece
  # Unicode character for the Bishop symbol
  CODE_POINT = " \u2657  "

  # Initializes a new Bishop piece
  # @param white [Boolean] True if the Bishop is white, false if black
  def initialize(white)
    # Call the superclass constructor with the appropriate symbol and name
    super(white, white ? CODE_POINT.gray : CODE_POINT.black, 'bishop')
  end

  # Validates the movement of the Bishop from source to target
  # @param source [Array<Integer>] The starting coordinates
  # @param target [Array<Integer>] The destination coordinates
  # @param board [Board] The current game board
  # @return [Boolean] True if the movement is valid, false otherwise
  def valid_movement?(source, target, board)
    # Check if the movement is valid according to general rules for any piece
    return false unless super(source, target, board)

    # Check if the movement is diagonal
    return false unless same_diagonal?(target, source)

    # Validate the path for diagonal movement
    diagonal_path_valid?(source, target, board)
  end
end
