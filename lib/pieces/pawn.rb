# frozen_string_literal: true

require './lib/pieces/piece'

class Pawn < Piece
  CODE_POINT = " \u2659  "

  def initialize(white)
    super(white, white ? CODE_POINT.gray : CODE_POINT.black)
    @additive_factor = white ? -1 : 1
  end

  # TODO
  def en_passant; end
  # TODO
  def promotion; end

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
