# frozen_string_literal: true

class Piece
  attr_reader :white

  def initialize(white)
    @white = white
    @symbol = @white ? " \u2659  ".gray : " \u2659  ".black
    @n_movements = 0
  end

  def move; end

  def valid_movement?(_src, _tge, _board)
    true
  end

  def candidates; end

  def to_s
    @symbol
  end
end
