# frozen_string_literal: true

require './lib/pieces/movements/diagonal'
require './lib/pieces/movements/straight'

# This class represents a chess piece and contains shared functionality for all pieces
class Piece
  include DiagonalMoveable
  include StraightMoveable

  attr_reader :n_movements, :name

  # Initializes a new Piece
  def initialize(white, symbol, name = 'default_piece')
    @white = white
    @symbol = symbol
    @name = name
    @n_movements = 0
    @current_position = { row: nil, col: nil }
  end

  # Updates the position of the piece
  def update_position(row, col)
    @current_position = { row: row, col: col }
  end

  # Returns the row of the piece
  def row
    @current_position[:row]
  end

  # Returns the column of the piece
  def column
    @current_position[:col]
  end

  # Determines the last rank of the board based on the piece's color
  def last_rank
    white? ? 0 : 7
  end

  # Determines if the piece is eligible for promotion (default is false)
  def promotion?
    false
  end

  # Increments the number of movements made by the piece
  def update
    @n_movements += 1
  end

  # Validates the path from source to target
  # @param source [Array<Integer>] The source coordinates
  # @param target [Array<Integer>] The target coordinates
  # @param board [Board] The current game board
  # @return [Boolean] True if the path is valid, false otherwise
  def path_valid?(source, target, board)
    straight = same_row_or_column?(target, source)
    diagonal = same_diagonal?(target, source)
    return false unless straight || diagonal

    straight ? straight_path_valid?(source, target, board) : diagonal_path_valid?(source, target, board)
  end

  # Checks if the target position contains a piece of the same color
  def same_player?(target, board)
    return false if board.empty?(target)

    board.this_piece_white?(target) == white?
  end

  # Validates if the movement from source to target is valid
  # @param source [Array<Integer>] The source coordinates
  # @param target [Array<Integer>] The target coordinates
  # @param board [Board] The current game board
  # @return [Boolean] True if the movement is valid, false otherwise
  def valid_movement?(source, target, board)
    return false if same_player?(target, board)
    return false if source == target

    true
  end

  # Checks if the piece can reach the target position
  # @param source [Array<Integer>] The source coordinates
  # @param target [Array<Integer>] The target coordinates
  # @param board [Board] The current game board
  # @return [Boolean] True if the piece can reach the target, false otherwise
  def can_reach_target?(source, target, board)
    movable_candidates = movable_items(source).select { |pos| board.empty?(pos) }
    capturable_candidates = capturable_items(source).reject do |pos|
      board.empty?(pos) || board.this_piece_white?(pos) == white?
    end

    movable_candidates.include?(target) || capturable_candidates.include?(target)
  end

  # Checks if the piece is white
  def white?
    @white
  end

  def to_s
    @symbol
  end

  # Generates all potential movable items (positions) for the piece
  # @param source [Array<Integer>] The source coordinates
  # @return [Array<Array<Integer>>] An array of coordinates the piece can move to
  def movable_items(source)
    arr = candidates
    items = arr.map { |param| move_item(source, param) }.sort
    items.reject { |value| out_of_range?(value) }
  end

  # Generates all potential capturable items (positions) for the piece
  # @param source [Array<Integer>] The source coordinates
  # @return [Array<Array<Integer>>] An array of coordinates the piece can capture
  def capturable_items(source)
    movable_items(source)
  end

  private

  # Calculates a new position based on the source position and a given parameter
  def move_item(source, param)
    [source[0] + param[0], source[1] + param[1]]
  end

  # Checks if a given position is out of the board's range
  def out_of_range?(value)
    (value[0].negative? || value[0] > 7) || (value[1].negative? || value[1] > 7)
  end

  # Trims a range of positions
  # @param range [Array<Integer>] The range of positions
  # @param signal [Integer] The direction signal
  # @return [Array<Integer>] The trimmed range
  def trim_path(range, signal)
    range = signal.positive? ? range.reject(&:negative?) : range
    range.to_a[1...-1]
  end

  # Placeholder method for candidates, to be implemented by subclasses
  def candidates; end
end
