# frozen_string_literal: true

class Piece
  def initialize(white, symbol)
    @white = white
    @symbol = symbol
    @n_movements = 0
  end

  def update; end

  def valid_movement?(_src, _tge, _board)
    true
  end

  def white?
    @white
  end

  def to_s
    @symbol
  end

  private

  def movable_items; end
  def capturable_items; end
end
