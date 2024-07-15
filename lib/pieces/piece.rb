# frozen_string_literal: true

class Piece
  def initialize(white, symbol)
    @white = white
    @symbol = symbol
    @n_movements = 0
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

  def white?
    @white
  end

  def to_s
    @symbol
  end

  private

  def out_of_range?(value)
    value.negative? || value > 7
  end

  def movable_items; end
  def capturable_items; end
end
