# frozen_string_literal: true

require './lib/color'
require './lib/pieces/knight'
require './lib/pieces/pawn'
require './lib/pieces/rook'
require './lib/pieces/bishop'
require './lib/pieces/queen'
require './lib/pieces/king'

class Board
  attr_reader :size, :grid, :pieces

  def initialize
    @size = 8
    @grid = Array.new(size) { Array.new(size, '    ') }

    @pieces = { white: [], black: [] }
    @kings = { white: nil, black: nil }
  end

  def default_state
    create_objects(true)
    create_objects(false)
  end

  def empty?(position)
    @grid[position[0]][position[1]] == '    '
  end

  def select_piece_from(position)
    @grid[position[0]][position[1]]
  end

  def this_piece_white?(position)
    select_piece_from(position).white?
  end

  def update(row, col, value)
    previous_value = @grid[row][col]
    @grid[row][col] = value

    value.update_position(row, col) if value.is_a? Piece

    previous_value
  end

  def validate_move(object, piece, player)
    raise StandardError, 'Invalid move -- There is no piece in this position!' if empty?(object[:source])
    raise StandardError, "Invalid move -- #{player} can't move this piece!" if piece.white? != player.white?

    return true if piece.valid_movement?(object[:source], object[:target], self)

    raise StandardError, "Invalid movement -- You can't move to this position!"
  end

  def execute_move(object, piece, player)
    piece.update
    update(object[:source][0], object[:source][1], '    ')
    captured_piece = update(object[:target][0], object[:target][1], piece)

    { is_in_check: check?(player), has_captured_piece: handle_capture(captured_piece, player),
      game_over: captured_piece.is_a?(King), promoted_piece: piece.promotion? ? piece : nil }
  end

  def path_free?(array)
    array.all? { |value| empty?(value) }
  end

  def make_attribution(piece, row, col)
    piece.update_position(row, col)
    insert_into_array(piece)
    @grid[row][col] = last_item(piece.white?)
  end

  def remove_from_array(piece)
    piece.white? ? @pieces[:white].delete(piece) : @pieces[:black].delete(piece)
  end

  def check?(player)
    opponent_king = king_from(!player.white?)

    pieces = pieces_from(player.white?)
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

  def king_from(white)
    white ? @kings[:white] : @kings[:black]
  end

  def pieces_from(white)
    white ? @pieces[:white] : @pieces[:black]
  end

  def insert_into_array(piece)
    piece.white? ? @pieces[:white].push(piece) : @pieces[:black].push(piece)
    if piece.white? & piece.is_a?(King)
      @kings[:white] = piece
    elsif !piece.white? & piece.is_a?(King)
      @kings[:black] = piece
    end
  end

  def last_item(white)
    white ? @pieces[:white].last : @pieces[:black].last
  end

  def create_objects(white)
    indexes = white ? [7, 6] : [0, 1]
    @size.times do |col|
      make_attribution(Pawn.new(white), indexes[1], col)
    end
    make_attribution(Rook.new(white), indexes[0], 0)
    make_attribution(Knight.new(white), indexes[0], 1)
    make_attribution(Bishop.new(white), indexes[0], 2)
    make_attribution(Queen.new(white), indexes[0], 3)
    make_attribution(King.new(white), indexes[0], 4)
    make_attribution(Bishop.new(white), indexes[0], 5)
    make_attribution(Knight.new(white), indexes[0], 6)
    make_attribution(Rook.new(white), indexes[0], 7)
  end

  def handle_capture(captured_piece, player)
    return false if captured_piece == '    '

    remove_from_array(captured_piece)
    player.capture(player.white? ? captured_piece.to_s.bg_gray.black : captured_piece.to_s.gray)
    true
  end
end
