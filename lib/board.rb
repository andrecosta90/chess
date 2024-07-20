# frozen_string_literal: true

require './lib/color'
require './lib/pieces/knight'
require './lib/pieces/pawn'
require './lib/pieces/rook'
require './lib/pieces/bishop'

class Board
  attr_reader :size

  # rubocop:disable Metrics
  def initialize
    @size = 8
    @grid = Array.new(size) { Array.new(size, '    ') }

    # initial state
    #
    # white pieces
    # @size.times { |col| @grid[6][col] = Pawn.new(true) }
    # @grid[7][1] = Knight.new(true)
    # @grid[7][6] = Knight.new(true)
    @grid[7][0] = Rook.new(true)
    @grid[7][7] = Rook.new(true)
    @grid[7][2] = Bishop.new(true)
    @grid[7][5] = Bishop.new(true)

    # black pawn
    @size.times { |col| @grid[1][col] = Pawn.new(false) }
    @grid[0][1] = Knight.new(false)
    @grid[0][6] = Knight.new(false)
    @grid[0][0] = Rook.new(false)
    @grid[0][7] = Rook.new(false)
  end
  # rubocop:enable Metrics

  def empty?(position)
    @grid[position[0]][position[1]] == '    '
  end

  def select_piece_from(position)
    @grid[position[0]][position[1]]
  end

  def update(row, col, value)
    previous_value = @grid[row][col]
    @grid[row][col] = value
    previous_value
  end

  def validate_move(object, piece, player)
    raise StandardError, 'Invalid move -- There is no piece in this position!' if empty?(object[:source])
    raise StandardError, "Invalid move -- #{player} can't move this piece!" if piece.white? != player.white?

    # TODO: raise when piece try to leap - knight is an exception!
    return if piece.valid_movement?(object[:source], object[:target], self)

    raise StandardError, "Invalid movement -- You can't move to this position!"
  end

  def execute_move(object, piece, player)
    piece.update
    clear_source_square(object[:source])
    captured_piece = move_piece_to_target(piece, object[:target])

    handle_capture(captured_piece, player)
  end

  def path_free?(array)
    array.all? { |value| empty?(value) }
  end

  private

  def clear_source_square(source)
    update(source[0], source[1], '    ') # empty square
  end

  def move_piece_to_target(piece, target)
    update(target[0], target[1], piece)
  end

  def handle_capture(captured_piece, player)
    return if captured_piece == '    '

    player.capture(player.white? ? captured_piece.to_s.bg_gray.black : captured_piece.to_s.gray)
  end
end
