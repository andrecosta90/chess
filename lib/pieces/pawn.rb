# frozen_string_literal: true

require './lib/pieces/piece'

class Pawn < Piece
  CODE_POINT = " \u2659  "

  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black)
    @additive_factor = white ? -1 : 1
  end

  def valid_movement?(source, target, board)
    return false unless super(source, target, board)

    valid_path?(source, target, board)
  end

  # TODO
  def en_passant; end
  # TODO
  def promotion; end

  private

  def valid_path?(source, target, board)
    candidates = movable_items(source).select { |pos| board.empty?(pos) }
    captured_candidates = capturable_items(source).reject do |pos|
      board.empty?(pos) || board.select_piece_from(pos).white? == white?
    end

    candidates.include?(target) || captured_candidates.include?(target)
  end

  def move_item(source, param)
    [source[0] + param[0], source[1] + param[1]]
  end

  def movable_items(source)
    array = [
      [source[0] + @additive_factor, source[1]]
    ]

    array.push([source[0] + (@additive_factor * 2), source[1]]) if @n_movements.zero?

    array.reject { |value| out_of_range?(value) }
  end

  def capturable_items(source)
    [
      [source[0] + @additive_factor, source[1] + 1],
      [source[0] + @additive_factor, source[1] - 1]
    ].reject { |value| out_of_range?(value) }
  end
end
