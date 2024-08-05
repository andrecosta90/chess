# frozen_string_literal: true

require './lib/color'
require './lib/pieces/knight'
require './lib/pieces/pawn'
require './lib/pieces/rook'
require './lib/pieces/bishop'
require './lib/pieces/queen'
require './lib/pieces/king'

# The Board class represents a chess board and provides methods
# to manage pieces, validate and execute moves, and check game state.
class Board
  attr_reader :size, :grid, :pieces

  # Initializes a new Board instance with a standard 8x8 grid.
  def initialize
    @size = 8
    @grid = Array.new(size) { Array.new(size, '    ') }

    @pieces = { white: [], black: [] }
    @kings = { white: nil, black: nil }
  end

  # Sets up the board to its default state with all pieces in their initial positions.
  def default_state
    create_pieces(true)
    create_pieces(false)
  end

  # Checks if a given position on the board is empty.
  def empty?(position)
    @grid[position[0]][position[1]] == '    '
  end

  # Selects the piece at a given position on the board.
  def select_piece_from(position)
    @grid[position[0]][position[1]]
  end

  # Checks if the piece at a given position is white.
  def this_piece_white?(position)
    select_piece_from(position).white?
  end

  # Updates the board at a given position with a new value.
  #
  # @param row [Integer] the row to update
  # @param col [Integer] the column to update
  # @param value [Object] the new value
  # @return [Object] the previous value at the position
  def update(row, col, value)
    previous_value = @grid[row][col]
    @grid[row][col] = value

    value.update_position(row, col) if value.is_a? Piece

    previous_value
  end

  # Validates a move on the board.
  #
  # @param object [Hash] the move object containing source and target positions
  # @param piece [Piece] the piece to move
  # @param player [Player] the player making the move
  # @return [Boolean] true if the move is valid, raises an error otherwise
  def validate_move(object, piece, player)
    raise StandardError, 'Invalid move -- There is no piece in this position!' if empty?(object[:source])
    raise StandardError, "Invalid move -- #{player} can't move this piece!" if piece.white? != player.white?

    return true if piece.valid_movement?(object[:source], object[:target], self)

    raise StandardError, "Invalid movement -- You can't move to this position!"
  end

  # Executes a move on the board.
  #
  # @param object [Hash] the move object containing source and target positions
  # @param piece [Piece] the piece to move
  # @param player [Player] the player making the move
  # @return [Hash] the result of the move, including check status and captured pieces
  def execute_move(object, piece, player)
    piece.update
    update(object[:source][0], object[:source][1], '    ')
    captured_piece = update(object[:target][0], object[:target][1], piece)

    { is_in_check: check?(player), has_captured_piece: handle_capture(captured_piece, player),
      game_over: captured_piece.is_a?(King), promoted_piece: piece.promotion? ? piece : nil }
  end

  # Checks if a path is free of pieces.
  def path_free?(array)
    array.all? { |value| empty?(value) }
  end

  # Places a piece at a given position on the board.
  def make_attribution(piece, row, col)
    piece.update_position(row, col)
    add_piece_to_array(piece)
    @grid[row][col] = last_piece(piece.white?)
  end

  # Removes a piece from the board's piece array.
  def remove_from_array(piece)
    piece.white? ? @pieces[:white].delete(piece) : @pieces[:black].delete(piece)
  end

  # Checks if the player is in check.
  def check?(player)
    opponent_king = king_of(!player.white?)

    pieces = pieces_of(player.white?)
    pieces.each do |piece|
      return validate_move({
                             source: [piece.row, piece.column],
                             target: [opponent_king.row, opponent_king.column]
                           }, piece, player)
    rescue StandardError
    end
    false
  end

  private

  # Returns the king of the specified color.
  def king_of(white)
    white ? @kings[:white] : @kings[:black]
  end

  # Returns the pieces of the specified color.
  def pieces_of(white)
    white ? @pieces[:white] : @pieces[:black]
  end

  # Adds a piece to the appropriate piece array.
  def add_piece_to_array(piece)
    piece.white? ? @pieces[:white].push(piece) : @pieces[:black].push(piece)
    if piece.white? & piece.is_a?(King)
      @kings[:white] = piece
    elsif !piece.white? & piece.is_a?(King)
      @kings[:black] = piece
    end
  end

  # Returns the last piece added to the appropriate piece array.
  def last_piece(white)
    white ? @pieces[:white].last : @pieces[:black].last
  end

  # Creates pieces for the board and places them in their initial positions.
  def create_pieces(white)
    rows = white ? [7, 6] : [0, 1]
    @size.times { |col| make_attribution(Pawn.new(white), rows[1], col) }

    piece_classes = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    piece_classes.each_with_index do |piece_class, col|
      make_attribution(piece_class.new(white), rows[0], col)
    end
  end

  # Handles capturing a piece.
  def handle_capture(captured_piece, player)
    return false if captured_piece == '    '

    remove_from_array(captured_piece)
    captured_representation = player.white? ? captured_piece.to_s.bg_gray.black : captured_piece.to_s.gray
    player.capture(captured_representation)
    true
  end
end
