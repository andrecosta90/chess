# frozen_string_literal: true

require './lib/pieces/piece'

# Represents a Pawn piece in a chess game.
class Pawn < Piece
  attr_reader :additive_factor

  # Unicode character for the Pawn symbol
  CODE_POINT = " \u2659  "

  # Initializes a new Pawn piece
  # @param white [Boolean] True if the Pawn is white, false if black
  def initialize(white)
    # Call the superclass constructor with the appropriate symbol and name
    super(white, white ? CODE_POINT.gray : CODE_POINT.black, 'pawn')
    # Set the direction of movement based on color
    @additive_factor = white ? -1 : 1
  end

  # Validates the movement of the Pawn from source to target
  # @param source [Array<Integer>] The starting coordinates
  # @param target [Array<Integer>] The destination coordinates
  # @param board [Board] The current game board
  # @return [Boolean] True if the movement is valid, false otherwise
  def valid_movement?(source, target, board)
    # Check if the movement is valid according to general rules for any piece
    return false unless super(source, target, board)
    # Validate if the Pawn can reach the target position
    return false unless can_reach_target?(source, target, board)

    # Ensure the path is clear for the Pawn to move
    path_valid?(source, target, board)
  end

  # TODO: Implement en passant rule for Pawn
  def en_passant; end

  # Determines if the Pawn has reached the promotion rank
  # @return [Boolean] True if the Pawn is in the last rank, false otherwise
  def promotion?
    row == last_rank
  end

  # Provides the set of valid movements for the Pawn
  # @param source [Array<Integer>] The starting coordinates
  # @return [Array<Array<Integer>>] Possible movement positions for the Pawn
  def movable_items(source)
    # Calculate the forward movement based on the additive factor
    array = [
      [source[0] + @additive_factor, source[1]]
    ]

    # Allow for a double-step forward if the Pawn has not moved yet
    array.push([source[0] + (@additive_factor * 2), source[1]]) if @n_movements.zero?

    # Remove movements that are out of range
    array.reject { |value| out_of_range?(value) }
  end

  # Provides the set of valid capture movements for the Pawn
  # @param source [Array<Integer>] The starting coordinates
  # @return [Array<Array<Integer>>] Possible capture positions for the Pawn
  def capturable_items(source)
    [
      [source[0] + @additive_factor, source[1] + 1],
      [source[0] + @additive_factor, source[1] - 1]
    ].reject { |value| out_of_range?(value) }
  end
end
