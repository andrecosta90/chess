# frozen_string_literal: true

require './lib/pieces/piece'

# Represents a Queen piece in a chess game.
class Queen < Piece
  # Unicode character for the Queen symbol
  CODE_POINT = " \u2655  "

  # Initializes a new Queen piece
  # @param white [Boolean] True if the Queen is white, false if black
  def initialize(white)
    # Call the superclass constructor with the appropriate symbol and name
    super(white, white ? CODE_POINT.gray : CODE_POINT.black, 'queen')
  end

  # Validates the movement of the Queen from source to target
  # The Queen can move diagonally or straight (vertically/horizontally)
  # @param source [Array<Integer>] The starting coordinates
  # @param target [Array<Integer>] The destination coordinates
  # @param board [Board] The current game board
  # @return [Boolean] True if the movement is valid, false otherwise
  def valid_movement?(source, target, board)
    # Check if the movement is valid according to general rules for any piece
    return false unless super(source, target, board)

    # Validate if the path from source to target is clear
    path_valid?(source, target, board)
  end

  # TODO: Implement castling rule for Queen
  def castling; end
end
