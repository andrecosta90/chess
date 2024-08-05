# frozen_string_literal: true

require './lib/utils'

# Player class represents a player in a chess game.
# Handles player-specific actions such as making moves,
# capturing pieces, and promoting pawns.
class Player
  INPUT_PATTERN = Regexp.new(/^(?:[a-h][1-8]){2}$/)

  # Initializes a new Player instance.
  #
  # @param white [Boolean] true if the player is white, false if black
  def initialize(white)
    @white = white
    @captured_pieces = []
  end

  # Returns whether the player is white.
  #
  # @return [Boolean] true if the player is white, false if black
  def white?
    @white
  end

  # Promotes a pawn to another piece.
  #
  # @param piece [Piece] the piece to be promoted
  # @param board [Board] the current game board
  def promote(piece, board)
    display_promote_options
    option = select_promote_option

    new_piece = create_piece(option)
    board.make_attribution(new_piece, piece.row, piece.column)
    board.remove_from_array(piece)
  end

  # Makes a move on the board based on player input.
  #
  # @param board [Board] the current game board
  def make_move(board)
    object = parse_input(board)

    piece = board.select_piece_from(object[:source])
    board.validate_move(object, piece, self)
    board.execute_move(object, piece, self)
  end

  # Returns a string of captured pieces.
  def captured_pieces
    @captured_pieces.join(' ')
  end

  # Adds a captured piece to the player's collection.
  def capture(item)
    @captured_pieces.push(item)
  end

  # Returns a string representation of the player.
  def to_s
    "#{white? ? 'WHITE'.yellow : 'Black'.blue} Player"
  end

  private

  # Creates a new piece based on the selected option.
  def create_piece(option)
    case option
    when 1
      Queen.new(white?)
    when 2
      Rook.new(white?)
    when 3
      Bishop.new(white?)
    when 4
      Knight.new(white?)
    end
  end

  # Prompts the user to select a promotion option.
  def select_promote_option
    value = gets.to_i
    raise StandardError, "Invalid input from user :: value='#{value}'" unless (1..4).include?(value)

    value
  end

  # Displays the promotion options to the user.
  def display_promote_options
    puts '1 - Queen'
    puts '2 - Rook'
    puts '3 - Bishop'
    puts '4 - Knight'
  end

  # Prompts the user for input and validates it.
  def input
    print "#{to_s.green}: "
    value = gets.strip
    raise StandardError, "Invalid input from user :: value='#{value}'" if INPUT_PATTERN.match(value).nil?

    value
  end

  # Parses the input and returns the source and target coordinates.
  def parse_input(_board)
    value = input
    { source: Utils.get_coordinates(value[...2]),
      target: Utils.get_coordinates(value[2..]) }
  end
end
