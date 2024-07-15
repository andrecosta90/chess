# frozen_string_literal: true

require './lib/pieces/piece'

class Pawn < Piece
  def initialize(white)
    super(white, white ? " \u2659  ".gray : " \u2659  ".black)
    @additive_factor = white ? -1 : 1
  end

  def update
    @n_movements += 1
  end

  def valid_movement?(source, target, board)
    candidates = movable_items(source).select { |pos| board.empty?(pos) }
    captured_candidates = capturable_items(source).reject do |pos|
      board.empty?(pos) || board.select_piece_from(pos).white? == white?
    end

    candidates.include?(target) || captured_candidates.include?(target)
  end

  private

  def movable_items(source)
    array = [
      [source[0] + @additive_factor, source[1]]
    ]

    array.push([source[0] + (@additive_factor * 2), source[1]]) if @n_movements.zero?

    array
  end

  def capturable_items(source)
    [
      [source[0] + @additive_factor, source[1] + 1],
      [source[0] + @additive_factor, source[1] - 1]
    ]
  end
end
