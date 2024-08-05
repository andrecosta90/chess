# frozen_string_literal: true

require './lib/pieces/piece'

# Represents a Rook piece in a chess game.
class Rook < Piece
  # Unicode character for the Rook symbol
  CODE_POINT = " \u2656  "

  # Initializes a new Rook piece
  # @param white [Boolean] True if the Rook is white, false if black
  def initialize(white)
    # Call the superclass constructor with the appropriate symbol and name
    super(white, white ? CODE_POINT.gray : CODE_POINT.black, 'rook')
  end

  # Validates the movement of the Rook from source to target
  # The Rook can move straight (vertically/horizontally) but not diagonally
  # @param source [Array<Integer>] The starting coordinates
  # @param target [Array<Integer>] The destination coordinates
  # @param board [Board] The current game board
  # @return [Boolean] True if the movement is valid, false otherwise
  def valid_movement?(source, target, board)
    # Check if the movement is valid according to general rules for any piece
    return false unless super(source, target, board)

    # Validate if the Rook is moving in a straight line (row or column)
    return false unless same_row_or_column?(target, source)

    # Validate if the path from source to target is clear
    straight_path_valid?(source, target, board)
  end

  # TODO: Implement castling rule for Rook
  def castling; end
end
